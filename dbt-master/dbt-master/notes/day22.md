# Joins

```SQL
SELECT e.ename, d.dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;
-- ON "condition": condition can be equal, not equal, greater, smaller, ...
-- column names from both tables can be different e.g. table1.deptno and table2.deptid

SELECT e.ename, d.dname FROM emp e INNER JOIN dept d USING (deptno);
-- USING: condition is equality check only.
-- column names from both tables must be same.

SELECT e.ename, d.dname FROM emp e NATURAL JOIN dept d;
-- auto join columns in both tables having same name.
-- condition is equality check only
-- inner join only
```

# Temporary Tables
* MySQL specific feature.
* It is like views, but materialized (space is allocated to table in RAM).
* Any changes done in main table(s) are NOT reflected into temp table.
* DML operations can be done on temp tables; however data will not reflect into main table.
* Mainly used to speed up some operations.
* Scope & life of table is limited to current user session only.

```SQL
-- count number of employees in each dept and also display dept name.
SELECT d.dname, COUNT(e.empno) cnt FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
GROUP BY d.dname;

-- view for dept & emp
CREATE VIEW v_emp_dept AS
SELECT d.dname, e.empno FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno;

SELECT dname, COUNT(empno) cnt FROM v_emp_dept
GROUP BY dname;

-- temporary table for dept & emp
CREATE TEMPORARY TABLE t_emp_dept
SELECT d.dname, e.empno FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno;

SHOW TABLES;
-- temp table is hidden

SELECT * FROM t_emp_dept;

SELECT dname, COUNT(empno) cnt FROM t_emp_dept
GROUP BY dname;
-- faster -- no join is executed -- only group by on temp table is done.

EXIT;
```

```SQL
SELECT * FROM t_emp_dept;
-- error: table does not exists.
-- table is auto deleted when session is completed.

-- creating table again.
CREATE TEMPORARY TABLE t_emp_dept
SELECT d.dname, e.empno FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno;

SELECT dname, COUNT(empno) cnt FROM t_emp_dept
GROUP BY dname;

DROP TEMPORARY TABLE t_emp_dept;
-- temp tables can be deleted manually also

SELECT * FROM t_emp_dept;
-- error: table does not exists.
-- table is dropped manually.
```




