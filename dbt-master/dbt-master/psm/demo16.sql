-- calculate square of given param and return result.

DROP FUNCTION IF EXISTS fn_sqr1;

DELIMITER $$

CREATE FUNCTION fn_sqr1(v_n INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_res INT;
	SET v_res = v_n * v_n;
	RETURN v_res;
END;
$$

DELIMITER ;

-- With root login.
-- mysql> SET GLOBAL log_bin_trust_function_creators=1;

-- With edac login.
-- mysql> SOURCE D:/path/to/demo16.sql;
-- mysql> SELECT fn_sqr1(9) FROM DUAL;
-- mysql> SELECT deptno, fn_sqr1(deptno) FROM dept;
