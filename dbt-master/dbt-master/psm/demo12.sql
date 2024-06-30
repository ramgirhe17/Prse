-- insert roll number and name (suffixed by roll) into result table for roll number 1 to 5.
-- result table add values --> (1, 'DAC1'), (2, 'DAC2'), (3, 'DAC3'), (4, 'DAC4'), (5, 'DAC5')
-- implement using REPEAT ... UNTIL loop.

DROP PROCEDURE IF EXISTS sp_add_student2;

DELIMITER $$

CREATE PROCEDURE sp_add_student2()
BEGIN
	DECLARE v_roll INT;
	DECLARE v_name CHAR(20);
	SET v_roll = 1;
	REPEAT
		SET v_name = CONCAT('DAC', v_roll);
		INSERT INTO result VALUES (v_roll, v_name);
		SET v_roll = v_roll + 1;
	UNTIL v_roll > 5
	END REPEAT;
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo12.sql;
-- mysql> TRUNCATE TABLE result;
-- mysql> CALL sp_add_student2();
-- mysql> SELECT * FROM result;
