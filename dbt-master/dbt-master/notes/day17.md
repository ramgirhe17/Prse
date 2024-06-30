# Sub-Query
* Query within query.
	* SELECT within SELECT.
	* In MySQL, sub-query is allowed in UPDATE & DELETE also.
		* SELECT in UPDATE & SELECT in DELETE.
		* Cannot UPDATE/DELETE the table on which sub-query is doing SELECT.

```SQL
-- delete employee with highest salary.
DELETE FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);
-- error: not allowed in MySQL

-- update employee with highest salary to decrease his sal by 500.
UPDATE emp SET sal = sal - 500  WHERE sal = (SELECT MAX(sal) FROM emp);
-- error: not allowed in MySQL

-- update dname='TRAINING' in which there are no employees.
UPDATE dept SET dname='TRAINING' WHERE deptno NOT IN (SELECT deptno FROM emp);
-- allowed:

SELECT * FROM dept;

-- delete depts in which there are no employees.
DELETE FROM dept WHERE deptno NOT IN (SELECT deptno FROM emp);

SELECT * FROM dept;
```

# Derived Tables

```SQL
-- find the max of avg sal per job.	
SELECT job, AVG(sal) FROM emp
GROUP BY job;

SELECT AVG(sal) FROM emp
GROUP BY job
ORDER BY 1 DESC
LIMIT 1;

-- using derived table
SELECT job, AVG(sal) avgsal FROM emp
GROUP BY job;

SELECT MAX(avgsal) FROM
(SELECT job, AVG(sal) avgsal FROM emp
GROUP BY job) AS jobsal;
-- jobsal is alias for "SELECT job, AVG(sal) avgsal FROM emp GROUP BY job" query result => derived table
```

# Views
* syntax: CREATE VIEW viewname AS SELECT ...;

```SQL
CREATE VIEW v1_jobsal AS
SELECT job, AVG(sal) avgsal FROM emp
GROUP BY job;

SHOW TABLES;

DESCRIBE v1_jobsal;

SELECT * FROM v1_jobsal;

SELECT * FROM v1_jobsal ORDER BY avgsal DESC;

SELECT MAX(avgsal) FROM v1_jobsal;
```

```SQL
CREATE VIEW v2_emp AS
SELECT * FROM emp;
-- v2_emp = emp

SELECT * FROM v2_emp;

CREATE VIEW v3_emp AS
SELECT empno, ename, sal, comm FROM emp;
-- v3_emp = view of emps with limited columns

SELECT * FROM v3_emp;

CREATE VIEW v4_emp AS
SELECT empno, ename, sal, comm, sal + IFNULL(comm,0.0) income FROM emp;
-- v4_emp = view of emps with limited columns + computed columns

DESC v4_emp;

SELECT * FROM v4_emp;

CREATE VIEW v5_emp AS
SELECT * FROM emp WHERE sal > 2000;
-- v5_emp = view of emps with limited rows

DESC v5_emp;

SELECT * FROM v5_emp;

CREATE VIEW v6_emp AS
SELECT e.empno, e.ename, e.job, e.deptno, e.sal, e.comm, d.dname, d.loc FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;
-- v6_emp = joined view of emp and dept.

SELECT * FROM v6_emp;
```

* If DML operations are performed on main table(s), they will automatically reflect in the view.

```SQL
SELECT * FROM v6_emp;

INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp(empno,ename,job,sal,comm,deptno) VALUES(1000, 'STEVE', 'DIRECTOR', 4500.00, NULL, 40);

SELECT * FROM emp;

SELECT * FROM v6_emp;

SELECT * FROM v1_jobsal;
```

* Changes done in view will be reflected in main table (if possible).
	* Simple views --> WHERE, ORDER, LIMIT, ... 

```SQL
SELECT * FROM v3_emp;

INSERT INTO v3_emp VALUES (1001, 'BILL', 3500.00, 0.0);

SELECT * FROM v3_emp;

SELECT * FROM emp;
```

* Changes done in view will not be reflected in main table (if not possible).
	* Complex views --> Computed columns, GROUP BY, JOIN, Sub-queries.

```SQL
SELECT * FROM v1_jobsal;

DELETE FROM v1_jobsal WHERE job='MANAGER';
-- error: not allowed

INSERT INTO v1_jobsal VALUES ('TRAINER', 7000.0);
-- error: not allowed
```

```SQL
SELECT * FROM v5_emp;
-- view of emps where sal > 2000.

INSERT INTO v5_emp(empno,ename,job,sal) VALUES(1003, 'CHEN', 'GUARD', 1200);

SELECT * FROM v5_emp;

SELECT * FROM emp;
```
* "WITH CHECK OPTION" check WHERE clause condition while executing DML operations on views. DML operations are allowed only when condition holds true.


```SQL
CREATE VIEW v7_emp AS
SELECT * FROM emp WHERE sal > 2000
WITH CHECK OPTION;

INSERT INTO v7_emp(empno,ename,job,sal) VALUES(1004, 'ROD', 'GUARD', 1300);
-- error: check option failed

INSERT INTO v7_emp(empno,ename,job,sal) VALUES(1005, 'JOHN', 'GUARD', 2300);
```

```SQL
SHOW TABLES;

SHOW FULL TABLES;

SHOW FULL TABLES WHERE Table_type='VIEW';
```

```SQL
DROP VIEW v5_emp;

SHOW FULL TABLES WHERE Table_type='VIEW';
```

* If original table is deleted, accessing view results in error.
* Programmer should delete views before the table.

```SQL
SELECT * FROM salgrade;

CREATE VIEW v_salgrade AS
SELECT * FROM salgrade;

SELECT * FROM v_salgrade;

DROP TABLE salgrade;

SHOW FULL TABLES WHERE Table_type='VIEW';

SELECT * FROM v_salgrade;
-- error: original table is dropped
```


```SQL
SELECT * FROM v6_emp;

CREATE VIEW v8_emp AS
SELECT ename, dname FROM v6_emp;
-- view based on another view

SELECT * FROM v8_emp;

SHOW CREATE VIEW v8_emp;

SHOW CREATE VIEW v6_emp;
```

```SQL
USE sales;

SELECT * FROM customers;

SELECT * FROM salespeople;

SELECT * FROM orders;

DROP VIEW IF EXISTS salesview;

CREATE VIEW salesview AS
SELECT c.cnum, c.cname, c.city ccity, c.rating, s.snum, s.sname, s.comm, s.city scity, o.onum, o.amt, o.odate
FROM orders o
INNER JOIN customers c ON o.cnum = c.cnum
INNER JOIN salespeople s ON o.snum = s.snum;

SELECT * FROM salesview;

-- print customers and salespeople living in same city.
SELECT * FROM salesview WHERE ccity = scity;
```

# RDBMS Security
* Login with "root" user.
	* terminal> mysql -u root -p

```SQL
SHOW DATABASES;

USE mysql;

SHOW TABLES;

DESCRIBE user;

SELECT user, host FROM user;

CREATE USER pmgr@'%' IDENTIFIED BY 'pmgr';
-- pmgr user created with pmgr password and he can login from any machine in the network.

GRANT ALL PRIVILEGES ON dacdb.* TO pmgr@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

SELECT user, host FROM user;

CREATE USER developer1@'%' IDENTIFIED BY 'developer1';

CREATE USER developer2@'%' IDENTIFIED BY 'developer2';

CREATE USER developer3@'%' IDENTIFIED BY 'developer3';

SHOW GRANTS;
-- show permissions for current user.

SHOW GRANTS FOR pmgr@'%';

SHOW GRANTS FOR developer1@'%';

```

* Login with pmgr user from another terminal.
	* terminal> mysql -u pmgr -ppmgr

```SQL
SHOW DATABASES;

USE dacdb;

SHOW TABLES;

GRANT INSERT,UPDATE,DELETE,SELECT ON dacdb.* TO developer1@'%';

GRANT INSERT,UPDATE,DELETE,SELECT ON dacdb.emp TO developer2@'%';

GRANT SELECT ON dacdb.dept TO developer3@'%';

GRANT SELECT ON dacdb.emp TO developer3@'%';
```

* Login with developer1 user from another terminal.

```SQL
SHOW DATABASES;

USE dacdb;

SHOW TABLES;

GRANT SELECT ON dacdb.books TO developer3@'%';
-- error: developer1 doesn't have GRANT OPTION.
```

* Login with developer3 user from another terminal.

```SQL
SHOW DATABASES;

USE dacdb;

SHOW TABLES;

SHOW GRANTS;

DELETE FROM dept;
-- error
```

* With root login

```SQL
SHOW GRANTS FOR developer2@'%';

REVOKE DELETE ON dacdb.emp FROM developer2@'%';

SHOW GRANTS FOR developer2@'%';
```

# Doubts

```SQL
USE sales;

-- not standard query (works in MySQL)
SELECT * FROM salespeople  WHERE (snum,city) != ALL(SELECT snum,city FROM customers);

-- standard solution using correlated sub-query
SELECT * FROM salespeople s
WHERE s.city NOT IN (SELECT c.city FROM customers c WHERE c.snum = s.snum);
```
