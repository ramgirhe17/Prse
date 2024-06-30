# DUAL Table
* ANSI optional keywords: AS, ASC, DUAL.

```SQL
SHOW TABLES;

SELECT 2 + 3 * 4 FROM DUAL;

DESCRIBE DUAL;
-- error

SELECT * FROM DUAL;
-- error

SELECT 2 + 3 * 4;
```

# SQL Functions
* Used to perform some operations on table data.
* Can also be used without any table data with aribitrary values with optional DUAL table.

```SQL
HELP Functions;
```

## Information Functions

```SQL
-- get current user name
SELECT USER() FROM DUAL;
-- get current database/schema
SELECT DATABASE() FROM DUAL;
-- get current server date & time
SELECT NOW() FROM DUAL;
-- get current server date & time
SELECT SYSDATE() FROM DUAL;
-- get server version
SELECT VERSION() FROM DUAL;
```

## String Functions

```SQL
HELP String Functions;

HELP ASCII;

SELECT ASCII('A'), ASCII('a'), ASCII('0'), ASCII(' ');

HELP CHAR Function;

SELECT CHAR(65 USING ASCII);

SELECT LENGTH('Sunbeam'), LENGTH('Infotech');

SELECT ename, LENGTH(ename) FROM emp;

-- find all names which contains 4 characters
SELECT ename FROM emp WHERE ename LIKE '____';
SELECT ename FROM emp WHERE LENGTH(ename) = 4;

SELECT CONCAT('Hello', ' ', 'World');
SELECT CONCAT('Hello', ' ', 12345);

-- show message: XYZ employee is working as ABC on salary PQR in department 10.
SELECT CONCAT(ename, ' employee is working as ', job, ' on salary ', sal, ' in department ', deptno) AS msg FROM emp;

-- print all book names
SELECT name FROM books;

HELP SUBSTRING;
-- SUBSTRING(string, position, length)
-- position (start from 1)
--	+ve: from start of string
--	-ve: from end of string
-- length (optional)
--	if length is not given, till end of string.
--	+ve: number of characters from the given position.
-- 	0 or -ve: no meaning -- results in empty string.
-- MySQL specific:
--	allows FROM keyword to indicate position and FOR keyword to indicate length.
-- 	not allowed with all other RDBMS.
-- 	not commonly used syntax.

-- print first 4 letters of name.
SELECT name, SUBSTRING(name, 1, 4) FROM books;

-- print book name 4th letter onwards.
SELECT name, SUBSTRING(name, 4) FROM books;

-- print last 4 letters of name
SELECT name, SUBSTRING(name, -4) FROM books;

SELECT SUBSTRING('Sunbeam', 4, -2);

-- find all names starting from 'F' to 'K'.
SELECT ename FROM emp WHERE SUBSTRING(ename, 1, 1) BETWEEN 'F' AND 'K';

-- LEFT(), RIGHT(), MID(), SUBSTR()

-- print first 2 chars and last 2 chars of book name
SELECT LEFT(name,2), RIGHT(name,2) FROM books;

-- LTRIM(), RTRIM(), TRIM() -- remove leading (left) or trailing (right) white-spaces (space, tab, newline)
SELECT TRIM('    ABCD          ');

-- LPAD(), RPAD() -- add given char at start/end.
SELECT LPAD('SunBeam', 10, '*');
SELECT RPAD('SunBeam', 10, '*');

SELECT LPAD('SunBeam', 12, '*');
SELECT RPAD(LPAD('SunBeam', 12, '*'), 17, '*');
-- result of LPAD() is passed as first argument to RPAD().

-- REPLACE() -- find occurence of a word and replace with other
SELECT REPLACE('this', 'is', 'at');
SELECT REPLACE('this is a string', 'is', 'at');
SELECT REPLACE('this is a string', ' ', '');

-- UPPER(), LOWER()
SELECT name, UPPER(name), LOWER(name) FROM books;
```

## Date and Time Functions

```SQL
HELP Date and Time Functions;

SELECT NOW(), SLEEP(5), SYSDATE();
-- NOW() & SYSDATE() returns current date & time.
-- SLEEP() holds query execution for given seconds. No output/result.

SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();
SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP;
-- return server date, time and date-time respectively.
-- CURRENT_TIMESTAMP() is similar to NOW() / SYSDATE().

-- DAYOFYEAR(), DAYOFMONTH(), MONTH(), MONTHNAME(), YEAR(), HOUR(), MINUTE(), SECOND()
SELECT DAYOFMONTH(NOW()), MONTH(NOW()), MONTHNAME(NOW()), YEAR(NOW()), DAYOFYEAR(NOW());

-- DATE() and TIME() component of DATETIME
SELECT DATE(NOW()), TIME(NOW());

HELP DATE_ADD;
HELP DATEDIFF;
HELP TIMESTAMPDIFF;

-- 
SELECT DATE_ADD('2020-10-27', INTERVAL 1 DAY);
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);
SELECT DATE_ADD(NOW(), INTERVAL 1 MONTH);
SELECT DATE_ADD(NOW(), INTERVAL 3 MONTH);
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR);

SELECT DATEDIFF(NOW(), '1983-09-28');
-- first arg should be higher and second should be lower = +ve result

SELECT DATEDIFF('1983-09-28', NOW());
-- first arg lower and second higher = -ve result

SELECT TIMESTAMPDIFF(YEAR, '1983-09-28', NOW());
-- first arg: difference unit, second arg: lower date, third arg: higher date --> +ve result
-- find difference in year, month, hour, ...

-- find ename, hire date and experience in months.
SELECT ename, hire, TIMESTAMPDIFF(MONTH, hire, NOW()) FROM emp;

SELECT ename, hire, TIMESTAMPDIFF(YEAR, hire, NOW()), TIMESTAMPDIFF(MONTH, hire, NOW()) FROM emp;

```





