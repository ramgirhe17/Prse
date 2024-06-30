# Quiz

```SQL
SELECT 'Sunbeam', 'Sunbeam'='Sunbeam', 'Sunbeam'='Sunday' FROM DUAL;

SELECT SUBSTRING('Sunbeam', 1, 3)=LEFT('Sunbeam', 3), SUBSTRING('Sunbeam', -2)=RIGHT('Sunbeam', 2);

SELECT INSTR('Sunbeam', ' ');

SELECT INSTR('Sunbeam Infotech', ' ');

SELECT SUBSTRING('Sunbeam Infotech', 1, INSTR('Sunbeam Infotech', ' '));
```

# Data Types

## Date & Time
* DATE(3) -- only date: 01-01-1000 to 31-12-9999.
* TIME(3) -- only time duration: -838 hrs to +838 hrs 
* DATETIME(5) -- date & time of day: 01-01-1000 00:00:00 to 31-12-9999 23:59:59.
* TIMESTAMP(4) -- current time/moment - internally stored as number of seconds from 1-1-1970 00:00:00 (epoch time) - as int.
	- max value: '2038-01-19 03:14:07'
* YEAR(1) -- year from 1900 to 2155.

# SQL Functions

## Information Functions

## String Functions

```SQL
SELECT SUBSTRING_INDEX('Sunbeam Infotech At Pune', ' ', 1);
-- from start of string till first occurence of ' ' i.e. Sunbeam

SELECT SUBSTRING_INDEX('Sunbeam Infotech At Pune', ' ', 2);
-- from start of string till second occurence of ' ' i.e. Sunbeam Infotech

SELECT SUBSTRING_INDEX('Sunbeam Infotech At Pune', ' ', 3);
-- from start of string till third occurence of ' ' i.e. Sunbeam Infotech At

SELECT SUBSTRING_INDEX('Sunbeam Infotech At Pune', ' ', 4);
-- whole string because, ' ' have only three occurences.

SELECT SUBSTRING_INDEX('Sunbeam Infotech At Pune', ' ', -1);
-- from last occurence of ' ' till end i.e. Pune

SELECT SUBSTRING_INDEX('Sunbeam Infotech At Pune', ' ', -2);
-- from second last occurence of ' ' till end i.e. At Pune
```

## Date and Time Functions
* DATE() function:
	* Timestamp/DateTime type --> DATE() --> DATE type

## Control Flow Functions
* IF(condition, expression_if_true, expression_if_false)

```SQL
HELP Control Flow Functions;

HELP IF Function;

SELECT * FROM books;

-- if book price is less than or equal to 500, not expensive, else expensive.
SELECT name, price, IF(price <= 500, 'not expensive', 'expensive') AS category FROM books;

-- if book price below 300, not expensive.
-- if book price above 300 to 600, moderate expensive.
-- if book price above 600, very expensive
SELECT name, price, IF(price < 300, 'not expensive', IF(price <= 600, 'moderate expensive',  'very expensive') ) AS category FROM books;

INSERT INTO books VALUES (1, 'Atlas Shrugged', 'Any Rand', 'Novell', 452.45);

SELECT subject FROM books;

SELECT subject, INSTR(subject, ' ') FROM books;

SELECT subject, LEFT(subject, INSTR(subject, ' ')) FROM books;

SELECT subject, IF(INSTR(subject, ' ')=0, subject, LEFT(subject, INSTR(subject, ' '))) first_word FROM books;

SELECT subject, SUBSTRING_INDEX(subject, ' ', 1) FROM books;
-- if subject have atleast one space, result = from start of string to that space.
-- if subject doesn't have single space, result is whole string.
```

```
if(INSTR(subject, ' ') == 0) // space not found
	subject // take whole word
else
	LEFT(subject, INSTR(subject, ' ')) // take n chars from word
```

## Numeric Functions
* FLOOR() -- returns immediately smaller whole number (int)
* CEIL() -- returns immediately higher whole number (int)

```SQL
HELP Numeric Functions;

SELECT POW(2, 4), POW(2, 10), POW(2, 0), POW(2, 0.5), POW(2, -1);

SELECT ABS(123), ABS(-123);

SELECT FLOOR(2.7), FLOOR(-2.7);

SELECT CEIL(2.4), CEIL(-2.4);

SELECT ROUND(123.234567, 1), ROUND(123.234567, 4); 
-- 123.2, 123.2346

SELECT ROUND(12345.678, 0), ROUND(12345.678, -1), ROUND(12345.678, -2); 
-- 12346, 12350, 12300

SELECT ROUND(45.4, -1), ROUND(-45.4, -1);
-- nearest tens -- 45 --> 50

SELECT ROUND(44.4, -1), ROUND(-44.4, -1);
-- nearest tens -- 44 --> 40
```

## Null Operators and Functions
* NULL related Operators
	* IS NULL, <=>, IS NOT NULL
* NULL related Functions ()
	* ISNULL(), IFNULL(), NULLIF()
* ISNULL() returns 1 if NULL, else return 0.
* IFNULL(col, value) -- if col is null value, consider given 'value'
* NULLIF(col, value) -- if col value = given value, consider NULL.
* COALESCE(v1,v2,v3,...) -- returns first non-null value.

```SQL
SELECT comm, ISNULL(comm) FROM emp;

SELECT comm, IFNULL(comm, 0.0) FROM emp;

-- print emp name, sal, comm and total income.
SELECT ename, sal, comm, sal + comm AS income FROM emp;

SELECT ename, sal, comm, sal + IFNULL(comm,0.0) AS income FROM emp;

SELECT ename, sal, NULLIF(sal, 1500) FROM emp;

SELECT COALESCE(null, null, 12, 'abc');

SELECT comm, sal, COALESCE(comm,sal) FROM emp;
-- if comm is non-null, return it; otherwise return sal.
```

## List Functions
* Functions take any number of arguments.
	* COALESCE()
	* CONCAT()
	* GREATEST()
	* LEAST()

```SQL
SELECT GREATEST(34, 56, 78, 12, 45);
-- 78

SELECT LEAST(34, 56, 78, 12, 45);
-- 12
```

## Group Functions
* Group Functions ignore NULL values.

```SQL
SELECT COUNT(empno), COUNT(comm) FROM emp;

SELECT SUM(sal), SUM(comm) FROM emp;

SELECT AVG(sal), AVG(comm) FROM emp;

SELECT MAX(sal), MAX(comm), MIN(sal), MIN(comm) FROM emp;

SELECT COUNT(comm), COUNT(IFNULL(comm,0)) FROM emp;
```

```SQL
SELECT ename, SUM(sal) FROM emp;
-- error: limitation 1

SELECT LOWER(ename), SUM(sal) FROM emp;
-- error: limitation 2

SELECT * FROM emp WHERE sal = MAX(sal);
-- error: limitation 3

SELECT COUNT(SUM(sal)) FROM emp;
-- error: limitation 4
```





















