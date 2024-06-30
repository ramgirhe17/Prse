-- write a SP to add given dept details. 

DROP PROCEDURE IF EXISTS sp_add_dept4;

DELIMITER $$

CREATE PROCEDURE sp_add_dept4(v_deptno INT, v_dname CHAR(40), v_loc CHAR(40))
BEGIN
	DECLARE duplicate_entry CONDITION FOR 1062;
	-- duplicate_entry is alias for error code 1062.

	DECLARE v_errflag INT DEFAULT 0;

	DECLARE CONTINUE HANDLER FOR duplicate_entry
	BEGIN
		SET v_errflag = 1;
		INSERT INTO result VALUES (v_deptno, 'Deptno duplication error');
	END;

	INSERT INTO dept VALUES (v_deptno, v_dname, v_loc);
	
	IF v_errflag = 1 THEN
		SELECT 'Dept add failed.' AS msg FROM DUAL;
	ELSE
		SELECT 'Dept added successfully.' AS msg FROM DUAL;
	END IF;
END;
$$

DELIMITER ;

-- SOURCE D:/path/to/demo22.sql
-- CALL sp_add_dept4(10, 'MARKETING', 'DELHI');
-- SELECT * FROM result;
