-- calculate square of given param and return result via same param.

DROP PROCEDURE IF EXISTS sp_sqr3;

DELIMITER $$

CREATE PROCEDURE sp_sqr3(INOUT v_res INT)
BEGIN
	SET v_res = v_res * v_res;
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo15.sql;
-- mysql> SET @res=7;
-- mysql> SELECT @res FROM DUAL;
-- mysql> CALL sp_sqr3(@res);
-- mysql> SELECT @res FROM DUAL;
