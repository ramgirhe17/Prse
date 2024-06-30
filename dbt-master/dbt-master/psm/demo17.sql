-- return difference (in years) of given date and current system date.

DROP FUNCTION IF EXISTS fn_yeardiff;

DELIMITER $$

CREATE FUNCTION fn_yeardiff(v_date DATE)
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE v_years INT;
	SELECT TIMESTAMPDIFF(YEAR, v_date, NOW()) INTO v_years FROM DUAL;
	RETURN ABS(v_years);
END;
$$

DELIMITER ;

-- With root login.
-- mysql> SET GLOBAL log_bin_trust_function_creators=1;

-- With edac login.
-- mysql> SOURCE D:/path/to/demo17.sql;
-- mysql> SELECT fn_yeardiff('2000-11-01') FROM DUAL;
-- mysql> SELECT ename, hire, fn_yeardiff(hire) FROM emp;
