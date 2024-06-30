# Transactions
* autocommit=1 (default setting for MySQL), means there will be separate transaction for each DML query. This transaction is committed for each query.
* autocommit can be changed at session level or global level.
	* session level
		* applicable only for current client session (when client exit, setting is restored).
		* SET autocommit = 0;
	* global level
		* applicable for all sessions of all users.
		* set into my.ini file (by database admin).
* autocommit=0, means a transaction is started. On each commit/rollback, current transaction is completed and immediately new transaction is started (automatically).

```SQL
SELECT @@autocommit;
-- 1

SET autocommit = 0;

SELECT @@autocommit;
-- 0

SELECT * FROM dept;

DELETE FROM dept;

SELECT * FROM dept;

ROLLBACK;
-- current tx is completed and new tx is started here.

SELECT * FROM dept;

INSERT INTO dept VALUES(50, 'SECURITY', 'JAMMU');

SELECT * FROM dept;

ROLLBACK;

SELECT * FROM dept;

EXIT;
```

```SQL
SELECT @@autocommit;
-- 1

START TRANSACTION;

SELECT * FROM dept;
-- 10, 20, 30, 40

INSERT INTO dept VALUES(50, 'SECURITY', 'JAMMU');

SELECT * FROM dept;
-- 10, 20, 30, 40, 50

CREATE TABLE temp(id INT, val CHAR(20));
-- DDL command -- commit the current tx i.e. all changes are saved permanently.
-- since commit is done current, tx is completed.

ROLLBACK;
-- nothing to discard -- changes were already saved.

SELECT * FROM dept;
-- 10, 20, 30, 40, 50
```

* When EXIT is done, current tx is rollbacked.

```SQL
START TRANSACTION;

SELECT * FROM dept;
-- 10, 20, 30, 40, 50

DELETE FROM dept WHERE deptno=50;

SELECT * FROM dept;
-- 10, 20, 30, 40

EXIT;
```

```SQL
-- on new login

SELECT * FROM dept;
-- 10, 20, 30, 40, 50
```

## Table & Row Locking
* Follow instructions as shown in video.
* Follow exact instruction sequence (don't miss any instruction).
