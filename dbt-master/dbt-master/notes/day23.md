# NoSQL

## Mongo Db

```JS
show databases;

show dbs;

use dacdb;

show collections;

db.contacts.insert({name: "Nilesh Ghule", email: "nilesh@sunbeaminfo.com", mobile: "9527331338"});

show collections;

show dbs;

db.contacts.insert({name: "Sandeep Kulange", email: "sandeep.kulange@sunbeaminfo.com"});

db.contacts.insertMany([
    {name: "Nitin Kudale", mobile: "9881208115", email: "nitin@sunbeaminfo.com", addr: "Pune"},
    {name: "Prashant Lad", mobile: "9881208114", addr: "Karad"},
    {name: "Sunbeam Infotech", fax: "020-24260308", website: "www.sunbeaminfo.com"}
]);

db.contacts.findOne();
// find any one record

db.contacts.find();

db.contacts.find().pretty();
```

```JS
db.dept.insert({_id:10,dname:"ACCOUNTING",loc:"NEW YORK"});
db.dept.insert({_id:20,dname:"RESEARCH",loc:"DALLAS"});
db.dept.insert({_id:30,dname:"SALES",loc:"CHICAGO"});
db.dept.insert({_id:40,dname:"OPERATIONS",loc:"BOSTON"});

db.emp.insert({_id:7369,ename:"SMITH",job:"CLERK",mgr:7902,sal:800.00,deptno:20});
db.emp.insert({_id:7499,ename:"ALLEN",job:"SALESMAN",mgr:7698,sal:1600.00,comm:300.00,deptno:30});
db.emp.insert({_id:7521,ename:"WARD",job:"SALESMAN",mgr:7698,sal:1250.00,comm:500.00,deptno:30});
db.emp.insert({_id:7566,ename:"JONES",job:"MANAGER",mgr:7839,sal:2975.00,deptno:20});
db.emp.insert({_id:7654,ename:"MARTIN",job:"SALESMAN",mgr:7698,sal:1250.00,comm:1400.00,deptno:30});
db.emp.insert({_id:7698,ename:"BLAKE",job:"MANAGER",mgr:7839,sal:2850.00,deptno:30});
db.emp.insert({_id:7782,ename:"CLARK",job:"MANAGER",mgr:7839,sal:2450.00,deptno:10});
db.emp.insert({_id:7788,ename:"SCOTT",job:"ANALYST",mgr:7566,sal:3000.00,deptno:20});
db.emp.insert({_id:7839,ename:"KING",job:"PRESIDENT",sal:5000.00,deptno:10});
db.emp.insert({_id:7844,ename:"TURNER",job:"SALESMAN",mgr:7698,sal:1500.00,comm:0.00,deptno:30});
db.emp.insert({_id:7876,ename:"ADAMS",job:"CLERK",mgr:7788,sal:1100.00,deptno:20});
db.emp.insert({_id:7900,ename:"JAMES",job:"CLERK",mgr:7698,sal:950.00,deptno:30});
db.emp.insert({_id:7902,ename:"FORD",job:"ANALYST",mgr:7566,sal:3000.00,deptno:20});
db.emp.insert({_id:7934,ename:"MILLER",job:"CLERK",mgr:7782,sal:1300.00,deptno:10});

show collections;
```

* Mongo Cursor
    * db.col.find() -- returns mongo cursor.
    * Cursor functions
        * pretty() -- well formatted output
        * skip(n) -- skip n records.
        * limit(n) -- display n records
        * sort() -- sort records in asc or desc order

```JS
db.emp.find().pretty();

db.emp.find().skip(10);

// SELECT * FROM emp LIMIT 4;
db.emp.find().limit(4);

// SELECT * FROM emp LIMIT 2, 4;
db.emp.find().skip(2).limit(4);

db.dept.find();

// SELECT * FROM dept ORDER BY dname ASC;
db.dept.find().sort({dname: 1});

// SELECT * FROM dept ORDER BY dname DESC;
db.dept.find().sort({dname: -1});

// top 3 emps (with highest sal)
// SELECT * FROM emp ORDER BY sal DESC LIMIT 3;
db.emp.find().sort({sal: -1}).limit(3);
```

* db.col.find(criteria, projection);

```JS
db.emp.find();

db.emp.find({}, {ename:1, sal:1});

db.emp.find({}, {ename:0, sal:0, job:0});

db.emp.find({}, {_id:0, ename:1, sal:1});
```

```JS
// SELECT * FROM emp WHERE deptno=20;
db.emp.find({deptno: 20});

// SELECT * FROM emp WHERE job='CLERK';
db.emp.find({job: "CLERK"});

// SELECT * FROM emp WHERE ename REGEXP '^S';
db.emp.find({ename: /^S/});

// find emp whose name contains S any where.
db.emp.find({ename: /S/});

// find emp whose name contains S in between
db.emp.find({ename: /^.+S.+$/});

db.emp.find({job: /^CLERK$/});

db.emp.find({job: /^clerk$/});

db.emp.find({job: /^clerk$/i });

// SELECT * FROM emp WHERE sal > 2500;
// $gt, $gte, $lt, $lte, $ne, $eq, $in, $nin
db.emp.find({
    sal: { $gt: 2500 }
});

// SELECT * FROM emp WHERE job IN ("PRESIDENT", "ANALYST", "SALESMAN");
db.emp.find({
    job: { $in: ["PRESIDENT", "ANALYST", "SALESMAN"] }
});
```

* db.col.remove(criteria);

```JS
db.dept.remove({dname: "OPERATIONS"});

db.dept.find();

db.dept.remove({});
// empty criteria -- all records

db.dept.deleteMany({});

show collections;

db.dept.drop();

show collections;
```

* db.col.update(criteria, changes);

```JS
// UPDATE emp SET sal=1000 WHERE ename='JAMES';

db.emp.find({ename: "JAMES"});

db.emp.update({ename: "JAMES"}, { 
    $set: { sal: 1000.0 } 
});

db.emp.find({ename: "JAMES"});
```


```JS
// SELECT * FROM emp WHERE job='CLERK' OR deptno=10;
db.emp.find({
    $or: [
        {job: "CLERK"},
        {deptno: 10}
    ]
});

// SELECT * FROM emp WHERE job='CLERK' AND deptno=10;
db.emp.find({
    $and: [
        {job: "CLERK"},
        {deptno: 10}
    ]
});

```


* Import from JS into Mongo

cmd> mongo dbname /path/to/mongo01.js

* Aggregate operations

```JS
db.emp.aggregate([
    { $group: ... },
    { $sort: ... },
    { $lookup: ... }
]);
```


















