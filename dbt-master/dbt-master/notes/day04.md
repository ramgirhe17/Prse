# DQL - SELECT
* cmd> mysql -u edac -pedac dacdb

```SQL
SELECT USER(), DATABASE();
-- edac user, dacdb database.

SHOW TABLES;
```

* Fetch records from the server (mysqld) disk and send to the client (mysql).

```SQL
SELECT * FROM books;

SELECT id, subject, price, author, name FROM books;

SELECT id, name, price FROM books;

SELECT * FROM emp;

-- fetch emp id, name and sal from emp table.
SELECT empno, ename, sal FROM emp;

SELECT  empno AS 'emp id', ename AS 'emp name', sal AS 'salary' FROM emp;
-- AS keyword is used to give alias to a column.
-- AS keyword is optional.
-- if alias name contains space or special chars, they must be quoted. '---' or `---`
-- if alias name doesn't contain space or special chars, quotes are optional.

SELECT  empno 'emp id', ename 'emp name', sal salary FROM emp;
```

## Computed column

```SQL
-- print book id, name, price and gst (5% of price).
SELECT id, name, price FROM books;
SELECT id, name, price, price * 0.05 FROM books;
SELECT id, name, price, price * 0.05 gst FROM books;

-- print book id, name, price, gst (5% of price) and total (price + gst).
SELECT id, name, price, price * 0.05 gst, price + price * 0.05 total FROM books;

-- print empno, ename, sal, category of employee (emp table).
-- <= 1500: Poor, > 1500 AND <= 2500: Middle, > 2500: Rich
SELECT empno, ename, sal FROM emp;

SELECT empno, ename, sal,
CASE
WHEN sal <= 1500 THEN 'Poor'
WHEN sal > 1500 AND sal <= 2500 THEN 'Middle'
ELSE 'Rich'
END AS category
FROM emp;

-- print empno, ename, sal, category of employee (emp table) and dept.
-- 10=ACCOUNTS, 20=RESEARCH, 30=SALES, *=OPERATIONS
SELECT empno, ename, sal,
CASE
WHEN sal <= 1500 THEN 'Poor'
WHEN sal > 1500 AND sal <= 2500 THEN 'Middle'
ELSE 'Rich'
END AS category,
deptno,
CASE
WHEN deptno=10 THEN 'ACCOUNTS'
WHEN deptno=20 THEN 'RESEARCH'
WHEN deptno=30 THEN 'SALES'
ELSE 'OPERATIONS'
END AS dept
FROM emp;

```

## DISTINCT column

```SQL
SELECT subject FROM books;

-- fetch unique subjects from books
SELECT DISTINCT subject FROM books;

-- fetch unique deptno from emp.
SELECT DISTINCT deptno FROM emp;

-- fetch unique job from emp.
SELECT DISTINCT job FROM emp;

-- unique jobs per dept OR unique depts per job OR unique combination of dept & job.
SELECT DISTINCT deptno, job FROM emp;
```

## LIMIT clause
* SELECT cols FROM tablename LIMIT n;
	* get n rows.
* SELECT cols FROM tablename LIMIT m,n;
	* get n rows after skipping first m rows.

```SQL
SELECT * FROM books;

-- get first 5 books
SELECT * FROM books LIMIT 5;

-- skip first 3 books and get next 2 books
SELECT * FROM books LIMIT 3,2;
```

## ORDER BY clause
* SELECT cols FROM tablename ORDER BY col;
	* sort records by column in asc order. (default order is ASC)
* SELECT cols FROM tablename ORDER BY col ASC;
	* sort records by column in asc order.
* SELECT cols FROM tablename ORDER BY col DESC;
	* sort records by column in desc order.

```SQL
SELECT * FROM books ORDER BY price;

SELECT * FROM books ORDER BY price DESC;

SELECT * FROM books ORDER BY author;

SELECT * FROM emp ORDER BY hire;

SELECT empno,ename,deptno,job FROM emp ORDER BY deptno,job;

SELECT empno,ename,deptno,job FROM emp ORDER BY job,deptno;

SELECT deptno,job FROM emp ORDER BY deptno,job;

-- sort all emp deptwise (asc), for same depts sort salwise in desc order.
SELECT * FROM emp ORDER BY deptno ASC, sal DESC;

-- in mysql, ORDER BY can be done by alias name.
SELECT empno, ename, sal,
CASE
WHEN sal <= 1500 THEN 'Poor'
WHEN sal > 1500 AND sal <= 2500 THEN 'Middle'
ELSE 'Rich'
END AS category
FROM emp
ORDER BY category;

-- in mysql, ORDER BY can be done by column number.
SELECT empno, ename, sal,
CASE
WHEN sal <= 1500 THEN 'Poor'
WHEN sal > 1500 AND sal <= 2500 THEN 'Middle'
ELSE 'Rich'
END AS category
FROM emp
ORDER BY 4 DESC;

```

## ORDER BY + LIMIT

```SQL
-- print book with highest price
SELECT * FROM books ORDER BY price DESC LIMIT 1;

-- print book with lowest price
SELECT * FROM books ORDER BY price ASC LIMIT 1;

-- print book with third highest price
SELECT * FROM books ORDER BY price DESC;
SELECT * FROM books ORDER BY price DESC LIMIT 2,1;
```

## WHERE clause
* SELECT cols FROM tablename WHERE  condition;
	- only rows matching condition (=true) will be displayed.
* Relational operators
	- <, >, <=, =>, =, != or <>
* Logical operators
	- AND, OR, NOT

```SQL
SELECT * FROM emp WHERE deptno=20;

SELECT * FROM emp WHERE sal > 2500;

SELECT * FROM emp WHERE job = 'SALESMAN';

SELECT * FROM emp WHERE job = 'ANALYST' AND deptno = 20;
```

SELECT DISTINCT deptno,job FROM emp ORDER BY deptno,job;

SELECT * FROM emp ORDER BY 1,2,3,4,5,6,7,8;


