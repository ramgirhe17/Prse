-- print 'hello world' on mysql client.

DROP PROCEDURE IF EXISTS sp_hello1;

DELIMITER $$

CREATE PROCEDURE sp_hello1()
BEGIN
	SELECT 'Hello World' AS value FROM DUAL;
END;
$$

DELIMITER ;

-- mysql> CALL sp_hello2();

