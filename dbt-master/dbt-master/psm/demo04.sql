-- calculate area of rectangle and write result into results table.
-- length and breadth will be passed as params to the procedure.

-- mysql> TRUNCATE TABLE result;

DROP PROCEDURE IF EXISTS sp_rectarea2;

DELIMITER $$

CREATE PROCEDURE sp_rectarea2(v_len DOUBLE, v_br DOUBLE)
BEGIN
	DECLARE v_area DOUBLE;

	-- assign variable using SELECT statement.
	SELECT v_len * v_br INTO v_area FROM DUAL;

	INSERT INTO result VALUES (v_area, 'Area Of Rect');
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo04.sql
-- mysql> CALL sp_rectarea2(8.0, 3.0);
-- mysql> SELECT * FROM result;

