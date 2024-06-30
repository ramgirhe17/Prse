# Getting Started - MySQL
* This PC --> Right Click - Properties --> Advanced System Settings --> Advanced --> Environment Variables.
* Select -- (User) Path --> Edit --> New --> add "C:\Program Files\MySQL\MySQL Server 8.0\bin" --> OK - OK - OK

## Open Command Prompt -- for MySQL root login.
* cmd> mysql -u root -p

```SQL
SHOW DATABASES;

CREATE USER edac@localhost IDENTIFIED BY 'edac';

CREATE DATABASE dacdb;

GRANT ALL PRIVILEGES ON dacdb.* TO edac@localhost;

FLUSH PRIVILEGES;

EXIT;
```

## Open Command Prompt -- for MySQL edac login.

* cmd> mysql -u edac -p
	* password: edac

```SQL
SHOW DATABASES;

EXIT;
```


