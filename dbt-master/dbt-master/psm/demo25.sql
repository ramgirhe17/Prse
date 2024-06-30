-- when a new tx is recorded in transactions table, automatically account balance should be updated.
-- table1: accounts [id, type, balance]
-- table2: transactions [id, acc_id, amount, type, txtime]

DROP TRIGGER IF EXISTS trig_acc_transaction;

DELIMITER $$

CREATE TRIGGER trig_acc_transaction
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE v_accid INT DEFAULT NEW.acc_id;
    DECLARE v_amount DECIMAL(9,2) DEFAULT NEW.amount;
    DECLARE v_type CHAR(20) DEFAULT NEW.type;

    IF v_type = 'Deposit' THEN
        UPDATE accounts SET balance = balance + v_amount WHERE id = v_accid;
    ELSE
        UPDATE accounts SET balance = balance - v_amount WHERE id = v_accid;
    END IF;
END;
$$

DELIMITER ;

-- SOURCE D:/pgdiploma/edac-dbt/today/demo25.sql
-- SELECT * FROM accounts;
-- SELECT * FROM transactions;
-- INSERT INTO transactions(acc_id,amount,type) VALUES(1, 10000, 'Deposit');
--  accounts table --> acc id 1 -- balance = balance + 10000.
-- INSERT INTO transactions(acc_id,amount,type) VALUES(1, 2000, 'Withdraw');
--  accounts table --> acc id 1 -- balance = balance - 2000.

-- INSERT INTO transactions(acc_id,amount,type) VALUES(2, 5000, 'Deposit');
--  accounts table --> acc id 2 -- balance = balance + 5000.
-- INSERT INTO transactions(acc_id,amount,type) VALUES(2, 2000, 'Withdraw');
--  accounts table --> acc id 2 -- balance = balance - 2000.

