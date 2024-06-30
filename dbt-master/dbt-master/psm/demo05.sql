-- write sal and ename of emp into result table.
-- empno will be given as param to the procedure.

-- mysql> TRUNCATE TABLE result;

DROP PROCEDURE IF EXISTS sp_getenamesal;

DELIMITER $$

CREATE PROCEDURE sp_getenamesal(v_empno INT)
BEGIN
	DECLARE v_sal DOUBLE;
	DECLARE v_ename VARCHAR(40);

	SELECT sal,ename INTO v_sal,v_ename FROM emp WHERE empno=v_empno;

	INSERT INTO result VALUES (v_sal, v_ename);
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo05.sql
-- mysql> CALL sp_getenamesal(7900);
-- mysql> SELECT * FROM result;

