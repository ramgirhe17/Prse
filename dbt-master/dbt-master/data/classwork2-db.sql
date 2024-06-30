DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS food;
DROP TABLE IF EXISTS selection;
DROP TABLE IF EXISTS repetition;

CREATE TABLE accounts(id INT PRIMARY KEY AUTO_INCREMENT, type CHAR(20), balance DECIMAL(9,2));
INSERT INTO accounts(type, balance) VALUES ('Saving', 0.0);
INSERT INTO accounts(type, balance) VALUES ('Saving', 0.0);
INSERT INTO accounts(type, balance) VALUES ('Saving', 0.0);
INSERT INTO accounts(type, balance) VALUES ('Saving', 0.0);

CREATE TABLE transactions(id INT PRIMARY KEY AUTO_INCREMENT, acc_id INT, amount DECIMAL(9,2), type CHAR(20), txtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE food(val CHAR(50));
INSERT INTO food VALUES ('this'), ('biscuit'), ('isn''t'), ('good'), ('but'), ('that'), ('cake'), ('is'), ('really tasty');

CREATE TABLE selection(val CHAR(50));
INSERT INTO selection VALUES ('big'), ('beg'), ('bag'), ('bug'), ('bog'), ('bg'), ('b*g');

CREATE TABLE repetition(val CHAR(50));
INSERT INTO repetition VALUES ('bg'), ('big'), ('biig'), ('biiig'), ('biiiig'), ('biiiiig'), ('biiiiiig'), ('biiiiiiig'), ('biiiiiiiig');
