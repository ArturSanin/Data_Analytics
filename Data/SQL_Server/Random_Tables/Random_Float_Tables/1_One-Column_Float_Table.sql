/*
	This query creates a one-column table with random float values.
	@table_type: Has to be positive, negative or both. This parameter determines whether the values in the table are 
	only positive (including zero), only negative (including zero), or both (including zero).
	@scale_parameter: This parameter is used to scale the range of the parameter @column_scale_parameter.
	@column_scale_parameter: This parameter is used to scale the range of the random float values in the column.
	@decimal_places: Sets the number of decimal places for the values in the column.
	@rows: This parameter specifies the number of rows to be generated in the table.
	@counter: A parameter used as a loop counter.
*/

DECLARE @table_type VARCHAR(8);

SET @table_type = 'both';

DECLARE @scale_parameter INT;

SET @scale_parameter = 10;

DECLARE @column_scale_parameter INT;

SET @column_scale_parameter = ROUND(@scale_parameter * RAND(), 0);

DECLARE @decimal_places INT;

SET @decimal_places = 1;

DECLARE @rows INT, 
		@counter INT;

SET @rows = 1000;
SET @counter = 1;

DECLARE @RandomTable TABLE (
	column_1 FLOAT
);

WHILE (@counter <= @rows)
BEGIN
	IF @table_type = 'positive' 
		INSERT INTO @RandomTable
		VALUES (
			ROUND(@column_scale_parameter * RAND(), @decimal_places) 
		);
	IF @table_type = 'negative' 
		INSERT INTO @RandomTable
		VALUES (
			(-1) * ROUND(@column_scale_parameter * RAND(), @decimal_places) 
		);
	IF @table_type = 'both' 
		INSERT INTO @RandomTable
		VALUES (
			(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter * RAND(), @decimal_places) 
		);
	SET @counter = @counter + 1;
END;

IF @table_type IN ('positive', 'negative', 'both')
	SELECT *
	FROM @RandomTable;
ELSE 
	SELECT '@table_type has to be one of the following values: positive, negative or both.' AS Error;