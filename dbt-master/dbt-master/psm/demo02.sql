-- insert 'hello world' into a result table.
-- ensure that result table is already created (create if not created).
--	mysql> CREATE TABLE result(id DOUBLE, val VARCHAR(200));

DROP PROCEDURE IF EXISTS sp_hello2;

DELIMITER $$

CREATE PROCEDURE sp_hello2()
BEGIN
	INSERT INTO result VALUES (1, 'Hello World');
END;
$$

DELIMITER ;

-- mysql> SOURCE D:/path/to/demo02.sql
-- mysql> CALL sp_hello2();
-- mysql> SELECT * FROM result;
