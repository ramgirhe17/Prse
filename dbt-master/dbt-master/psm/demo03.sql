-- calculate area of rectangle and write result into results table.
-- length and breadth will be hard-coded into the procedure.

-- mysql> TRUNCATE TABLE result;

DROP PROCEDURE IF EXISTS sp_rectarea1;

DELIMITER $$

CREATE PROCEDURE sp_rectarea1()
BEGIN
	DECLARE v_len DOUBLE DEFAULT 10.0;
	DECLARE v_br DOUBLE DEFAULT 4.0;
	DECLARE v_area DOUBLE;

	-- assign variable using SET keyword.
	SET v_area = v_len * v_br;

	INSERT INTO result VALUES (v_area, 'Area Of Rect');
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo03.sql
-- mysql> CALL sp_rectarea1();
-- mysql> SELECT * FROM result;

