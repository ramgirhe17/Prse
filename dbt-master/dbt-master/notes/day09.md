# SQL Functions

## Group Functions

```SQL
SELECT IFNULL(comm,0) FROM emp;

SELECT LEAST(sal, IFNULL(comm,0)) FROM emp;

SELECT MIN(LEAST(sal, IFNULL(comm,0))) FROM emp;

SELECT MIN(comm), LEAST(sal, IFNULL(comm,0)) FROM emp;
-- error
```

### Limitations (SQL Limitations as per ANSI standard)
* Cannot select a column along with group function.
* Cannot select single row function along with group function.
* Cannot nest one group function in another group function.
* Cannot use group function in WHERE clause.

### MySQL config
* Steps to ensure that GROUP BY and GROUP functions work as per RDBMS/SQL standards.
1. Go to C:\ProgramData\MySQL\MySQL Server 8.0.
2. Open file: my.ini using notepad or vscode.
3. line 108: sql-mode="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION"
4. Restart the computer OR restart mysql server.
	* Run (Window+R) --> services.msc --> MySQL80 --> Right Click --> Stop and Right Click --> Start. 

```SQL
SELECT USER(), DATABASE();

SELECT @@sql_mode;
```

## SELECT

### GROUP BY clause
* SELECT colname, GROUPFN(col2name) FROM tablename GROUP BY colname;

```SQL
SELECT deptno, COUNT(empno) FROM emp;
-- error

SELECT deptno, COUNT(empno) FROM emp GROUP BY deptno;
-- 14 emps = 3 emps (dept=10), 5 emps (dept=20), 6 emps (dept=30).

SELECT job, AVG(sal) FROM emp GROUP BY job;
```



