# Stored Procedure

* Implementing SP on MySQL CLI.

	```SQL
	DELIMITER $$

	CREATE PROCEDURE sp_hello1()
	BEGIN
		SELECT 'Hello World' AS value FROM DUAL;
	END;
	$$

	DELIMITER ;
	```

	```SQL
	CALL sp_hello1();
	```

* Implementing SP using .sql file.
	* step 1: create demo01.sql file (using any editor).
	* step 2: Implement SP in it.

		```SQL
		DROP PROCEDURE IF EXISTS sp_hello1;

		DELIMITER $$

		CREATE PROCEDURE sp_hello1()
		BEGIN
			SELECT 'Hello World' AS value FROM DUAL;
		END;
		$$

		DELIMITER ;
		```

	* step 3: Run .sql file using SOURCE command.
		* mysql> SOURCE D:/path/to/demo01.sql
	
	* step 4: Execute the stored procedure using CALL.
		* mysql> CALL sp_hello1();

