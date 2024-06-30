# Joins

## Examples

```SQL
USE sales;

-- Write a query that lists each order number followed by the name of the customer who made the order.
SELECT o.onum, c.cname FROM orders o
INNER JOIN customers c ON o.cnum = c.cnum;

-- Write a query that gives the names of both the salesperson and the customer for each order along with the order number.
SELECT o.onum, s.sname, c.cname FROM orders o
INNER JOIN customers c ON o.cnum = c.cnum
INNER JOIN salespeople s ON o.snum = s.snum;

-- another syntax of writing join -- only support inner join -- not standard way of writing join.
SELECT o.onum, s.sname, c.cname FROM orders o, customers c, salespeople s
WHERE o.cnum = c.cnum AND o.snum = s.snum;

-- Write a query that produces all customers serviced by salespeople with a commission above 12%. Output the customer’s name, the salesperson’s name, and the salesperson’s rate of commission.
SELECT c.cname, s.sname, s.comm FROM customers c
INNER JOIN salespeople s ON c.snum = s.snum
WHERE s.comm > 0.12;

-- Write a query that calculates the amount of the salesperson’s commission on each order by a customer with a rating above 100.
SELECT o.onum, c.rating, o.amt, s.comm, o.amt * s.comm FROM orders o
INNER JOIN customers c ON o.cnum = c.cnum
INNER JOIN salespeople s ON o.snum = s.snum
WHERE c.rating > 100;

-- Write a query that produces all pairs of salespeople who are living in the same city. Exclude combinations of salespeople with themselves as well as duplicate rows with the order reversed.
SELECT * FROM salespeople;

SELECT s1.sname, s2.sname, s1.city FROM salespeople s1
INNER JOIN salespeople s2 ON s1.city = s2.city;

SELECT s1.snum, s1.sname, s2.snum, s2.sname, s1.city FROM salespeople s1
INNER JOIN salespeople s2 ON s1.city = s2.city
WHERE s1.snum != s2.snum;

SELECT s1.snum, s1.sname, s2.snum, s2.sname, s1.city FROM salespeople s1
INNER JOIN salespeople s2 ON s1.city = s2.city
WHERE s1.snum < s2.snum;
```

* Tables

```
STUDENTS
-------------------------------
| std | roll | name | address |
-------------------------------
|  1  | 1    | A    | Pune   |
|  1  | 2    | B    | Pune   |
|  1  | 3    | C    | Pune   |
|  2  | 1    | D    | Pune   |
|  2  | 2    | E    | Pune   |
-------------------------------

MARKS
-------------------------------
| std | roll | subject | marks |
-------------------------------
|  1  |  1   | Hin     | 20   |
|  1  |  1   | Eng     | 25   |
|  1  |  1   | Math    | 30   |
|  1  |  2   | Hin     | 10   |
|  1  |  2   | Eng     | 20   |
|  1  |  2   | Math    | 22   |
|  2  |  1   | Hin     | 8    |
|  2  |  1   | Eng     | 20   |
|  2  |  1   | Math    | 24   |
-------------------------------

```

```SQL
SELECT s.name, m.subject, m.marks FROM STUDENTS s
INNER JOIN MARKS m ON s.std = m.std AND s.roll = m.roll;
```

# SQL
## DQL - SELECT
## DML - INSERT, UPDATE, DELETE
## TCL - COMMIT, ROLLBACK, SAVEPOINT
## DDL - CREATE DATABASE, CREATE TABLE, TRUNCATE, DROP DATABASE, DROP TABLE, ALTER ...
	* Related to table structure.


### ALTER TABLE

```SQL
USE dacdb;

SHOW TABLES;

CREATE TABLE temp (id INT, val CHAR(10));

DESC temp;

INSERT INTO temp VALUES (1, 'ABCD'), (2, 'WXYZ');

SELECT * FROM temp;

-- add new column
ALTER TABLE temp ADD sal DOUBLE;

DESC temp;

SELECT * FROM temp;

INSERT INTO temp VALUES (3, 'abc', 4550.0), (4, 'xyz', 6344.2);

SELECT * FROM temp;

-- modify data type
ALTER TABLE temp MODIFY sal DECIMAL(7,2);

DESC temp;
 
SELECT * FROM temp;

-- modify data type
ALTER TABLE temp MODIFY sal DECIMAL(3,2);
-- if data is not convertable to new type, ALTER TABLE fails.

-- rename column
ALTER TABLE temp CHANGE sal income DECIMAL(7,2);

DESC temp;
 
SELECT * FROM temp;

-- rename table
ALTER TABLE temp RENAME TO timepass;

DESC timepass;

SELECT * FROM timepass;

-- drop column
ALTER TABLE timepass DROP COLUMN val;

DESC timepass;

SELECT * FROM timepass;
```

# Query Performance
* Query cost depends on
	* Machine settings
	* MySQL version
	* "Optimization settings"
* Lower query cost, means more efficient query.

```SQL
SELECT job, SUM(sal) FROM emp
WHERE job IN ('ANALYST', 'SALESMAN')
GROUP BY job;

SELECT job, SUM(sal) FROM emp
GROUP BY job
HAVING job IN ('ANALYST', 'SALESMAN');

EXPLAIN FORMAT=JSON
SELECT job, SUM(sal) FROM emp
WHERE job IN ('ANALYST', 'SALESMAN')
GROUP BY job;

EXPLAIN FORMAT=JSON
SELECT job, SUM(sal) FROM emp
GROUP BY job
HAVING job IN ('ANALYST', 'SALESMAN');

SELECT e.ename, m.ename mname FROM emp e
INNER JOIN emp m ON e.mgr = m.empno;

EXPLAIN FORMAT=JSON
SELECT e.ename, m.ename mname FROM emp e
INNER JOIN emp m ON e.mgr = m.empno;

SELECT e.ename, d.dname FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;

EXPLAIN FORMAT=JSON
SELECT e.ename, d.dname FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;
```

# Indexes
* syntax: CREATE INDEX idx_name ON tablename(colname);

```SQL
SELECT * FROM emp WHERE job='CLERK';

EXPLAIN FORMAT=JSON
SELECT * FROM emp WHERE job='CLERK';
-- cost = 1.65

DESC emp;

CREATE INDEX idx_emp_job ON emp(job);

DESC emp;

EXPLAIN FORMAT=JSON
SELECT * FROM emp WHERE job='CLERK';
-- cost = 0.90


SELECT * FROM emp WHERE deptno=20;

EXPLAIN FORMAT=JSON
SELECT * FROM emp WHERE deptno=20;
-- cost = 1.65

CREATE INDEX idx_emp_deptno ON emp(deptno);

EXPLAIN FORMAT=JSON
SELECT * FROM emp WHERE deptno=20;
-- cost = 1.00
```



## Doubts solved after class

```SQL
SELECT e.ename, d.dname FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;

SELECT e.ename, d.dname FROM emp e
INNER JOIN dept d USING (deptno);
-- when column to be joined in both tables have same name.

SELECT e.ename, d.dname FROM emp e
NATURAL JOIN dept d;
-- join two tables on the similar column names.
-- in this example: column name to be joined = deptno.
```


























