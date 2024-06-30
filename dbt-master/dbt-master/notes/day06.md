# DQL - SELECT
* cmd> mysql -u edac -pedac dacdb

## LIMIT clause

## ORDER BY clause

## WHERE clause

### BETWEEN, IN and LIKE
* "%" means 0 or more occurrences of any character.

```SQL
-- find all emps whose name contains I
SELECT empno, ename, sal FROM emp WHERE ename LIKE '%I%';

-- find all emps whose name contains L twice (consecutive).
SELECT empno, ename, sal FROM emp WHERE ename LIKE '%LL%';

-- find all emps whose name contains A twice.
SELECT empno, ename, sal FROM emp WHERE ename LIKE '%A%A%';

-- find all emps whose name contains A.
SELECT empno, ename, sal FROM emp WHERE ename LIKE '%A%';
-- emps name containa A once or multiple times.

INSERT INTO emp (empno,ename) VALUES (4, 'ANAMIKA');

-- find all emps whose name contains A exactly once.
SELECT empno, ename, sal FROM emp WHERE (ename LIKE '%A%') AND (ename NOT LIKE '%A%A%');
```

```SQL
-- find all emps between 'F' and 'K'.
SELECT empno, ename, sal FROM emp WHERE ename BETWEEN 'F' AND 'K';

-- final all emp names starting from F to K.
SELECT empno, ename, sal FROM emp WHERE ename BETWEEN 'F' AND 'K' OR ename LIKE 'K%';

INSERT INTO emp (empno,ename) VALUES (5, 'ZEBRA');

-- final all emp names starting from S to Z.
SELECT empno, ename, sal FROM emp WHERE ename BETWEEN 'S' AND 'Z' OR ename LIKE 'Z%';
```

# DML - UPDATE 
* UPDATE tablename SET colname=new-value WHERE colname=value; 

```SQL
SELECT USER(), DATABASE();

SHOW TABLES;

SELECT * FROM books;

UPDATE books SET price=223.450 WHERE id=1001;

SELECT * FROM books;

UPDATE books SET author='Yashwant P Kanetkar', price=323.450 WHERE id=1001;

SELECT * FROM books;

-- increase price of all 'C Programming' books by 10%.
UPDATE books SET price = price + price * 0.10 WHERE subject = 'C Programming';

-- increase price of all books by 5%.
UPDATE books SET price = price + price * 0.05;
```

# DML - DELETE
* Can delete one or more rows.
* DELETE FROM tablename WHERE condition;

```SQL
-- delete single row
DELETE FROM books WHERE id=1001;

SELECT * FROM books;

-- delete multiple rows
DELETE FROM books WHERE subject='C++ Programming';

SELECT * FROM books;

-- delete all rows
DELETE FROM books;

DESCRIBE books;

SELECT * FROM books;
```

# DDL - TRUNCATE

```SQL
-- delete all rows
TRUNCATE TABLE emp;

DESCRIBE emp;

SELECT * FROM emp;
```

# DDL - DROP TABLE
* Deletes table structure as well as table data.

```SQL
SELECT * FROM dept;

DROP TABLE dept;

DESCRIBE dept;

SELECT * FROM dept;
```

```SQL
SHOW TABLES;

DROP TABLE items;

DROP TABLE IF EXISTS items;

DROP TABLE IF EXISTS salgrade;

SHOW TABLES;
```

# Restore all tables back

```SQL
SOURCE D:/pgdiploma/edac-dbt/data/classwork-db.sql 
```

# HELP

```SQL
HELP SELECT;

HELP Functions;

SELECT SUBSTRING(ename,1,1), ename FROM emp;

SELECT empno, ename, sal FROM emp WHERE SUBSTRING(ename,1,1) BETWEEN 'F' AND 'K';
```
