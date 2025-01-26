/*
	This query creates a three-column table with random float values, including both positive and negative numbers.
	@scale_parameter_1: This parameter is used to scale the range of the parameter @column_scale_parameter_1.
	@scale_parameter_2: This parameter is used to scale the range of the parameter @column_scale_parameter_2.
	@scale_parameter_3: This parameter is used to scale the range of the parameter @column_scale_parameter_3.
	@column_scale_parameter_1: This parameter scales the range of random integers in the first column.
	@column_scale_parameter_2: This parameter scales the range of random integers in the second column.
	@column_scale_parameter_3: This parameter scales the range of random integers in the third column.
	@rows: This parameter specifies the number of rows to be generated in the table.
	@counter: A parameter used as a loop counter.
*/

DECLARE @scale_parameter_1 INT,
		@scale_parameter_2 INT,
		@scale_parameter_3 INT;

SET @scale_parameter_1 = 10;
SET @scale_parameter_2 = 1000;
SET @scale_parameter_3 = 100;

DECLARE @column_scale_parameter_1 INT,
		@column_scale_parameter_2 INT,
		@column_scale_parameter_3 INT;

SET @column_scale_parameter_1 = ROUND(@scale_parameter_1 * RAND(), 0);
SET @column_scale_parameter_2 = ROUND(@scale_parameter_2 * RAND(), 0);
SET @column_scale_parameter_3 = ROUND(@scale_parameter_3 * RAND(), 0);

DECLARE @rows INT, 
		@counter INT;

SET @rows = 1000;
SET @counter = 1;

DECLARE @RandomTable TABLE (
	column_1 FLOAT,
	column_2 FLOAT,
	column_3 FLOAT
);

WHILE (@counter <= @rows)
BEGIN
	INSERT INTO @RandomTable
	VALUES (
		(2 * ROUND(RAND(), 0) - 1) * @column_scale_parameter_1 * RAND(), 
		(2 * ROUND(RAND(), 0) - 1) * @column_scale_parameter_2 * RAND(),
		(2 * ROUND(RAND(), 0) - 1) * @column_scale_parameter_3 * RAND()
	)
	SET @counter = @counter + 1
END;

SELECT *
FROM @RandomTable;