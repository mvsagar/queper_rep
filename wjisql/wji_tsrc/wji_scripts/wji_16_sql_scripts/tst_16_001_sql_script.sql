-- The following SQL statements are used to test the following features:
--     1. Execution of SQL statements in a script file.
--     2. Execution of one or more contiguous statements by selecting 
--        them in the text box of field SQL Statement(s).
-- 
DROP TABLE ts1;
CREATE TABLE ts1(c1 INT NOT NULL PRIMARY KEY, c2 VARCHAR(100));
INSERT INTO ts1 VALUES(1, 'one');
INSERT INTO ts1 VALUES(2, 'two');
INSERT INTO ts1 VALUES(3, 'three');
SELECT * FROM ts1;
SELECT * FROM ts1 WHERE c1 = 2;

