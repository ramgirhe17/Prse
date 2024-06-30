# DQL - SELECT

## GROUP BY
* terminal> mysql -u edac -pedac dacdb

```SQL
SHOW TABLES;

SELECT deptno, COUNT(empno) FROM emp GROUP BY deptno;
--+--------+--------------+
--| deptno | COUNT(empno) |
--+--------+--------------+
--|     10 |            3 |
--|     20 |            5 |
--|     30 |            6 |
--+--------+--------------+

SELECT COUNT(empno) FROM emp GROUP BY deptno;
-- grouped column may not be in SELECT statement, however usually result is meaningless/difficult understand.
--+--------------+
--| COUNT(empno) |
--+--------------+
--|            3 |
--|            5 |
--|            6 |
--+--------------+

SELECT deptno, COUNT(empno) FROM emp;
-- error: deptno is selected, then it must be grouped by.
```

### GROUP BY on multiple columns

```SQL
SELECT DISTINCT deptno, job FROM emp;
-- 10, CLERK 
-- 10, MANAGER
-- 10, PRESIDENT
-- 20, CLERK 
-- 20, MANAGER
-- 20, ANALYST
-- 30, CLERK 
-- 30, MANAGER
-- 30, SALESMAN

SELECT deptno, job, COUNT(empno) FROM emp
GROUP BY deptno, job;
-- 10, CLERK 	--> 1	
-- 10, MANAGER	--> 1
-- 10, PRESIDENT-->	1
-- 20, CLERK 	--> 2
-- 20, MANAGER	--> 1
-- 20, ANALYST	--> 2
-- 30, CLERK 	--> 1
-- 30, MANAGER	--> 1
-- 30, SALESMAN	--> 4

```

### GROUP BY with WHERE clause
* WHERE clause with filter records from the table.
* GROUP BY will group the records and perform aggregate operations.

```SQL
SELECT job, SUM(sal) FROM emp
GROUP BY job;
-- all 14 emps are sorted, grouped and sum(sal) is done.

SELECT job, SUM(sal) FROM emp
WHERE deptno != 10
GROUP BY job;
-- 11 emps (dept 20 & 30) emps are sorted, grouped and sum(sal) is done.

SELECT job, SUM(sal) FROM emp
WHERE sal >= 1500
GROUP BY job;
-- 8 emps (whose sal >= 1500) are sorted, grouped and sum(sal) is done.

SELECT job, SUM(sal) FROM emp
WHERE job IN ('SALESMAN', 'ANALYST', 'MANAGER')
GROUP BY job;
```

### HAVING clause
* Used to filter result based on "aggregate function" calculation.
* HAVING must be used with GROUP BY and syntactically immediately after GROUP BY.
* HAVING is used to put condition based on aggregate function and/or grouped column only.
* However using HAVING clause on grouped columns slow down the execution. It is recommended to use WHERE clause.

```SQL
SELECT job, AVG(sal) FROM emp
GROUP BY job;

-- find jobs whose avg sal is more than 1200.
SELECT job, AVG(sal) FROM emp
WHERE AVG(sal) > 1200
GROUP BY job;
-- error: group functions cannot be used in WHERE clause

SELECT job, AVG(sal) FROM emp
GROUP BY job
HAVING AVG(sal) > 1200;

SELECT job, AVG(sal) FROM emp
GROUP BY job
HAVING sal > 1200;
-- error: HAVING is used to put condition only on aggregate fns or grouped columns (not other columns.)

SELECT job, SUM(sal) FROM emp
WHERE job IN ('SALESMAN', 'ANALYST', 'MANAGER')
GROUP BY job;
--+----------+----------+
--| job      | SUM(sal) |
--+----------+----------+
--| SALESMAN |  5600.00 |
--| MANAGER  |  8275.00 |
--| ANALYST  |  6000.00 |
--+----------+----------+

SELECT job, SUM(sal) FROM emp
GROUP BY job
HAVING job IN ('SALESMAN', 'ANALYST', 'MANAGER');
--+----------+----------+
--| job      | SUM(sal) |
--+----------+----------+
--| SALESMAN |  5600.00 |
--| MANAGER  |  8275.00 |
--| ANALYST  |  6000.00 |
--+----------+----------+
```

### GROUP BY with ORDER BY

```SQL
-- print avg sal per job in sorted order of job.
SELECT job, AVG(sal) FROM emp
GROUP BY job
ORDER BY job;

SELECT job, ROUND(AVG(sal), 2) FROM emp
GROUP BY job
ORDER BY job;

-- print avg sal per job in descending order of avg sal.
SELECT job, AVG(sal) FROM emp
GROUP BY job
ORDER BY AVG(sal) DESC;

SELECT job, AVG(sal) FROM emp
GROUP BY job
ORDER BY 2 DESC;
-- sort by 2nd column in SELECT.

SELECT job, AVG(sal) AS avgsal FROM emp
GROUP BY job
ORDER BY avgsal DESC;
```

### GROUP BY with ORDER BY and LIMIT

```SQL
-- find the dept which spend max/highest on sal of emps
SELECT deptno, SUM(sal) AS sumsal FROM emp
GROUP BY deptno
ORDER BY sumsal DESC
LIMIT 1;

-- find the dept which spend second lowest on income (sal+comm) of emps

SELECT deptno, SUM( sal + IFNULL(comm,0.0) ) AS sum_income FROM emp
GROUP BY deptno
ORDER BY sum_income ASC
LIMIT 1,1;
```

### SELECT syntax

```
HELP SELECT;

SELECT col1, expr1, expr2, ... FROM tablename
WHERE condition
GROUP BY col1, ...
HAVING condition
ORDER BY col1, ...
LIMIT m, n;
```

# Transactions
* Transaction is set of DML operations executed as a single unit.
	* If any operation from the set fails, the other operations will be discarded.
* START TRANSACTION;
	* If no transaction started, every DML operation is by default auto-commited.
	* Once transaction is started, all DML operation changes will be saved in temporary tables on server (not in main table). The temporary table internally created for each transaction.
	* During transaction when SELECT query is executed, the merged (original table + changes) result is sent to that client.
	* Transaction is completed when COMMIT or ROLLBACK is done.
* COMMIT WORK; -- WORK is optional ANSI keyword.
	* All changes recorded in the temporary table (of that tx) are permanently saved into main table.
* ROLLBACK WORK; -- WORK is optional ANSI keyword.
	* All changes recorded in the temporary table (of that tx) are permanently discarded.
* Any DML operation performed after completion of transaction (COMMIT or ROLLBACK) will be again auto-commited.

```SQL
-- banking: accounts table (accid, type, balance, ...)
-- transfer rs. 5000/- from account 1 to account 2.
UPDATE accounts SET balance = balance - 5000 WHERE accid = 1;
UPDATE accounts SET balance = balance + 5000 WHERE accid = 2;
```


```SQL
-- banking: accounts table (accid, type, balance, ...)
CREATE TABLE accounts(accid INT, type VARCHAR(20), balance DECIMAL(10,2));
INSERT INTO accounts VALUES (1, 'Saving', 50000);
INSERT INTO accounts VALUES (2, 'Saving', 500);
SELECT * FROM accounts;
-- 1=50000, 2=500

START TRANSACTION;
UPDATE accounts SET balance = balance - 5000 WHERE accid = 1;
SELECT * FROM accounts;
-- 1=45000, 2=500
UPDATE accounts SET balance = balance + 5000 WHERE accid = 2;
SELECT * FROM accounts;
-- 1=45000, 2=5500
COMMIT WORK;
SELECT * FROM accounts;
-- 1=45000, 2=5500

START TRANSACTION;
UPDATE accounts SET balance = balance - 2000 WHERE accid = 1;
SELECT * FROM accounts;
-- 1=43000, 2=5500
UPDATE accounts SET balance = balance + 2000 WHERE accid = 2;
SELECT * FROM accounts;
-- 1=43000, 2=7500
ROLLBACK WORK;
SELECT * FROM accounts;
-- 1=45000, 2=5500

```
















