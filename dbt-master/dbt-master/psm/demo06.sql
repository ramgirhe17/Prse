-- write hire year and its type (leap or not leap) of emp into result table.
-- empno will be given as param to the procedure.

-- mysql> TRUNCATE TABLE result;

DROP PROCEDURE IF EXISTS sp_gethireyear;

DELIMITER $$

CREATE PROCEDURE sp_gethireyear(v_empno INT)
BEGIN
	DECLARE v_year INT;
	DECLARE v_type CHAR(20);

	SELECT YEAR(hire) INTO v_year FROM emp WHERE empno = v_empno;

	IF v_year % 4 = 0 THEN
		SET v_type = 'LEAP YEAR';
	ELSE
		SET v_type = 'NOT LEAP YEAR';
	END IF;

	INSERT INTO result VALUES (v_year, v_type);
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo06.sql
-- mysql> CALL sp_gethireyear(7900);
-- mysql> SELECT * FROM result;

