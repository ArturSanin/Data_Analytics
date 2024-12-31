/* 
	This query returns count statistics and the relative frequencies computed for a numerical column containing only integer values.
*/



-- Table variable for inserting the integer-valued column.
DECLARE @tmp_integer_column TABLE (
	numerical_column INT
)



INSERT INTO @tmp_integer_column
VALUES 
 (771792),(883235),(848884),(258128),(NULL),(868202),(857135),(- 57120),(999931),(270582),(524010),(- 966751),(843895),(798051),(- 451473),(872111),(356307),(170909),(0),(984259),(999931),(147124),(101285),(268122),(394564),(826370),(392663),(1264),(775587),(644840),(426167),(284639),(NULL),(978890),(177920),(773525),(468653),(999931),(999931),(536669),(952119),(968770),(426748),(44149),(345819),(NULL),(846560),(999931),(188728),(914815),(28176),(266431),(966807),(237769),(957784),(907452),(136301),(652938),(724337),(273322),(424270),(645225),(358901),(637509),(0),(279945),(118496),(774906),(595434),(286664),(282171),(NULL),(247753),(665812),(439327),(69191),(453700),(627871),(544049),(210865),(696216),(709246),(197548),(989274),(496341),(566689),(477725),(408362),(161637),(956525),(222867),(26823),(964091),(NULL),(NULL),(NULL),(764513),(611145),(860642),(257665),(252794),(993815),(297010),(257967),(0),(597934),(889192),(286640),(524172),(335786),(449171),(0),(0),(297037),(827634),(950881),(66620),(206922),(569891),(212636),(NULL),(966288),(NULL),(825119),(509174),(982207),(NULL),(NULL),(NULL),(NULL),(571303),(354185),(917275),(354567),(294231),(862560),(781268),(126047),(253751),(798312),(881002),(51470),(252657),(605411),(187886),(592880),(845793),(321216),(358896),(792676),(179105),(71562),(141600),(388137),(301902),(917817),(429960),(535689),(2863),(712410),(954899),(83490),(48827),(254391),(812639),(363963),(549784),(307641),(915754),(217014),(571368),(389218),(123939),(310081),(567111),(104813),(635909),(598980),(866538),(601896),(304929),(479480),(893335),(489322),(321576),(767603),(653021),(208461),(437675),(855718),(840124),(56760),(753347),(65091),(427135),(48817),(345377),(709648),(855189),(857896),(165285),(517652),(911622),(899266),(677624),(720836),(96275),(513670),(78799),(342340),(104338),(436819),(682863),(260593),(209333),(666062),(353033),(398357),(38743),(462589),(947977),(872089),(792766),(356910),(870946),(280363),(404435),(936439),(24473),(208410),(155689),(534514),(750011),(83381),(848124),(409263),(585442),(454662),(926670),(592751),(311329),(358113),(152340),(40638),(469582),(280769),(353156)




-- Defining the schema for the table that contains the count statistics.
DECLARE @column_count_statistics TABLE (
	values_count INT -- The total number of values in the column.
	,negative_values_count INT -- The number of values in the column that are smaller than zero.
	,negative_values_count_relative_frequency FLOAT -- The relative frequency of values in the column that are smaller than zero.
	,negative_values_count_relative_frequency_percent FLOAT -- The relative frequency of values in the column that are smaller than zero, expressed as a percentage.
	,zero_count INT -- The number of values in the column that are equal to zero.
	,zero_count_relative_frequency FLOAT -- The relative frequency of values in the column that are equal to zero.
	,zero_count_relative_frequency_percent FLOAT -- The relative frequency of values in the column that are equal to zero, expressed as a percentage.
	,positive_values_count INT -- The number of values greater than zero.
	,positive_values_count_relative_frequency FLOAT -- The relative frequency of values in the column that are greater than zero.
	,positive_values_count_relative_frequency_percent FLOAT -- The relative frequency of values in the column that are greater than zero, expressed as a percentage.
	,even_values_count INT -- The number of even values in the column.
	,even_values_count_relative_frequency FLOAT -- The relative frequency of even values in the column.
	,even_values_count_relative_frequency_percent FLOAT -- The relative frequency of even values in the column, expressed as a percantage.
	,odd_values_count INT -- The number of odd values in the column.
	,odd_values_count_relative_frequency FLOAT -- The relative frequency of odd values in the column.
	,odd_values_count_relative_frequency_percent FLOAT -- The relative frequency of odd values in the column, expressed as a percantage.
	,null_values_count INT -- The number of NULL values in the column.
	,null_values_count_relative_frequency FLOAT -- The relative frequency of NULL values in the column.
	,null_values_count_relative_frequency_percent FLOAT -- The relative frequency of NULL values in the column, expressed as a percantage.
	,not_null_values_count INT -- The number of values in the column not NULL.
	,not_null_values_count_relative_frequency FLOAT -- The relative frequency of values in the column not NULL.
	,not_null_values_count_relative_frequency_percent FLOAT -- The relative frequency of values in the column not NULL, expressed as a percantage.
	,distinct_values_count INT -- The number of distinct values in the column.
	,distinct_values_count_relative_frequency FLOAT -- The relative frequency of distinct values in the column.
	,distinct_values_count_relative_frequency_percent FLOAT -- The relative frequency of distinct values in the column, expressed as a percantage.
	,unique_values_count INT -- The number of unique values in the column.
	,unique_values_count_relative_frequency FLOAT -- The relative frequency of unique values in the column.
	,unique_values_count_relative_frequency_percent FLOAT -- The relative frequency of unique values in the column, expressed as a percantage.
	,minimum INT -- The minimal value in the column.
	,minimum_count INT -- The number of times the minimum value occurs in the column.
	,minimum_count_relative_frequency FLOAT -- The relative frequency of the minimum value in the column.
	,minimum_count_relative_frequency_percent FLOAT -- The relative frequency of the minimum value in the column, expressed as a percantage.
	,maximum INT -- The maximal value in the column.
	,maximum_count INT -- The number of times the maximum value occurs in the column.
	,maximum_count_relative_frequency FLOAT -- The relative frequency of the maximum value in the column.
	,maximum_count_relative_frequency_percent FLOAT -- The relative frequency of the maximum value in the column, expressed as a percantage.
	,mode INT -- One value of the mode of the column.
	,mode_count INT -- The count of occurrences of the highest value in the column. 
	,under_columns_mean_count INT -- The number of values in the column under the column's mean.
	,under_columns_mean_count_relative_frequency FLOAT -- The relative frequency of values under the column's mean.
	,under_columns_mean_count_relative_frequency_percent FLOAT -- The relative frequency of values under the column's mean, expressed as a percantage.
	,above_columns_mean_count INT -- The number of values in the column above the column's mean.
	,above_columns_mean_count_relative_frequency FLOAT -- The relative frequency of values above the column's mean.
	,above_columns_mean_count_relative_frequency_percent FLOAT -- The relative frequency of values above the column's mean, expressed as a percantage.
)



INSERT INTO @column_count_statistics
SELECT DISTINCT
	(SELECT COUNT(*) FROM @tmp_integer_column) -- Counts the total number of values in the column.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] < 0) -- Counts the number of entries smaller then 0.
	,ROUND((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column WHERE [numerical_column] < 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of values less than zero.
	,ROUND(100 * ((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column WHERE [numerical_column] < 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of values less than zero, expressed as a percentage.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = 0) -- Counts the number of entries equal 0.
	,ROUND((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column WHERE [numerical_column] = 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of values euqal to zero.
	,ROUND(100 * ((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column WHERE [numerical_column] = 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of values equal to zero, expressed as a percentage.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] > 0) -- Counts the number of entries greater then 0.
	,ROUND((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column WHERE [numerical_column] > 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of values greater than zero.
	,ROUND(100 * ((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column WHERE [numerical_column] > 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of values greater than zero, expressed as a percentage.
	,(SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 0) AS even_values) -- Counts the number of even values in the column.
	,ROUND((SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 0) AS even_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of even values in the column.
	,ROUND(100 * ((SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 0) AS even_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of even values in the column, expressed as a percentage.
	,(SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 1) AS odd_values) -- Counts the number of odd values in the column.
	,ROUND((SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 1) AS odd_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of odd values in the column.
	,ROUND(100 * ((SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 1) AS odd_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of odd values in the column, expressed as a percentage.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NULL) -- Counts the number of NULL values in the column.
	,ROUND((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of NULL values.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of NULL values, expressed as a percantage.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NOT NULL) -- Counts the number of not NULL values.
	,ROUND((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NOT NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of not NULL values.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NOT NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of not NULL values, expressed as a percantage.
	,(SELECT COUNT(*) FROM (SELECT DISTINCT [numerical_column] FROM @tmp_integer_column) AS distinct_values) -- Counts the number of distinct values.
	,ROUND((SELECT COUNT(*) FROM (SELECT DISTINCT [numerical_column] FROM @tmp_integer_column) AS distinct_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of distinct values.
	,ROUND(100 * ((SELECT COUNT(*) FROM (SELECT DISTINCT [numerical_column] FROM @tmp_integer_column) AS distinct_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of distinct values, expressed as a percantage.
	,(SELECT COUNT(*) FROM (SELECT COUNT([numerical_column]) AS value_count FROM @tmp_integer_column GROUP BY [numerical_column]) AS grouped_values WHERE value_count = 1) -- Counts the number of unique values.
	,ROUND((SELECT COUNT(*) FROM (SELECT COUNT([numerical_column]) AS value_count FROM @tmp_integer_column GROUP BY [numerical_column]) AS grouped_values WHERE value_count = 1) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of unique values.
	,ROUND(100 * ((SELECT COUNT(*) FROM (SELECT COUNT([numerical_column]) AS value_count FROM @tmp_integer_column GROUP BY [numerical_column]) AS grouped_values WHERE value_count = 1) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of unique values, expressed as a percantage.
	,MIN([numerical_column]) -- Calculates the minimum of the column.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MIN([numerical_column]) FROM @tmp_integer_column)) -- Counts the number of times the minimum value occurs in the column.
	,ROUND((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MIN([numerical_column]) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of the minimum value.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MIN([numerical_column]) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of the minimum value, expressed as a percantage.
	,MAX([numerical_column]) -- Calculates the maximum of the column.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MAX([numerical_column]) FROM @tmp_integer_column)) -- Counts the number of times the maximum value occurs in the column.
	,ROUND((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MAX([numerical_column]) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of the maximum value.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MAX([numerical_column]) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of the maximum value, expressed as a percantage.
	,(SELECT [numerical_column] FROM (SELECT TOP 1 [numerical_column], COUNT([numerical_column]) AS C FROM @tmp_integer_column GROUP BY [numerical_column] ORDER BY COUNT([numerical_column]) DESC) AS ordered_group_values) -- Returns one mode value of the column.
	,(SELECT C FROM (SELECT TOP 1 [numerical_column], COUNT([numerical_column]) AS C FROM @tmp_integer_column GROUP BY [numerical_column] ORDER BY COUNT([numerical_column]) DESC) AS ordered_group_values) -- Returns the count of the mode value.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] < (SELECT AVG(CAST([numerical_column] AS FLOAT)) FROM @tmp_integer_column)) -- Counts the number of values under the column's mean.
	,ROUND((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] < (SELECT AVG(CAST([numerical_column] AS FLOAT)) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of the values under the column's mean.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] < (SELECT AVG(CAST([numerical_column] AS FLOAT)) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of the values under the column's mean, expressed as a percantage.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] > (SELECT AVG(CAST([numerical_column] AS FLOAT)) FROM @tmp_integer_column)) -- Counts the number of values above the column's mean.
	,ROUND((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] > (SELECT AVG(CAST([numerical_column] AS FLOAT)) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column), 4) -- Calculates the relative frequency of the values under the column's mean.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] > (SELECT AVG(CAST([numerical_column] AS FLOAT)) FROM @tmp_integer_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_integer_column)), 2) -- Calculates the relative frequency of the values under the column's mean, expressed as a percantage.
FROM @tmp_integer_column



SELECT *
FROM @column_count_statistics
