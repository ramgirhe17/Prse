-- write a function, that converts given string's first letter capital case and rest of string in small case.

DROP FUNCTION IF EXISTS fn_title;

DELIMITER $$

CREATE FUNCTION fn_title(v_str CHAR(200))
RETURNS CHAR(200)
DETERMINISTIC
BEGIN
	DECLARE v_result CHAR(200);
	DECLARE v_first CHAR(1);
	DECLARE v_rest CHAR(200);
	SET v_first = UPPER( LEFT(v_str, 1) );
	SET v_rest = LOWER( SUBSTRING(v_str, 2) );
	SET v_result = CONCAT(v_first, v_rest);
	RETURN v_result;
END;
$$

DELIMITER ;

-- SOURCE D:/path/to/demo18.sql
-- SELECT fn_title('sunbeam INFOTECH');
-- SELECT fn_title(ename) FROM emp;

