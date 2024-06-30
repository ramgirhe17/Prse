-- save old & new sal of emp into sal_history table when his sal is changed.
-- CREATE TABLE sal_history(empno INT, oldsal DECIMAL(7,2), newsal DECIMAL(7,2), changetime DATETIME);

DROP TRIGGER IF EXISTS trig_emp_salchange;

DELIMITER $$

CREATE TRIGGER trig_emp_salchange
BEFORE UPDATE ON emp
FOR EACH ROW
BEGIN
    DECLARE v_empno INT;
    DECLARE v_oldsal DECIMAL(7,2);
    DECLARE v_newsal DECIMAL(7,2);
    SET v_empno = OLD.empno;
    SET v_oldsal = OLD.sal;
    SET v_newsal = NEW.sal;
    IF v_newsal != v_oldsal THEN
        INSERT INTO sal_history VALUES(v_empno, v_oldsal, v_newsal, NOW());
    END IF;
END;
$$

DELIMITER ;

-- with root login
-- SET GLOBAL log_bin_trust_function_creators=1;
-- SELECT @@log_bin_trust_function_creators;

-- with edac login:
-- SOURCE D:/pgdiploma/edac-dbt/today/demo24.sql;

-- SELECT * FROM sal_history;
-- UPDATE emp SET sal=5100 WHERE ename='KING';
-- SELECT * FROM emp;
-- SELECT * FROM sal_history;

-- UPDATE emp SET job='PRESIDENT' WHERE ename='KING';
