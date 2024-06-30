-- print emp name, sal and category for the given emp -- using nested if-else.
-- empno will be given as parameter.
-- category=POOR, if sal < 1500.
-- category=MIDDLE, if sal >= 1500 and sal <=2500.
-- category=RICH, if sal > 2500.

DROP PROCEDURE IF EXISTS sp_emp_category1;

DELIMITER $$

CREATE PROCEDURE sp_emp_category1(v_empno INT)
BEGIN
	DECLARE v_ename CHAR(40);
	DECLARE v_sal DOUBLE;
	DECLARE v_category CHAR(20);

	SELECT ename, sal INTO v_ename, v_sal FROM emp WHERE empno = v_empno;
	IF v_sal < 1500 THEN
		SET v_category = 'POOR';
	ELSE
		IF v_sal >= 1500 AND v_sal <= 2500 THEN
			SET v_category = 'MIDDLE';
		ELSE
			SET v_category = 'RICH';
		END IF;
	END IF;

	SELECT v_ename AS ename, v_sal AS sal, v_category AS category FROM DUAL;
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo08.sql;
-- mysql> CALL sp_emp_category1(7900);
