# Constraints

## Foreign Key Constraints

```SQL
DROP TABLE IF EXISTS depts;
DROP TABLE IF EXISTS emps;

CREATE TABLE depts (deptno INT, dname VARCHAR(20), PRIMARY KEY(deptno));
INSERT INTO depts VALUES (10, 'DEV');
INSERT INTO depts VALUES (20, 'QA');
INSERT INTO depts VALUES (30, 'OPS');
INSERT INTO depts VALUES (40, 'ACC');

CREATE TABLE emps (
	empno INT PRIMARY KEY,
	ename VARCHAR(20),
	deptno INT,
	mgr INT,
	FOREIGN KEY (mgr) REFERENCES emps(empno),
	FOREIGN KEY (deptno) REFERENCES depts(deptno)
);
DESC emps;

INSERT INTO emps VALUES (5, 'Sarang', NULL, NULL);
INSERT INTO emps VALUES (4, 'Nitin', NULL, 5);
INSERT INTO emps VALUES (1, 'Amit', 10, 4);
INSERT INTO emps VALUES (3, 'Nilesh', 20, 4);
INSERT INTO emps VALUES (2, 'Rahul', 10, 3);
```

```SQL
SHOW CREATE TABLE depts;
-- primary key = deptno

SHOW CREATE TABLE emps;
-- Foreign key = deptno

SELECT * FROM depts;

SELECT * FROM emps;

DELETE FROM depts WHERE deptno=10;
-- error: cannot delete parent row.

UPDATE depts SET deptno=60 WHERE deptno=10;
-- error: cannot update parent row's primary key.

DELETE FROM depts WHERE deptno=40;
-- okay: no child row for deptno=40.
```

```SQL
DROP TABLE IF EXISTS emps;
DROP TABLE IF EXISTS depts;

CREATE TABLE depts (deptno INT, dname VARCHAR(20), PRIMARY KEY(deptno));
INSERT INTO depts VALUES (10, 'DEV');
INSERT INTO depts VALUES (20, 'QA');
INSERT INTO depts VALUES (30, 'OPS');
INSERT INTO depts VALUES (40, 'ACC');

CREATE TABLE emps (
	empno INT PRIMARY KEY,
	ename VARCHAR(20),
	deptno INT,
	mgr INT,
	FOREIGN KEY (deptno) REFERENCES depts(deptno) ON DELETE CASCADE ON UPDATE CASCADE 
);
DESC emps;

INSERT INTO emps VALUES (5, 'Sarang', NULL, NULL);
INSERT INTO emps VALUES (4, 'Nitin', NULL, 5);
INSERT INTO emps VALUES (1, 'Amit', 10, 4);
INSERT INTO emps VALUES (3, 'Nilesh', 20, 4);
INSERT INTO emps VALUES (2, 'Rahul', 10, 3);

SELECT * FROM depts;

SELECT * FROM emps;

UPDATE depts SET deptno=60 WHERE deptno=10;
-- update deptno=10 to deptno=60 in depts table (parent row)
-- also update deptno=60 in emps table (child rows -- Amit & Rahul)

SELECT * FROM depts;

SELECT * FROM emps;

DELETE FROM depts WHERE deptno=60;
-- delete deptno=60 from depts table (parent row)
-- also delete deptno=60 in emps table (child rows -- Amit & Rahul)

SELECT * FROM depts;

SELECT * FROM emps;
```

```SQL
SELECT @@foreign_key_checks;

SET @@foreign_key_checks = 0;

SELECT @@foreign_key_checks;

INSERT INTO emps VALUES(6, 'Vishal', 100, 3);
-- not good practice
-- allowed: because foreign_key_checks are disabled.

SELECT * FROM emps;

SELECT * FROM depts;

SET @@foreign_key_checks = 1;

INSERT INTO emps VALUES(7, 'Smita', 100, 3);
-- error: because foreign_key_checks are enabled.

SELECT * FROM emps;
```

## CHECK constraint

```SQL
SELECT @@version;
-- must be >= 8.0.16

CREATE TABLE newemp(
	id INT PRIMARY KEY,
	name CHAR(20) NOT NULL,
	sal DOUBLE CHECK (sal >= 5000),
	comm DOUBLE,
	job CHAR(20) CHECK (job IN ('CLERK', 'MANAGER', 'SALESMAN')),
	age INT CHECK (age >= 18),
	CHECK (sal + comm <= 50000)
);

INSERT INTO newemp VALUES (1, 'A', 10000, 1000, 'MANAGER', 20);

INSERT INTO newemp VALUES (2, 'B', 4000, 1000, 'MANAGER', 20);
-- error: sal < 5000

INSERT INTO newemp VALUES (3, 'C', 40000, 11000, 'MANAGER', 20);
-- error: sal + comm > 50000

INSERT INTO newemp VALUES (4, 'D', 8000, 2000, 'MANAGER', 16);
-- error: age < 18

INSERT INTO newemp VALUES (5, 'E', 8000, 2000, 'PRESIDENT', 40);
-- error: job is not valid
```

# Sub-query

## Single Row Sub-queries

```SQL
-- find the employee with max sal.

SELECT * FROM emp WHERE sal = MAX(sal);
-- error: group fn cannot be used in where clause.

SELECT MAX(sal) FROM emp;
SELECT * FROM emp WHERE sal = 5000.0;
-- working, but manually copying result of first query into second query.

SET @maxsal = (SELECT MAX(sal) FROM emp);
SELECT @maxsal;
SELECT * FROM emp WHERE sal = @maxsal;
-- working, but two queries are involved.

SELECT * FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);
-- working in single query -- Sub-query approach.
```

```SQL
-- find all employees whose sal is more than average sal of all employees.
SET @avgsal = (SELECT AVG(sal) FROM emp);
SELECT * FROM emp WHERE sal > @avgsal;
SELECT @avgsal;

SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp);
```

```SQL
-- find employees with second highest salary.
SELECT * FROM emp ORDER BY sal DESC;

SELECT * FROM emp ORDER BY sal DESC LIMIT 1,1;
-- will not show all emps having 2nd highest sal

SELECT DISTINCT sal FROM emp ORDER BY sal DESC LIMIT 1,1;

SET @avg2 = (SELECT DISTINCT sal FROM emp ORDER BY sal DESC LIMIT 1,1);
SELECT @avg2; -- 3000.00
SELECT * FROM emp WHERE sal = @avg2;

SELECT * FROM emp WHERE sal = (SELECT DISTINCT sal FROM emp ORDER BY sal DESC LIMIT 1,1);
```


```SQL
-- find employees with third highest salary.
SELECT DISTINCT sal FROM emp ORDER BY sal DESC LIMIT 2,1;

SELECT * FROM emp WHERE sal = (SELECT DISTINCT sal FROM emp ORDER BY sal DESC LIMIT 2,1);
```

```SQL
-- find employees with third lowest salary.
SELECT DISTINCT sal FROM emp ORDER BY sal ASC LIMIT 2,1;

SELECT * FROM emp WHERE sal = (SELECT DISTINCT sal FROM emp ORDER BY sal ASC LIMIT 2,1);
```

## Multi-Row sub-query

```SQL
SELECT sal FROM emp WHERE job='MANAGER';

-- Find all employees whose sal is more than any manager.
SELECT MIN(sal) FROM emp WHERE job='MANAGER';

SELECT * FROM emp WHERE sal > (SELECT MIN(sal) FROM emp WHERE job='MANAGER');
-- solution using single row sub-query

SELECT sal FROM emp WHERE job='MANAGER';

SELECT * FROM emp WHERE sal > ANY(SELECT sal FROM emp WHERE job='MANAGER');
-- solution using multi row sub-query

-- Find all employees whose sal is more than all the managers.
SELECT MAX(sal) FROM emp WHERE job='MANAGER';

SELECT * FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE job='MANAGER');
-- solution using single row sub-query

SELECT sal FROM emp WHERE job='MANAGER';

SELECT * FROM emp WHERE sal > ALL(SELECT sal FROM emp WHERE job='MANAGER');
-- solution using multi row sub-query
```

```SQL
-- Find all depts which contain at least one employee.
SELECT deptno FROM emp;

SELECT * FROM dept WHERE deptno = ANY(SELECT deptno FROM emp);

SELECT * FROM dept WHERE deptno IN (SELECT deptno FROM emp);

-- Find all depts which doesn't contain any employee.
SELECT * FROM dept WHERE deptno != ALL(SELECT deptno FROM emp);

SELECT * FROM dept WHERE deptno NOT IN (SELECT deptno FROM emp);

SELECT * FROM dept WHERE deptno != ANY(SELECT deptno FROM emp);
-- wrong result
```


## Co-related sub-query

```SQL
DROP TABLE IF EXISTS emp;
DROP TABLE IF EXISTS dept;

CREATE TABLE dept(deptno INT(4), dname VARCHAR(40), loc VARCHAR(40));

INSERT INTO dept VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO dept VALUES (20,'RESEARCH','DALLAS');
INSERT INTO dept VALUES (30,'SALES','CHICAGO');
INSERT INTO dept VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE emp(empno INT(4), ename VARCHAR(40), job VARCHAR(40), mgr INT(4), hire DATE, sal DECIMAL(8,2), comm DECIMAL(8,2), deptno INT(4));

INSERT INTO emp VALUES (7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20);
INSERT INTO emp VALUES (7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30);
INSERT INTO emp VALUES (7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30);
INSERT INTO emp VALUES (7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20);
INSERT INTO emp VALUES (7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30);
INSERT INTO emp VALUES (7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30);
INSERT INTO emp VALUES (7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10);
INSERT INTO emp VALUES (7788,'SCOTT','ANALYST',7566,'1982-12-09',3000.00,NULL,20);
INSERT INTO emp VALUES (7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10);
INSERT INTO emp VALUES (7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30);
INSERT INTO emp VALUES (7876,'ADAMS','CLERK',7788,'1983-01-12',1100.00,NULL,20);
INSERT INTO emp VALUES (7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30);
INSERT INTO emp VALUES (7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20);
INSERT INTO emp VALUES (7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

SELECT * FROM dept WHERE deptno IN (SELECT DISTINCT deptno FROM emp);

SELECT * FROM dept d WHERE d.deptno IN (SELECT e.deptno FROM emp e WHERE e.deptno = d.deptno);

SELECT * FROM dept d WHERE EXISTS (SELECT e.deptno FROM emp e WHERE e.deptno = d.deptno);

SELECT @@optimizer_switch;
SET @@optimizer_switch='materialization=off';
SET @@optimizer_switch='subquery_materialization_cost_based=off';
SET @@optimizer_switch='block_nested_loop=off';
SET @@optimizer_switch='semijoin=off';

-- costs may differ with platform (OS) and mysql version.

EXPLAIN FORMAT=JSON
SELECT * FROM dept WHERE deptno IN (SELECT DISTINCT deptno FROM emp);

EXPLAIN FORMAT=JSON
SELECT * FROM dept d WHERE d.deptno IN (SELECT e.deptno FROM emp e WHERE e.deptno = d.deptno);

EXPLAIN FORMAT=JSON
SELECT * FROM dept d WHERE EXISTS (SELECT e.deptno FROM emp e WHERE e.deptno = d.deptno);
```

```SQL
SELECT * FROM dept d WHERE NOT EXISTS (SELECT e.deptno FROM emp e WHERE e.deptno = d.deptno);
```






