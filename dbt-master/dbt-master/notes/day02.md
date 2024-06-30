
# MySQL "root" login
* cmd> mysql -u root -p
	* password: manager

```SQL
\! cls

SELECT USER(), DATABASE();

SHOW DATABASES;
-- SYSTEM DATABASES (contains db system information)
-- sys
-- mysql
-- performance_schema
-- information_schema

SELECT user FROM mysql.user;

EXIT;
```

# MySQL "edac" login
* cmd> mysql -u edac -p
	* password: edac

```SQL
SELECT USER(), DATABASE();

SHOW DATABASES;

-- activate the database
USE dacdb;

-- print current user & current database
SELECT USER(), DATABASE();

-- print tables in current database
SHOW TABLES;

EXIT;
```

* cmd> mysql -h localhost -u edac -p
	* -h -- server ip address/name
		* default = localhost -- current computer
	* -u -- mysql username to login
		* admin user = root
		* created user = edac
	* -p -- password 
		* password: edac --> CREATE USER edac@localhost IDENTIFIED BY 'edac';

* cmd> mysql -u edac -pedac
	* -ppassword -- password must be immediately after -p (no space).
	* by default no database is selected.

```SQL
SELECT USER(), DATABASE();

EXIT;
```

* cmd> mysql -u edac -pedac dacdb
	* login with edac user and edac password on current machine mysql server and activate database 'dacdb'.

```SQL
SELECT USER(), DATABASE();

SHOW TABLES;

CREATE TABLE students(id INT, name CHAR(20), marks DOUBLE);

SHOW TABLES;

INSERT INTO students VALUES (1, 'Nitin', 98.00);

INSERT INTO students VALUES (2, 'Sarang', 99.00);

INSERT INTO students VALUES (3, 'Nilesh', 77.00), (4, 'Sandeep', 88.00), (5, 'Amit', 90.00);

SELECT * FROM students;

DESCRIBE students;

```

# MySQL Physical layout
* Data directory: "C:\ProgramData\MySQL\MySQL Server 8.0\Data"

# Importing data into database
* Using SOURCE command.
	* classwork-db.sql --> dacdb database.

```SQL
-- SOURCE /path/to/the/sql/file
SOURCE D:\pgdiploma\edac-dbt\data\classwork-db.sql

SHOW TABLES;

SELECT * FROM books;
```

# Lab Assignment
	* hr-db.sql --> hr database
	* northwind-db.sql --> northwind database
	* sales-db.sql --> sales database

```SQL
-- using "root" login
CREATE DATABASE hr;

GRANT ALL PRIVILEGES ON hr.* TO edac@localhost;

USE hr;

SOURCE /path/to/hr-db.sql
```





































