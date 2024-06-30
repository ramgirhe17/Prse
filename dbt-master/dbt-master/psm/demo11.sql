-- insert roll number and name (suffixed by roll) into result table for roll number 1 to 5.
-- result table add values --> (1, 'DAC1'), (2, 'DAC2'), (3, 'DAC3'), (4, 'DAC4'), (5, 'DAC5')

DROP PROCEDURE IF EXISTS sp_add_student;

DELIMITER $$

CREATE PROCEDURE sp_add_student()
BEGIN
	DECLARE v_roll INT;
	DECLARE v_name CHAR(20);
	SET v_roll = 1;
	WHILE v_roll <= 5 DO
		SET v_name = CONCAT('DAC', v_roll);
		INSERT INTO result VALUES (v_roll, v_name);
		SET v_roll = v_roll + 1;
	END WHILE;
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo11.sql;
-- mysql> TRUNCATE TABLE result;
-- mysql> CALL sp_add_student();
-- mysql> SELECT * FROM result;
