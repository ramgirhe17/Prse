-- write a SP to add given dept details. 

DROP PROCEDURE IF EXISTS sp_add_dept1;

DELIMITER $$

CREATE PROCEDURE sp_add_dept1(v_deptno INT, v_dname CHAR(40), v_loc CHAR(40))
BEGIN
	INSERT INTO dept VALUES (v_deptno, v_dname, v_loc);
	SELECT 'Dept added successfully.' AS msg FROM DUAL;
END;
$$

DELIMITER ;

-- SOURCE D:/path/to/demo19.sql
-- CALL sp_add_dept1(80, 'ENTERTAINMENT', 'JAMMU');
-- CALL sp_add_dept1(10, 'MARKETING', 'DELHI');

