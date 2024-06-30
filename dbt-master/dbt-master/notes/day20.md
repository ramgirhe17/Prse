# System Database - information_schema

```SQL
USE information_schema;

DESC ROUTINES;

SELECT ROUTINE_NAME, ROUTINE_TYPE, ROUTINE_DEFINITION, DEFINER FROM ROUTINES;

SELECT ROUTINE_NAME, ROUTINE_TYPE, ROUTINE_DEFINITION, DEFINER FROM ROUTINES
WHERE DEFINER='edac@localhost';

SELECT ROUTINE_NAME, ROUTINE_TYPE, ROUTINE_DEFINITION, DEFINER FROM ROUTINES
WHERE DEFINER='edac@localhost' AND ROUTINE_TYPE='FUNCTION';

SELECT ROUTINE_NAME, ROUTINE_TYPE, ROUTINE_DEFINITION, DEFINER FROM ROUTINES
WHERE DEFINER='edac@localhost' AND ROUTINE_TYPE='FUNCTION' \G
```

# Error Handling

```SQL
USE dacdb;

DESC dept;

ALTER TABLE dept ADD PRIMARY KEY (deptno);

INSERT INTO dept VALUES (10, 'MARKETING', 'DELHI');
-- ERROR 1062 (23000): Duplicate entry '10' for key 'dept.PRIMARY'
-- 1062 -- Error code for Duplicate entry.
-- 23000 -- SQL State for Duplicate entry.

DROP TABLE departments;
-- ERROR 1051 (42S02): Unknown table 'dacdb.departments'
-- 1051 -- Error code
-- 42S02 -- SQL State

SHOW GRANTS;
GRANT SELECT ON dacdb.* TO 'developer1'@'%';
-- ERROR 1044 (42000): Access denied for user 'edac'@'localhost' to database 'dacdb'
-- 1044 -- Error code -- Access denied
-- 42000 -- SQL state -- Access denied
```

# Cursor
* Cursor is a special variable.
	* DECLARE v_cur CURSOR FOR select_statement;
		* select_statement can be simple select, group by, order by, sub-query and/or join.
		* select_statement can be on table and/or view.
* Cursor is used to read records one by one from a SELECT query.

* In C file read operation

	```
	open file
	while end of file is not reached
		read a record from file
		process that record
	close file
	```

* Cursor programming steps

	```
	declare error handler for cursor end condition (NOTFOUND).
	declare cursor variable and its select statement.
	open the cursor.
	fetch values from cursor into local variables (of current row) and process them.
	when all rows are completed, error handler will be executed.
	on end of cursor, close cursor.
	```

* Cursor syntax

	```
	DECLARE v_flag INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR NOTFOUND SET v_flag = 1;
	DECLARE v_cur CURSOR FOR SELECT ...;
	OPEN v_cur;
	label: LOOP
		FETCH v_cur INTO variables;
		IF v_flag = 1 THEN
			LEAVE label;
		END IF;
		process variables;
		...
	END LOOP;
	CLOSE v_cur;
	```

* MySQL Cursor characteristics
	* Readonly
		* Using cursor we can only read the values of row.
		* We cannot update or delete the row values.
	* Non-scrollable
		* Cursor is forward-only.
		* Start tranversing from first record to last record (of result).
		* Cannot traverse in reverse direction or cannot access nth record randomly.
		* We can close the cursor and reopen it to start processing from start again.
	* Asensitive
		* When cursor is opened, the addresses of rows (as in SELECT statement) are recorded into the cursor and then they are accessed one by one.
		* If any client change any of the row, while cursor is still processing/traversing; the changes done by the client will be immediately available into the cursor.
		* This is because MySQL cursor is not creating copy of records. Hence MySQL cursors are faster. 


















