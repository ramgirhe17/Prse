# SQL
* Login with 'edac' into 'dacdb'.
	* cmd> mysql -u edac -pedac dacdb

```SQL
SELECT USER(), DATABASE();
-- edac user and dacdb database

SHOW TABLES;

SHOW GRANTS;

SHOW GRANTS FOR edac@localhost;

SELECT * FROM students;

DESCRIBE students;
```

## DDL - CREATE TABLE
* CREATE TABLE tablename(col1 COL-TYPE, col2 COL-TYPE, col3 COL-TYPE, ...);
* CREATE TABLE tablename(col1 COL-TYPE constraint, col2 COL-TYPE constraint, col3 COL-TYPE constraint, ..., constraint);

```SQL
CREATE TABLE test(c1 CHAR(10), c2 VARCHAR(10), c3 TEXT(10));

INSERT  INTO test VALUES ('ABCD', 'ABCD', 'ABCD');

SELECT * FROM test;

INSERT INTO test VALUES ('abcdefghijk', 'abcdefghijk', 'abcdefghijk');
-- error: data too long for c1.

INSERT INTO test VALUES ('abcdefghij', 'abcdefghijk', 'abcdefghijk');
-- error: data too long for c2.

INSERT INTO test VALUES ('abcdefghij', 'abcdefghij', 'abcdefghijk');
-- no error: upto 255 chars allowed in tinytext

SELECT * FROM test;

DESCRIBE test;

```

## DML - INSERT
* INSERT INTO tablename VALUES (v1, v2, v3, ...);
	* Strings and Date/Time must be enclosed in single quotes.
	* Other values without single quotes.
	* VALUES order must be same as of column order (while creating table).

```SQL
INSERT INTO students VALUES (6, 'yogesh', 90);

INSERT INTO students VALUES (90, 7, 'digvijay');
-- error

INSERT INTO students(marks,id,name) VALUES (90, 7, 'digvijay');

SELECT * FROM students;

INSERT INTO students(id,name) VALUES (8, 'pooja');

INSERT INTO students(id,name) VALUES (9, 'sameer'), (10, 'shekhar'), (11, 'rahul');

INSERT INTO students(id,name,marks) VALUES (12, NULL, NULL);

SELECT * FROM students;
```

* We can insert records from one table into another table.
	* INSERT INTO newtablename SELECT * FROM oldtablename;
		* The count and order of columns in newtable must be same as oldtable.
	* INSERT INTO newtablename(c1,c2) SELECT c1,c2 FROM oldtablename;
		* Column c1 and c2 data from oldtable will be inserted into c1 & c2 Columns of newtable.


```SQL
CREATE TABLE newstudents (roll INT, name CHAR(20));

INSERT INTO newstudents(roll,name) SELECT id,name FROM students;

SELECT * FROM newstudents;

```












