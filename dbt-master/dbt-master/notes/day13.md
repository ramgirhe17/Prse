# Joins

## Cross Join

## Inner Joins

## Left Outer Join

```SQL
-- intersection + extra emps
SELECT e.ename, d.dname FROM emps e
LEFT OUTER JOIN depts d ON e.deptno = d.deptno;

-- intersection + extra depts
SELECT e.ename, d.dname FROM depts d
LEFT OUTER JOIN emps e ON e.deptno = d.deptno;
```

## Right Outer Join

```SQL
-- intersection + extra depts
SELECT e.ename, d.dname FROM emps e
RIGHT OUTER JOIN depts d ON e.deptno = d.deptno;

-- intersection + extra emps
SELECT e.ename, d.dname FROM depts d
RIGHT OUTER JOIN emps e ON e.deptno = d.deptno;
```

## Full Outer Join
* Not supported in MySQL RDBMS.
* Full Outer Join is supported in Oracle, MS-SQL, ...

```SQL
-- intersection + extra emps + extra depts
SELECT e.ename, d.dname FROM emps e
FULL OUTER JOIN depts d ON e.deptno = d.deptno;
-- error in MySQL
```

## Set Operators

```SQL
-- simulation of full join
-- intersection (only once) + extra emps + extra depts
(SELECT e.ename, d.dname FROM emps e
LEFT OUTER JOIN depts d ON e.deptno = d.deptno)
UNION
(SELECT e.ename, d.dname FROM emps e
RIGHT OUTER JOIN depts d ON e.deptno = d.deptno);

-- intersection (twice) + extra emps + extra depts
-- output of second query is appended to output of first query
(SELECT e.ename, d.dname FROM emps e
LEFT OUTER JOIN depts d ON e.deptno = d.deptno)
UNION ALL
(SELECT e.ename, d.dname FROM emps e
RIGHT OUTER JOIN depts d ON e.deptno = d.deptno);
```

## Self Join

```SQL
-- self join -- inner join with same table -- intersection
SELECT e.ename, m.ename AS mname FROM emps e
INNER JOIN emps m ON e.mgr = m.empno;

-- self join -- outer join -- intersection + extra from left table (emps e)
SELECT e.ename, m.ename AS mname FROM emps e
LEFT OUTER JOIN emps m ON e.mgr = m.empno;
```

## Joins with other clauses

```SQL
SELECT * FROM emps;

SELECT * FROM depts;

SELECT * FROM addr;

-- print ename, dname.
SELECT e.ename, d.dname FROM emps e
INNER JOIN depts d ON e.deptno = d.deptno;

-- print ename, tal of emp.
SELECT e.ename, a.tal FROM emps e
INNER JOIN addr a ON e.empno = a.empno;

-- print ename, dname and tal of emp.
SELECT e.ename, d.dname, a.tal FROM emps e
INNER JOIN depts d ON e.deptno = d.deptno
INNER JOIN addr a ON e.empno = a.empno;

-- print ename, dname and tal of emp.
SELECT e.ename, d.dname, a.tal FROM emps e
LEFT OUTER JOIN depts d ON e.deptno = d.deptno
INNER JOIN addr a ON e.empno = a.empno;
```

```SQL
SELECT * FROM emps;

SELECT * FROM depts;

SELECT deptno, COUNT(empno) FROM emps
GROUP BY deptno;

SELECT e.ename, d.dname FROM emps e
LEFT OUTER JOIN depts d ON e.deptno = d.deptno;

-- print dname and number of emps in dept.
SELECT d.dname, COUNT(e.empno) FROM emps e
LEFT OUTER JOIN depts d ON e.deptno = d.deptno
GROUP BY d.dname;
```

```SQL
-- print ename, dname for emps with empno 2 and 3.
SELECT e.ename, d.dname FROM emps e
INNER JOIN depts d ON e.deptno = d.deptno
WHERE e.empno IN (2,3);
```




























