-- input a number as parameter and print whether it is prime or not.

DROP PROCEDURE IF EXISTS sp_prime;

DELIMITER $$

CREATE PROCEDURE sp_prime(v_num INT)
BEGIN
	DECLARE v_status CHAR(20) DEFAULT 'Neither';
	DECLARE v_i INT DEFAULT 2;
	
	prime: LOOP
		IF v_num = 1 THEN
			LEAVE prime;
		END IF;

		IF v_i = v_num THEN
			SET v_status = 'Prime';
			LEAVE prime;
		END IF;

		IF v_num % v_i = 0 THEN
			SET v_status = 'Not Prime';
			LEAVE prime;
		END IF;

		SET v_i = v_i + 1;
	END LOOP;

	SELECT v_num AS num, v_status AS status FROM DUAL;
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo13.sql;
-- mysql> CALL sp_prime(13);
-- mysql> CALL sp_prime(49);
-- mysql> CALL sp_prime(1);

