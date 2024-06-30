-- write a SP to add given dept details. 

DROP PROCEDURE IF EXISTS sp_add_dept3;

DELIMITER $$

CREATE PROCEDURE sp_add_dept3(v_deptno INT, v_dname CHAR(40), v_loc CHAR(40))
BEGIN
	DECLARE v_errflag INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR 1062 SET v_errflag = 1;

	INSERT INTO dept VALUES (v_deptno, v_dname, v_loc);
	
	IF v_errflag = 1 THEN
		SELECT 'Dept add failed.' AS msg FROM DUAL;
	ELSE
		SELECT 'Dept added successfully.' AS msg FROM DUAL;
	END IF;
END;
$$

DELIMITER ;

-- SOURCE D:/path/to/demo21.sql
-- CALL sp_add_dept3(10, 'MARKETING', 'DELHI');
-- CALL sp_add_dept3(100, 'LIBRARY', 'PUNE');

