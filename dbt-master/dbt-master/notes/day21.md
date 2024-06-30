# MySQL PSM

## Routines

### Stored Procedure
* Doesn't return anything (like void).
* Params: IN, OUT or INOUT
* CALL sp_name(arg1, arg2, ...);

### Functions
* Return result (like void).
* Params: IN
* SELECT fn_name(arg1, arg2, ...) FROM tablename;

## Triggers
* Executed automatically on some events.
    * BEFORE INSERT, AFTER INSERT
    * BEFORE UPDATE, AFTER UPDATE
    * BEFORE DELETE, AFTER DELETE
* No parameters and no return value.

```SQL
USE information_schema;

SELECT * FROM TRIGGERS;

SHOW TRIGGERS FROM dacdb;
```

# MySQL Regex

## LIKE operator
* Wildcard characters
    * %: Any number of any characters
    * _: Any single character

```SQL
-- exact search
SELECT * FROM emp WHERE ename = 'KING';

-- similar/like search
SELECT * FROM emp WHERE ename LIKE '%A%A%';
```

## Regex operators
* REGEXP, RLIKE, NOT REGEXP, NOT RLIKE
    * syntax: SELECT ... WHERE expr REGEXP pat;
    * syntax: SELECT ... WHERE expr RLIKE pat;
* Pattern in regex is made using wild-card characters.
    * $: Ending with.
    * ^: Starting from.
    * .: Any single character.
    * []: selection/scan-set (any one char)
    * [^]: invert scan-set (any one char)
    * (w1|w2|w3): select a word
    * *: 0 or more occurrences of prev char
    * +: 1 or more occurrences of prev char
    * ?: 0 or 1 occurrence of prev char
    * {n}: n occurrences of prev char
    
```SQL
SELECT * FROM emp WHERE ename REGEXP 'ING';
SELECT * FROM emp WHERE ename REGEXP 'AM';

SELECT * FROM food;
SELECT * FROM food WHERE val REGEXP 'is';
SELECT * FROM food WHERE val REGEXP '^is';
SELECT * FROM food WHERE val REGEXP 'is$';
SELECT * FROM food WHERE val REGEXP '^is$';
SELECT * FROM food WHERE val NOT REGEXP '^is$';

SELECT * FROM selection;
SELECT * FROM selection WHERE val REGEXP 'b.g';
SELECT * FROM selection WHERE val REGEXP 'b[a-z]g';
SELECT * FROM selection WHERE val REGEXP 'b[aiu]g';
SELECT * FROM selection WHERE val REGEXP 'b[^a-z]g';
SELECT * FROM selection WHERE val REGEXP '(bag|big)';

SELECT * FROM emp WHERE ename REGEXP '(KING|ADAMS|JAMES)';

SELECT * FROM selection WHERE val REGEXP 'b*g';

SELECT * FROM selection WHERE val REGEXP 'b\\*g';
-- to nullify special meaning of wildcard char use \\ before that.

SELECT * FROM repetition;
SELECT * FROM repetition WHERE val REGEXP 'bi*g';
-- 0 or more occurrences of "i"
SELECT * FROM repetition WHERE val REGEXP 'bi?g';
-- 0 or 1 occurrence of "i"
SELECT * FROM repetition WHERE val REGEXP 'bi+g';
-- 1 or more occurrences of "i"
SELECT * FROM repetition WHERE val REGEXP 'bi{5}g';
-- 5 more occurrences of "i"
SELECT * FROM repetition WHERE val REGEXP 'bi{4,}g';
-- 4 or more occurrences of "i"
SELECT * FROM repetition WHERE val REGEXP 'bi{0,4}g';
-- 4 or less occurrences of "i"
```

```SQL
CREATE TABLE contacts (id INT PRIMARY KEY AUTO_INCREMENT, name CHAR(50), email CHAR(30), mobile CHAR(16));
INSERT INTO contacts(name,email,mobile) VALUES ('A', 'nilesh@sunbeam.com', '9527331338');
INSERT INTO contacts(name,email,mobile) VALUES ('B', 'nilesh@sunbeam', '919527331338');
INSERT INTO contacts(name,email,mobile) VALUES ('C', 'nileshsunbeam.com', '09527331338');
INSERT INTO contacts(name,email,mobile) VALUES ('D', 'nilesh@sun.com', '982201234');
INSERT INTO contacts(name,email,mobile) VALUES ('E', 'nilesh@sunbeaminfo.com', '98220123456');

-- find all valid mobile numbers
SELECT mobile FROM contacts WHERE mobile REGEXP '[0-9]';
SELECT mobile FROM contacts WHERE mobile REGEXP '[0-9]{10}';
SELECT mobile FROM contacts WHERE mobile REGEXP '^[0-9]{10}$';
SELECT mobile FROM contacts WHERE mobile REGEXP '^(0|91)[0-9]{10}$';
SELECT mobile FROM contacts WHERE mobile REGEXP '^(0|91)?[0-9]{10}$';
SELECT mobile FROM contacts WHERE mobile REGEXP '^(0|\\+?91)?[0-9]{10}$';

-- find all valid email addresses
SELECT email FROM contacts WHERE email REGEXP '[a-z0-9]+@[a-z0-9]+\\.(com|net|org)';

-- find all emp names starting with vowels.
SELECT ename FROM emp WHERE ename REGEXP '^[AEIOU].*';
```

## Regex Functions
### REGEXP_LIKE(expr, pat)
    * Returns 1 or 0.

```SQL
SELECT ename, REGEXP_LIKE(ename, '^[AEIOU].*') FROM emp;
```

### REGEXP_INSTR(expr, pat, occurrence)
    * Returns position.

```SQL
SELECT ename, REGEXP_INSTR(ename, '[AEIOU]') FROM emp;
-- return position of first occurrence

SELECT ename, REGEXP_INSTR(ename, '[AEIOU]', 2) FROM emp;
-- return position of first occurrence from given position
```

### REGEXP_SUBSTR(expr, pat)

```SQL
SELECT ename, REGEXP_SUBSTR(ename, '[AEIOU]') FROM emp;
-- return first matching substring

SELECT ename, REGEXP_SUBSTR(ename, '[AEIOU]', 2) FROM emp;
-- return matching substring from given position
```

### REGEXP_REPLACE(expr, pat, repl)

# Normalization

# Codd's rules

# MySQL Architecture

## MyISAM vs InnoDB
