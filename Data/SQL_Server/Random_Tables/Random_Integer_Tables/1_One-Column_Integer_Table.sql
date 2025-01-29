/*
	This query creates a one-column table with random integer values, including both positive and negative numbers.
	@scale_parameter: This parameter is used to scale the range of the parameter @column_scale_parameter.
	@column_scale_parameter: This parameter is used to scale the range of the random integers in the column.
	@rows: This parameter specifies the number of rows to be generated in the table.
	@counter: A parameter used as a loop counter.
*/

DROP TABLE IF EXISTS [dbo].[RandomTable];

DECLARE @scale_parameter INT;

SET @scale_parameter = 10000;

DECLARE @column_scale_parameter INT;

SET @column_scale_parameter = ROUND(@scale_parameter * RAND(), 0);

DECLARE @rows INT, 
		@counter INT;

SET @rows = 1000;
SET @counter = 1;

CREATE TABLE RandomTable (
	column_1 INT
);

WHILE (@counter <= @rows)
BEGIN
	INSERT INTO RandomTable
	VALUES (
		(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter * RAND(), 0)
	)
	SET @counter = @counter + 1
END;