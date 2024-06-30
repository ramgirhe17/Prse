# DQL - SELECT

## Assignment Discussion
* cmd> mysql -u edac -pedac dacdb

```SQL
SELECT USER(), DATABASE();

SHOW GRANTS;

SHOW DATABASES;

```

```SQL
-- hr
-- Q 10. Display employees first_name,email who are working in “Executive” department

USE hr;

SHOW TABLES;

SELECT * FROM departments WHERE department_name='Executive';

SELECT * FROM employees;

DESCRIBE employees;

SELECT first_name,email FROM employees WHERE department_id=90;

```

```SQL
-- select * from orders where (amt < 1000 OR NOT (odate = '1990-10-03' AND cnum > 2003));
-- C programming: 	! (highest), && (higher), || (low)
-- SQL: 			NOT (highest), AND (higher), OR (low)

USE sales;

select * from orders;
-- 10 rows

+------+---------+------------+------+------+
| onum | amt     | odate      | cnum | snum |
+------+---------+------------+------+------+
| 3001 |   18.69 | 1990-10-03 | 2008 | 1007 |
| 3003 |  767.19 | 1990-10-03 | 2001 | 1001 |
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 |
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3006 | 1098.16 | 1990-10-03 | 2008 | 1007 |
| 3009 | 1713.23 | 1990-10-04 | 2002 | 1003 |
| 3007 |   75.75 | 1990-10-04 | 2004 | 1002 |
| 3008 | 4723.00 | 1990-10-04 | 2006 | 1001 |
| 3010 |  309.95 | 1990-10-04 | 2004 | 1002 |
| 3011 | 9891.88 | 1990-10-04 | 2006 | 1001 |
+------+---------+------------+------+------+

select * from orders WHERE odate = '1990-10-03';

+------+---------+------------+------+------+
| onum | amt     | odate      | cnum | snum |
+------+---------+------------+------+------+
| 3001 |   18.69 | 1990-10-03 | 2008 | 1007 |
| 3003 |  767.19 | 1990-10-03 | 2001 | 1001 |
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 |
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3006 | 1098.16 | 1990-10-03 | 2008 | 1007 |
+------+---------+------------+------+------+

select * from orders WHERE odate = '1990-10-03' AND cnum > 2003;

+------+---------+------------+------+------+
| onum | amt     | odate      | cnum | snum |
+------+---------+------------+------+------+
| 3001 |   18.69 | 1990-10-03 | 2008 | 1007 |
| 3002 | 1900.10 | 1990-10-03 | 2007 | 1004 |
| 3006 | 1098.16 | 1990-10-03 | 2008 | 1007 |
+------+---------+------------+------+------+

select * from orders WHERE NOT (odate = '1990-10-03' AND cnum > 2003);
+------+---------+------------+------+------+
| onum | amt     | odate      | cnum | snum |
+------+---------+------------+------+------+
| 3003 |  767.19 | 1990-10-03 | 2001 | 1001 |
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3009 | 1713.23 | 1990-10-04 | 2002 | 1003 |
| 3007 |   75.75 | 1990-10-04 | 2004 | 1002 |
| 3008 | 4723.00 | 1990-10-04 | 2006 | 1001 |
| 3010 |  309.95 | 1990-10-04 | 2004 | 1002 |
| 3011 | 9891.88 | 1990-10-04 | 2006 | 1001 |
+------+---------+------------+------+------+

select * from orders WHERE amt < 1000;
+------+--------+------------+------+------+
| onum | amt    | odate      | cnum | snum |
+------+--------+------------+------+------+
| 3001 |  18.69 | 1990-10-03 | 2008 | 1007 |
| 3003 | 767.19 | 1990-10-03 | 2001 | 1001 |
| 3007 |  75.75 | 1990-10-04 | 2004 | 1002 |
| 3010 | 309.95 | 1990-10-04 | 2004 | 1002 |
+------+--------+------------+------+------+

select * from orders WHERE amt < 1000 OR NOT (odate = '1990-10-03' AND cnum > 2003);
+------+---------+------------+------+------+
| onum | amt     | odate      | cnum | snum |
+------+---------+------------+------+------+
| 3001 |  18.69 | 1990-10-03 | 2008 | 1007 |
| 3003 |  767.19 | 1990-10-03 | 2001 | 1001 |
| 3005 | 5160.45 | 1990-10-03 | 2003 | 1002 |
| 3009 | 1713.23 | 1990-10-04 | 2002 | 1003 |
| 3007 |   75.75 | 1990-10-04 | 2004 | 1002 |
| 3008 | 4723.00 | 1990-10-04 | 2006 | 1001 |
| 3010 |  309.95 | 1990-10-04 | 2004 | 1002 |
| 3011 | 9891.88 | 1990-10-04 | 2006 | 1001 |
+------+---------+------------+------+------+

```

```SQL
-- sales
-- Write a query on the Customers table whose output will exclude all customers with a rating <= 100, unless they are located in Rome.
USE sales;

SELECT * FROM customers;

SELECT * FROM customers WHERE rating <= 100;

SELECT * FROM customers WHERE rating <= 100 AND city != 'Rome';

SELECT * FROM customers WHERE NOT(rating <= 100 AND city != 'Rome');
```

## WHERE vs WHEN
* WHERE is to fetch selected rows -- for which given condition is true -- after FROM tablename.
* CASE...WHEN is for computed column -- before FROM tablename.

```SQL
USE dacdb;

SELECT empno, ename, sal,
CASE
WHEN sal <= 1500 THEN 'Poor'
WHEN sal > 1500 AND sal <= 2500 THEN 'Middle'
ELSE 'Rich'
END AS category
FROM emp
WHERE job = 'SALESMAN';
```

## NULL related operators
* NULL doesn't work with relational and logical operators.
* Need special operators
	* IS NULL or <=>
	* IN NOT NULL

```SQL
SELECT * FROM emp;

-- find all emps whose comm is null.
SELECT * FROM emp WHERE comm = NULL;

SELECT * FROM emp WHERE comm IS NULL;

SELECT * FROM emp WHERE comm <=> NULL;

-- find all emps whose comm is not null.
SELECT * FROM emp WHERE comm IS NOT NULL;

```

## BETWEEN operator
* more readable for comparing within range (than AND).
* faster than AND operator for same task.
* NOT BETWEEN

```SQL
-- get all emps whose sal is between 1500 and 2000.
SELECT * FROM emp WHERE sal >= 1500 AND sal <= 2000;

SELECT * FROM emp WHERE sal BETWEEN 1500 AND 2000;

-- get all emps hired in year 1982.
SELECT * FROM emp WHERE hire BETWEEN '1982-01-01' AND '1982-12-31';

-- get all emps whose name is between 'F' to 'K'.
INSERT INTO emp(empno, ename) VALUES (1, 'F'), (2, 'K'), (3, 'L');
SELECT * FROM emp WHERE ename BETWEEN 'F' AND 'K';

-- F
-- FORD
-- JAMES
-- JONES
-- K
-- KING

SELECT * FROM emp WHERE ename BETWEEN 'F' AND 'L';
-- will take all emp whose name starts between F and K. Also it includes name 'L' (if any).

SELECT * FROM emp WHERE ename BETWEEN 'F' AND 'L' AND ename != 'L';
-- will take all emp whose name starts between F and K. Skip name 'L' (if any).
```

## IN operator
* more readable for comparing equality with multiple values.
* faster than using OR for the same work.
* NOT IN operator

```SQL
-- find all ANALYST, MANAGER and PRESIDENT.
SELECT * FROM emp WHERE job='ANALYST' OR job='MANAGER' OR job='PRESIDENT';

SELECT * FROM emp WHERE job IN ('ANALYST', 'MANAGER', 'PRESIDENT');
```

## LIKE operator
* find similar name
* special characters (wildcard characters)
	* '%' : any number of any characters
	* '_' : single any character
* NOT LIKE

```SQL
-- get all emps whose name start with B
SELECT * FROM emp WHERE ename LIKE 'B%';

-- get all emps whose name end with H
SELECT * FROM emp WHERE ename LIKE '%H';

-- get all emps whose name contains U.
SELECT * FROM emp WHERE ename LIKE '%U%';

-- get all emps whose name contains any 4 letters.
SELECT * FROM emp WHERE ename LIKE '____';

-- find all emps whose name contains A twice.
SELECT * FROM emp WHERE ename LIKE '%A%A%';

-- find all emps whose name contains A only once.
SELECT * FROM emp WHERE ename LIKE '%A%' AND ename NOT LIKE '%A%A%';
```
