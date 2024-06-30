# Indexes

```SQL
DESC emp;

CREATE INDEX idx_emp_hire ON emp(hire DESC);
-- index is sorted in desc order of hire

SELECT * FROM emp ORDER BY hire DESC;

CREATE INDEX idx_emp_mgr ON emp(mgr ASC);
-- index is sorted in asc order of mgr

DESC emp;
```

## Types of indexes

```SQL
-- Regular Index
CREATE INDEX idx_emp_sal ON emp(sal ASC);

SELECT * FROM emp WHERE sal = 3000.0;

-- Unique Index
CREATE UNIQUE INDEX idx_emp_ename ON emp(ename ASC);

DESC emp;

SELECT * FROM emp WHERE ename='KING';

INSERT INTO emp(empno,ename,sal) VALUES(1001, 'KING', 6000.0);
-- error: duplicate values not allowed - due to UNIQUE index.

-- Composite Index -- on multiple columns
CREATE INDEX idx_emp_deptno_job ON emp(deptno, job);

SELECT * FROM emp WHERE deptno=20 AND job='CLERK';

DROP TABLE IF EXISTS students;

CREATE TABLE students (std INT, roll INT, name VARCHAR(20), addr VARCHAR(50));

INSERT INTO students VALUES (1,1,'A','Pune'), (1,2,'B','Pune'), (1,3,'C','Pune'), (2,1,'D','Pune'), (2,2,'E','Pune');

SELECT * FROM students;

-- Composite UNIQUE index -- Duplicate combination (std,roll) is not allowed.
CREATE UNIQUE INDEX idx_stud ON students(std,roll);

DESC students;

INSERT INTO students VALUES (3, 6, 'F', 'Pune');

INSERT INTO students VALUES (3, 6, 'G', 'Pune');
-- error: student with std=3, roll=6 already exists.

SELECT * FROM students WHERE std=3 AND roll=6;

-- clustered index
ALTER TABLE emp ADD PRIMARY KEY(empno);

DESC emp;
```

```SQL
SHOW INDEXES FROM emp;

DROP INDEX idx_emp_deptno_job ON emp;

SELECT * FROM emp WHERE deptno=20 AND job='CLERK';
-- slow down

SHOW INDEXES FROM emp;
```

# Constraints

## NOT NULL

```SQL
CREATE TABLE t1(c1 INT NOT NULL, c2 CHAR(20) NOT NULL, c3 DECIMAL(5,2));

DESC t1;

INSERT INTO t1 VALUES(1, 'A', 23.4);

INSERT INTO t1 VALUES(1, NULL, 23.4);
-- error

INSERT INTO t1 VALUES(NULL, NULL, 23.4);
-- error

INSERT INTO t1 (c1,c3) VALUES(2, 12.4);
-- error

INSERT INTO t1 VALUES(3, 'C', NULL);
-- allowed
```

## UNIQUE

```SQL
CREATE TABLE people(
	id INT UNIQUE NOT NULL, -- column level constraint
	name VARCHAR(20),
	addr VARCHAR(80), 
	email CHAR(40), 
	mobile CHAR(16),
	CONSTRAINT c1 UNIQUE(email), -- table level named constraint
	UNIQUE(mobile), -- table level constraint
	UNIQUE(name,addr) -- must be table level constraint
);

DESC people;

SHOW INDEXES FROM people;

INSERT INTO people VALUES (1, 'A', 'Pune', 'a@gmail.com', '1234567890');

INSERT INTO people VALUES (2, 'B', 'Pune', NULL, NULL);

INSERT INTO people VALUES (3, 'C', 'Pune', 'c@gmail.com', NULL);

INSERT INTO people VALUES (4, 'D', 'Pune', 'd@gmail.com', '1234567890');
-- mobile UNIQUE index -- duplicate not allowed

INSERT INTO people VALUES (NULL, 'E', 'Pune', 'e@gmail.com', NULL);
-- id is NOT NULL

INSERT INTO people VALUES (5, 'C', 'Pune', 'f@gmail.com', NULL);
-- error: name & addr compbination cannot be duplicated.

SHOW CREATE TABLE people;
```

## PRIMARY KEY
* Primary Key = Unique + Not NULL
	* Cannot be duplicated
	* Compulsory
* Unique columns can be multiple, but Primary Key column is only one per table.
* Primary Key identifies each record in the table.

```SQL
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
	email CHAR(40) PRIMARY KEY, -- column level
	name VARCHAR(40),
	addr VARCHAR(100),
	age INT
);

-- OR

CREATE TABLE customers(
	email CHAR(40),
	name VARCHAR(40),
	addr VARCHAR(100),
	age INT,
	PRIMARY KEY (email) -- table level
);

-- OR

CREATE TABLE customers(
	email CHAR(40),
	name VARCHAR(40),
	addr VARCHAR(100),
	age INT,
	CONSTRAINT pk_customers PRIMARY KEY (email) -- table level named
);

DESC customers;

INSERT INTO customers VALUES ('a@gmail.com', 'A', 'Pune', 23);
INSERT INTO customers VALUES ('b@gmail.com', 'B', 'Pune', 24);
INSERT INTO customers VALUES (NULL, 'C', 'Pune', 22);
-- error: cannot be null
INSERT INTO customers VALUES ('b@gmail.com', 'D', 'Pune', 20);
-- error: cannot be duplicated

SHOW INDEXES FROM customers;

-- composite primary key
DROP TABLE IF EXISTS students;

CREATE TABLE students (
	std INT, 
	roll INT, 
	name VARCHAR(20), 
	addr VARCHAR(50),
	PRIMARY KEY(std,roll)
);

DESC students;

-- surrogate primary key
CREATE TABLE persons(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name CHAR(20),
	age INT
);

INSERT INTO persons(name,age) VALUES('A', 22);
INSERT INTO persons(name,age) VALUES('B', 23);
INSERT INTO persons(name,age) VALUES('C', 25);
INSERT INTO persons(name,age) VALUES('D', 21);
INSERT INTO persons(name,age) VALUES('E', 20);

SELECT * FROM persons;

ALTER TABLE persons AUTO_INCREMENT=1000;
INSERT INTO persons(name,age) VALUES('F', 19);
INSERT INTO persons(name,age) VALUES('G', 18);

SELECT * FROM persons;
```

## Foreign Key

```SQL
DROP TABLE IF EXISTS depts;
DROP TABLE IF EXISTS emps;

CREATE TABLE depts (deptno INT, dname VARCHAR(20), PRIMARY KEY(deptno));
INSERT INTO depts VALUES (10, 'DEV');
INSERT INTO depts VALUES (20, 'QA');
INSERT INTO depts VALUES (30, 'OPS');
INSERT INTO depts VALUES (40, 'ACC');

CREATE TABLE emps (
	empno INT,
	ename VARCHAR(20),
	deptno INT,
	mgr INT,
	FOREIGN KEY (deptno) REFERENCES depts(deptno) 
);
DESC emps;

INSERT INTO emps VALUES (1, 'Amit', 10, 4);
INSERT INTO emps VALUES (2, 'Rahul', 10, 3);
INSERT INTO emps VALUES (3, 'Nilesh', 20, 4);
INSERT INTO emps VALUES (4, 'Nitin', 50, 5);
-- error: deptno=50 dept does not exists.
INSERT INTO emps VALUES (5, 'Sarang', 50, NULL);
-- error: deptno=50 dept does not exists.

DROP TABLE IF EXISTS emps;

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
-- fk can be NULL
INSERT INTO emps VALUES (1, 'Amit', 10, 4);
INSERT INTO emps VALUES (3, 'Nilesh', 20, 4);
INSERT INTO emps VALUES (2, 'Rahul', 10, 3);

````

```SQL
-- alternate FOREIGN key syntax
-- doesn't work well in MySQL.

CREATE TABLE emps (
	empno INT PRIMARY KEY,
	ename VARCHAR(20),
	deptno INT REFERENCES depts(deptno),
	mgr INT,
);

DESC emps;
```

```SQL
-- FK to composite PK.
CREATE TABLE marks(
	std INT,
	roll INT,
	subject CHAR(20),
	marks INT DEFAULT 0.0,
	FOREIGN KEY (std,roll) REFERENCES students(std,roll)
);

INSERT INTO marks(std,roll,subject) VALUES (1,1,'Hin');
```
























