/*
	This query creates a five-column table with random integer values, including both positive and negative numbers.
	@scale_parameter_1: This parameter is used to scale the range of the parameter @column_scale_parameter_1.
	@scale_parameter_2: This parameter is used to scale the range of the parameter @column_scale_parameter_2.
	@scale_parameter_3: This parameter is used to scale the range of the parameter @column_scale_parameter_3.
	@scale_parameter_4: This parameter is used to scale the range of the parameter @column_scale_parameter_4.
	@scale_parameter_5: This parameter is used to scale the range of the parameter @column_scale_parameter_5.
	@column_scale_parameter_1: This parameter scales the range of random integers in the first column.
	@column_scale_parameter_2: This parameter scales the range of random integers in the second column.
	@column_scale_parameter_3: This parameter scales the range of random integers in the third column.
	@column_scale_parameter_4: This parameter scales the range of random integers in the fourth column.
	@column_scale_parameter_5: This parameter scales the range of random integers in the fifth column.
	@rows: This parameter specifies the number of rows to be generated in the table.
	@counter: A parameter used as a loop counter.
*/

DROP TABLE IF EXISTS [dbo].[RandomTable];

DECLARE @scale_parameter_1 INT,
		@scale_parameter_2 INT,
		@scale_parameter_3 INT,
		@scale_parameter_4 INT,
		@scale_parameter_5 INT;

SET @scale_parameter_1 = 10;
SET @scale_parameter_2 = 1000;
SET @scale_parameter_3 = 100;
SET @scale_parameter_4 = 10000;
SET @scale_parameter_5 = 1000000;

DECLARE @column_scale_parameter_1 INT,
		@column_scale_parameter_2 INT,
		@column_scale_parameter_3 INT,
		@column_scale_parameter_4 INT,
		@column_scale_parameter_5 INT;

SET @column_scale_parameter_1 = ROUND(@scale_parameter_1 * RAND(), 0);
SET @column_scale_parameter_2 = ROUND(@scale_parameter_2 * RAND(), 0);
SET @column_scale_parameter_3 = ROUND(@scale_parameter_3 * RAND(), 0);
SET @column_scale_parameter_4 = ROUND(@scale_parameter_4 * RAND(), 0);
SET @column_scale_parameter_5 = ROUND(@scale_parameter_5 * RAND(), 0);

DECLARE @rows INT, 
		@counter INT;

SET @rows = 1000;
SET @counter = 1;

CREATE TABLE RandomTable (
	column_1 INT,
	column_2 INT,
	column_3 INT,
	column_4 INT,
	column_5 INT
);

WHILE (@counter <= @rows)
BEGIN
	INSERT INTO RandomTable
	VALUES (
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_1 * RAND(), 0), 
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_2 * RAND(), 0),
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_3 * RAND(), 0),
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_4 * RAND(), 0),
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_5 * RAND(), 0)
	)
	SET @counter = @counter + 1
END;