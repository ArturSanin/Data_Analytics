/* 
	This query returns statistics computed for a numerical column containing only integer values.
*/



-- Table variable for inserting the integer-valued column.
DECLARE @tmp_integer_column TABLE (
	numerical_column INT
)



INSERT INTO @tmp_integer_column
VALUES 
 (771792),(883235),(848884),(258128),(868202),(857135),(57120),(270582),(524010),(966751),(843895),(798051),(451473),(872111),(356307),(170909),(984259),(999931),(147124),(101285),(268122),(394564),(826370),(392663),(1264),(775587),(644840),(426167),(284639),(978890),(177920),(773525),(468653),(536669),(952119),(968770),(426748),(44149),(345819),(846560),(188728),(914815),(28176),(266431),(966807),(237769),(957784),(907452),(136301),(652938),(724337),(273322),(424270),(645225),(358901),(637509),(279945),(118496),(774906),(595434),(286664),(282171),(247753),(665812),(439327),(69191),(453700),(627871),(544049),(210865),(696216),(709246),(197548),(989274),(496341),(566689),(477725),(408362),(161637),(956525),(222867),(26823),(964091),(764513),(611145),(860642),(257665),(252794),(993815),(297010),(257967),(597934),(889192),(286640),(524172),(335786),(449171),(297037),(827634),(950881),(66620),(206922),(569891),(212636),(966288),(825119),(509174),(982207),(571303),(354185),(917275),(354567),(294231),(862560),(781268),(126047),(253751),(798312),(881002),(51470),(252657),(605411),(187886),(592880),(845793),(321216),(358896),(792676),(179105),(71562),(141600),(388137),(301902),(917817),(429960),(535689),(2863),(712410),(954899),(83490),(48827),(254391),(812639),(363963),(549784),(307641),(915754),(217014),(571368),(389218),(123939),(310081),(567111),(104813),(635909),(598980),(866538),(601896),(304929),(479480),(893335),(489322),(321576),(767603),(653021),(208461),(437675),(855718),(840124),(56760),(753347),(65091),(427135),(48817),(345377),(709648),(855189),(857896),(165285),(517652),(911622),(899266),(677624),(720836),(96275),(513670),(78799),(342340),(104338),(436819),(682863),(260593),(209333),(666062),(353033),(398357),(38743),(462589),(947977),(872089),(792766),(356910),(870946),(280363),(404435),(936439),(24473),(208410),(155689),(534514),(750011),(83381),(848124),(409263),(585442),(454662),(926670),(592751),(311329),(358113),(152340),(40638),(469582),(280769),(353156)




-- Defining the schema for the table that contains the statistics.
DECLARE @column_statistics TABLE (
	value_count INT -- Returns the number of entries in the column.
	,value_count_parity VARCHAR(4) -- Returns the parity of the number of entries
	,values_smaller_zero INT -- Returns the number of values in the column smaller then 0.
	,zero_count INT -- Returns the number of values equal 0.
	,values_greater_zero INT -- Returns the number of values in the column greater then 0.
	,even_values_count INT -- Returns the number of even values in the column.
	,odd_values_count INT -- Returns the number of odd values in the column.
	,only_positiv_values VARCHAR(5) -- Returns True if all values are positive ( > 0 ).
	,only_negativ_values VARCHAR(5) -- Returns True if all values are negative ( < 0 ).
	,null_values_count INT -- Returns the number of missing values in the column.
	,not_null_values_count INT -- Returns the number of values not null.
	,distinct_values_count INT -- Returns the number of distinct values in the column.
	,unique_values_count INT -- Returns the number of unique values in the column.
	,minimum INT -- The minimal value in the column.
	,minimum_count INT -- Number of times the minimum value occurs in the column.
	,maximum INT -- The maximal value in the column.
	,maximum_count INT -- Number of times the maximum value occurs in the column.
	,column_range INT -- The value range of the column.
	,mean FLOAT -- The columns mean.
	,variance FLOAT -- The columns variance.
	,standard_deviation FLOAT -- Standard deviation of the column.
	,column_sum INT -- The sum of the values in the column.
	,modus INT -- One value of the modus of the column.
	,average_absolute_deviation FLOAT -- The average absolute deviation of the column.
	--,median DECIMAL -- Median of the column.
	--,percentile_25 FLOAT
)



INSERT INTO @column_statistics
SELECT DISTINCT
	(SELECT COUNT(*) FROM @tmp_integer_column) -- Calculates the number of entries in the column.
	,CASE
		WHEN (SELECT COUNT(*) FROM @tmp_integer_column) % 2 = 0 THEN 'even'
		ELSE 'odd'
	END
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] < 0) -- Calculates the number of entries smaller then 0.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = 0) -- Calculates the number of entries equal 0.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] > 0) -- Calculates the number of entries greater then 0.
	,(SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 0) AS even_values) -- Calculates how many even values are in the column.
	,(SELECT COUNT(*) FROM (SELECT [numerical_column] FROM @tmp_integer_column WHERE [numerical_column] % 2 = 1) AS odd_values) -- Calculates how many odd values are in the column.
	,CASE 
		WHEN 0 IN (SELECT [numerical_column] FROM @tmp_integer_column) THEN 'False'
		WHEN (SELECT COUNT([numerical_column]) FROM @tmp_integer_column WHERE [numerical_column] < 0) = 0 THEN 'True'
		ELSE 'False'
	END -- Checks if all values in the column are positive.
	,CASE 
		WHEN 0 IN (SELECT [numerical_column] FROM @tmp_integer_column) THEN 'False'
		WHEN (SELECT COUNT([numerical_column]) FROM @tmp_integer_column WHERE [numerical_column] > 0) = 0 THEN 'True'
		ELSE 'False'
	END -- Checks if all values in the column are negative.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NULL) -- Calculates the number of entries missing.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] IS NOT NULL) -- Calculates the number of not missing entries.
	,(SELECT COUNT(*) FROM (SELECT DISTINCT [numerical_column] FROM @tmp_integer_column) AS distinct_values) -- Calculates the number of distinct values in the column.
	,(SELECT COUNT(*) FROM (SELECT COUNT([numerical_column]) AS value_count FROM @tmp_integer_column GROUP BY [numerical_column]) AS grouped_values WHERE value_count = 1) -- Calculates the number of unique values in the column.
	,MIN([numerical_column]) -- Calculates the minimum of the column.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MIN([numerical_column]) FROM @tmp_integer_column)) -- Calculates how many times the minimum value occurs in the column.
	,MAX([numerical_column]) -- Calculates the maximum of the column.
	,(SELECT COUNT(*) FROM @tmp_integer_column WHERE [numerical_column] = (SELECT MAX([numerical_column]) FROM @tmp_integer_column)) -- Calculates how many times the maximum value occurs in the column.
	,MAX([numerical_column]) - MIN([numerical_column]) -- Calculates the range of the column, which is the difference between the minimum and the maximum.
	,Round(AVG(CAST([numerical_column] AS FLOAT)), 2) -- Calculates the mean of the column rounded to two decimal places.
	,Round(VAR(CAST([numerical_column] AS FLOAT)), 2) -- Calculates the variance of the column rounded to two decimal places.
	,Round(STDEV(CAST([numerical_column] AS FLOAT)), 2) -- Calculates the standard deviation of the column rounded to two decimal places.
	,SUM([numerical_column]) -- Calculates the sum of the values in the column.
	,(SELECT [numerical_column] FROM (SELECT TOP 1 [numerical_column], COUNT([numerical_column]) AS C FROM @tmp_integer_column GROUP BY [numerical_column] ORDER BY COUNT([numerical_column]) DESC) AS ordered_group_values) -- Returns one modus value of the column.
	,(SELECT ROUND((SELECT AVG(abs_diff) FROM (SELECT ABS(diff) AS abs_diff FROM (SELECT [numerical_column] - (SELECT AVG(CAST([numerical_column] AS FLOAT)) FROM @tmp_integer_column) AS diff FROM @tmp_integer_column) AS T) AS P), 2)) -- Calculates the average absolute deviation of the column.
FROM @tmp_integer_column



SELECT *
FROM @column_statistics
