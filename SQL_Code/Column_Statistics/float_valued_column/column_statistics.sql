/* 
	This query returns statistics computed for a numerical column containing values of datatype float.
*/



-- Table variable for inserting the integer-valued column.
DECLARE @tmp_float_column TABLE (
	numerical_column FLOAT
)



INSERT INTO @tmp_float_column
VALUES 
(834.24), (916.13), (949.33), (198.00), (53.43), (750.71), (700.57), (641.91), (416.61), (205.38), (392.55), (247.72), (127.84), (741.78), (903.97), (259.39), (154.50), (60.64), (998.43), (261.92), (929.71), (549.85), (113.97), (351.10), (324.89), (106.59), (828.51), (779.99), (780.71), (280.32), (726.36), (362.40), (225.43), (931.33), (336.66), (77.16), (400.74), (183.14), (733.89), (125.14), (563.31)



-- Defining the schema for the table that contains the statistics.
DECLARE @column_statistics TABLE (
	values_count INT -- The total number of values in the column.
	,values_count_parity VARCHAR(4) -- The parity (even or odd) of the total number of values in the column.
	,negative_values_count INT -- The number of values in the column that are smaller than zero.
	,negative_values_count_relative_frequency FLOAT -- The relative frequency of values in the column that are smaller than zero.
	,negative_values_count_relative_frequency_percent FLOAT -- The relative frequency of values in the column that are smaller than zero, expressed as a percentage.
	,zero_count INT -- The number of values in the column that are equal to zero.
	,zero_count_relative_frequency FLOAT -- The relative frequency of values in the column that are equal to zero.
	,zero_count_relative_frequency_percent FLOAT -- The relative frequency of values in the column that are equal to zero, expressed as a percentage.
	,positive_values_count INT -- The number of values greater than zero.
	,positive_values_count_relative_frequency FLOAT -- The relative frequency of values in the column that are greater than zero.
	,positive_values_count_relative_frequency_percent FLOAT -- The relative frequency of values in the column that are greater than zero, expressed as a percentage.
	,mixed_values VARCHAR(5) -- True if the values consist of both positive and negative values.
	,only_positiv_values VARCHAR(5) -- True if all values are positive ( > 0 ).
	,only_negativ_values VARCHAR(5) -- True if all values are negative ( < 0 ).
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
	,minimum FLOAT -- The minimal value in the column.
	,minimum_count INT -- The number of times the minimum value occurs in the column.
	,minimum_count_relative_frequency FLOAT -- The relative frequency of the minimum value in the column.
	,minimum_count_relative_frequency_percent FLOAT -- The relative frequency of the minimum value in the column, expressed as a percantage.
	,maximum FLOAT -- The maximal value in the column.
	,maximum_count INT -- The number of times the maximum value occurs in the column.
	,maximum_count_relative_frequency FLOAT -- The relative frequency of the maximum value in the column.
	,maximum_count_relative_frequency_percent FLOAT -- The relative frequency of the maximum value in the column, expressed as a percantage.
	,value_range FLOAT -- The value range of the column.
	,modus FLOAT -- One value of the modus of the column.
	,column_sum FLOAT -- The sum of the values in the column.
	,mean FLOAT -- The columns mean.
	,under_columns_mean_count INT -- The number of values in the column under the column's mean.
	,under_columns_mean_count_relative_frequency FLOAT -- The relative frequency of values under the column's mean.
	,under_columns_mean_count_relative_frequency_percent FLOAT -- The relative frequency of values under the column's mean, expressed as a percantage.
	,above_columns_mean_count INT -- The number of values in the column above the column's mean.
	,above_columns_mean_count_relative_frequency FLOAT -- The relative frequency of values above the column's mean.
	,above_columns_mean_count_relative_frequency_percent FLOAT -- The relative frequency of values above the column's mean, expressed as a percantage.
	,variance FLOAT -- The columns variance.
	,standard_deviation FLOAT -- Standard deviation of the column.
	,percentile_25 FLOAT -- The 25th percentile.
	,percentile_50 FLOAT -- The 50th percentile (Median).
	,percentile_75 FLOAT -- The 75th percentile.
	,interquartile_range FLOAT -- The Interquartile range (percentile_75 - percentile_25).
	,average_absolute_deviation FLOAT -- The average absolute deviation of the column.
)



INSERT INTO @column_statistics
SELECT DISTINCT
	(SELECT COUNT(*) FROM @tmp_float_column) -- Counts the total number of values in the column.
	,CASE
		WHEN (SELECT COUNT(*) FROM @tmp_float_column) % 2 = 0 THEN 'even'
		ELSE 'odd'
	END -- Returns the parity (even or odd) of the total number of values in the column.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] < 0) -- Counts the number of entries smaller then 0.
	,ROUND((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column WHERE [numerical_column] < 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of values less than zero.
	,ROUND(100 * ((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column WHERE [numerical_column] < 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of values less than zero, expressed as a percentage.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] = 0) -- Counts the number of entries equal 0.
	,ROUND((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column WHERE [numerical_column] = 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of values euqal to zero.
	,ROUND(100 * ((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column WHERE [numerical_column] = 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of values equal to zero, expressed as a percentage.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] > 0) -- Counts the number of entries greater then 0.
	,ROUND((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column WHERE [numerical_column] > 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of values greater than zero.
	,ROUND(100 * ((SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column WHERE [numerical_column] > 0) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of values greater than zero, expressed as a percentage.
	,CASE 
		WHEN 0 IN (SELECT [numerical_column] FROM @tmp_float_column) THEN 'True'
		WHEN ((SELECT COUNT([numerical_column]) FROM @tmp_float_column WHERE [numerical_column] < 0) > 0) AND ((SELECT COUNT([numerical_column]) FROM @tmp_float_column WHERE [numerical_column] > 0) > 0) THEN 'True'
		ELSE 'False'
	END -- Checks if the values in the column consist of both negative and positive values.
	,CASE 
		WHEN 0 IN (SELECT [numerical_column] FROM @tmp_float_column) THEN 'False'
		WHEN (SELECT COUNT([numerical_column]) FROM @tmp_float_column WHERE [numerical_column] < 0) = 0 THEN 'True'
		ELSE 'False'
	END -- Checks if all values in the column are positive.
	,CASE 
		WHEN 0 IN (SELECT [numerical_column] FROM @tmp_float_column) THEN 'False'
		WHEN (SELECT COUNT([numerical_column]) FROM @tmp_float_column WHERE [numerical_column] > 0) = 0 THEN 'True'
		ELSE 'False'
	END -- Checks if all values in the column are negative.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] IS NULL) -- Counts the number of NULL values in the column.
	,ROUND((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] IS NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of NULL values.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] IS NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of NULL values, expressed as a percantage.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] IS NOT NULL) -- Counts the number of not NULL values.
	,ROUND((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] IS NOT NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of not NULL values.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] IS NOT NULL) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of not NULL values, expressed as a percantage.
	,(SELECT COUNT(*) FROM (SELECT DISTINCT [numerical_column] FROM @tmp_float_column) AS distinct_values) -- Counts the number of distinct values.
	,ROUND((SELECT COUNT(*) FROM (SELECT DISTINCT [numerical_column] FROM @tmp_float_column) AS distinct_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of distinct values.
	,ROUND(100 * ((SELECT COUNT(*) FROM (SELECT DISTINCT [numerical_column] FROM @tmp_float_column) AS distinct_values) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of distinct values, expressed as a percantage.
	,(SELECT COUNT(*) FROM (SELECT COUNT([numerical_column]) AS value_count FROM @tmp_float_column GROUP BY [numerical_column]) AS grouped_values WHERE value_count = 1) -- Counts the number of unique values.
	,ROUND((SELECT COUNT(*) FROM (SELECT COUNT([numerical_column]) AS value_count FROM @tmp_float_column GROUP BY [numerical_column]) AS grouped_values WHERE value_count = 1) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of unique values.
	,ROUND(100 * ((SELECT COUNT(*) FROM (SELECT COUNT([numerical_column]) AS value_count FROM @tmp_float_column GROUP BY [numerical_column]) AS grouped_values WHERE value_count = 1) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of unique values, expressed as a percantage.
	,MIN([numerical_column]) -- Calculates the minimum of the column.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] = (SELECT MIN([numerical_column]) FROM @tmp_float_column)) -- Counts the number of times the minimum value occurs in the column.
	,ROUND((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] = (SELECT MIN([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of the minimum value.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] = (SELECT MIN([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of the minimum value, expressed as a percantage.
	,MAX([numerical_column]) -- Calculates the maximum of the column.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] = (SELECT MAX([numerical_column]) FROM @tmp_float_column)) -- Counts the number of times the maximum value occurs in the column.
	,ROUND((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] = (SELECT MAX([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of the maximum value.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] = (SELECT MAX([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of the maximum value, expressed as a percantage.
	,MAX([numerical_column]) - MIN([numerical_column]) -- Calculates the range of the column, which is the difference between the minimum and the maximum.
	,(SELECT [numerical_column] FROM (SELECT TOP 1 [numerical_column], COUNT([numerical_column]) AS C FROM @tmp_float_column GROUP BY [numerical_column] ORDER BY COUNT([numerical_column]) DESC) AS ordered_group_values) -- Returns one modus value of the column.
	,SUM([numerical_column]) -- Calculates the sum of the values in the column.
	,ROUND(AVG([numerical_column]), 2) -- Calculates the mean of the column rounded to two decimal places.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] < (SELECT AVG([numerical_column]) FROM @tmp_float_column)) -- Counts the number of values under the column's mean.
	,ROUND((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] < (SELECT AVG([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of the values under the column's mean.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] < (SELECT AVG([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of the values under the column's mean, expressed as a percantage.
	,(SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] > (SELECT AVG([numerical_column]) FROM @tmp_float_column)) -- Counts the number of values above the column's mean.
	,ROUND((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] > (SELECT AVG([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column), 4) -- Calculates the relative frequency of the values under the column's mean.
	,ROUND(100 * ((SELECT COUNT(*) FROM @tmp_float_column WHERE [numerical_column] > (SELECT AVG([numerical_column]) FROM @tmp_float_column)) / (SELECT CAST(COUNT(*) AS FLOAT) FROM @tmp_float_column)), 2) -- Calculates the relative frequency of the values under the column's mean, expressed as a percantage.
	,ROUND(VAR([numerical_column]), 2) -- Calculates the variance of the column rounded to two decimal places.
	,ROUND(STDEV([numerical_column]), 2) -- Calculates the standard deviation of the column rounded to two decimal places.
	,(SELECT DISTINCT ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY [numerical_column]) OVER (), 2) FROM @tmp_float_column) -- Calculates the 25th percentile.
	,(SELECT DISTINCT ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [numerical_column]) OVER (), 2) FROM @tmp_float_column) -- Calculates the 50th percentile (Median).
	,(SELECT DISTINCT ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY [numerical_column]) OVER (), 2) FROM @tmp_float_column) -- Calculates the 75th percentile.
	,(SELECT DISTINCT ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY [numerical_column]) OVER (), 2) FROM @tmp_float_column) - (SELECT DISTINCT ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY [numerical_column]) OVER (), 2) FROM @tmp_float_column) -- Calculates the interquartile range, which is the difference between the 75th and 25th percentiles.
	,(SELECT ROUND((SELECT AVG(abs_diff) FROM (SELECT ABS(diff) AS abs_diff FROM (SELECT [numerical_column] - (SELECT AVG([numerical_column]) FROM @tmp_float_column) AS diff FROM @tmp_float_column) AS T) AS P), 2)) -- Calculates the average absolute deviation of the column.
FROM @tmp_float_column



SELECT *
FROM @column_statistics
