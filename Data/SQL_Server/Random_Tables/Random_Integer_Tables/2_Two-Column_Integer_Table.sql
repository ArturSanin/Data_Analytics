/*
	This query creates a two-column table with random integer values, including both positive and negative numbers.
	@scale_parameter_1: This parameter is used to scale the range of the parameter @column_scale_parameter_1.
	@scale_parameter_2: This parameter is used to scale the range of the parameter @column_scale_parameter_2.
	@column_scale_parameter_1: This parameter scales the range of random integers in the first column.
	@column_scale_parameter_2: This parameter scales the range of random integers in the second column.
	@rows: This parameter specifies the number of rows to be generated in the table.
	@counter: A parameter used as a loop counter.
*/

DECLARE @scale_parameter_1 INT,
		@scale_parameter_2 INT;

SET @scale_parameter_1 = 10000;
SET @scale_parameter_2 = 10;

DECLARE @column_scale_parameter_1 INT,
		@column_scale_parameter_2 INT;

SET @column_scale_parameter_1 = ROUND(@scale_parameter_1 * RAND(), 0);
SET @column_scale_parameter_2 = ROUND(@scale_parameter_2 * RAND(), 0);

DECLARE @rows INT,
		@counter INT;

SET @rows = 1000;
SET @counter = 1;

DECLARE @RandomTable TABLE (
	column_1 INT,
	column_2 INT
);

WHILE (@counter <= @rows)
BEGIN
	INSERT INTO @RandomTable
	VALUES (
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_1 * RAND(), 0), 
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_2 * RAND(), 0)
	)
	SET @counter = @counter + 1
END;

SELECT *
FROM @RandomTable;