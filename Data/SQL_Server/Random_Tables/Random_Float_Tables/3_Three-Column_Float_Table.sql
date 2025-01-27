/*
	This query creates a two-column table with random float values.
	@table_type: Has to be positive, negative or both. This parameter determines whether the values in the table are 
	only positive (including zero), only negative (including zero), or both (including zero).
	@scale_parameter_1: This parameter is used to scale the range of the parameter @column_scale_parameter_1.
	@scale_parameter_2: This parameter is used to scale the range of the parameter @column_scale_parameter_2.
	@scale_parameter_3: This parameter is used to scale the range of the parameter @column_scale_parameter_3.
	@column_scale_parameter_1: This parameter scales the range of the random float values in the first column.
	@column_scale_parameter_2: This parameter scales the range of the random float values in the second column.
	@column_scale_parameter_3: This parameter scales the range of the random float values in the third column.
	@decimal_places_column_1: Sets the number of decimal places for the values in the first column.
	@decimal_places_column_2: Sets the number of decimal places for the values in the second column.
	@decimal_places_column_3: Sets the number of decimal places for the values in the third column.
	@rows: This parameter specifies the number of rows to be generated in the table.
	@counter: A parameter used as a loop counter.
*/

DECLARE @table_type VARCHAR(8);

SET @table_type = 'both';

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

DECLARE @decimal_places_column_1 INT,
		@decimal_places_column_2 INT,
		@decimal_places_column_3 INT;

SET @decimal_places_column_1 = 1;
SET @decimal_places_column_2 = 2;
SET @decimal_places_column_3 = 3;

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
	IF @table_type = 'positive' 
		INSERT INTO @RandomTable
		VALUES (
			ROUND(@column_scale_parameter_1 * RAND(), @decimal_places_column_1),
			ROUND(@column_scale_parameter_2 * RAND(), @decimal_places_column_2),
			ROUND(@column_scale_parameter_3 * RAND(), @decimal_places_column_3)
		);
	IF @table_type = 'negative' 
		INSERT INTO @RandomTable
		VALUES (
			(-1) * ROUND(@column_scale_parameter_1 * RAND(), @decimal_places_column_1),
			(-1) * ROUND(@column_scale_parameter_2 * RAND(), @decimal_places_column_2),
			(-1) * ROUND(@column_scale_parameter_3 * RAND(), @decimal_places_column_3)
		);
	IF @table_type = 'both' 
		INSERT INTO @RandomTable
		VALUES (
			(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_1 * RAND(), @decimal_places_column_1),
			(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_2 * RAND(), @decimal_places_column_2),
			(2 * ROUND(RAND(), 0) - 1) * ROUND(@column_scale_parameter_3 * RAND(), @decimal_places_column_3)
		);
	SET @counter = @counter + 1;
END;

IF @table_type IN ('positive', 'negative', 'both')
	SELECT *
	FROM @RandomTable;
ELSE 
	SELECT '@table_type has to be one of the following values: positive, negative or both.' AS Error;