-- write a SP to add given dept details. 

DROP PROCEDURE IF EXISTS sp_add_dept2;

DELIMITER $$

CREATE PROCEDURE sp_add_dept2(v_deptno INT, v_dname CHAR(40), v_loc CHAR(40))
BEGIN
	DECLARE EXIT HANDLER FOR 1062 SELECT 'Dept add failed.' AS msg FROM DUAL;

	INSERT INTO dept VALUES (v_deptno, v_dname, v_loc);
	
	SELECT 'Dept added successfully.' AS msg FROM DUAL;
END;
$$

DELIMITER ;

-- SOURCE D:/path/to/demo20.sql
-- CALL sp_add_dept2(10, 'MARKETING', 'DELHI');

