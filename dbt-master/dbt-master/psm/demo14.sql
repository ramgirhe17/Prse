-- calculate square of given param and return result via output param.

DROP PROCEDURE IF EXISTS sp_sqr2;

DELIMITER $$

CREATE PROCEDURE sp_sqr2(IN v_n INT, OUT v_res INT)
BEGIN
	SET v_res = v_n * v_n;
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo14.sql;
-- mysql> SET @num=5;
-- mysql> SET @res=0;
-- mysql> SELECT @num, @res FROM DUAL;
-- mysql> CALL sp_sqr2(@num, @res);
-- mysql> SELECT @num, @res FROM DUAL;
