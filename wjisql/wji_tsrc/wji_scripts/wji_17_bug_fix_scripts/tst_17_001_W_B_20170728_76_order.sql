-- The following SQL statements are used to test the following features:
--     1. Execution of SQL statements in a script file.
--     2. Execution of one or more contiguous statements by selecting 
--        them in the text box of field SQL Statement(s).
-- 
DROP TABLE IF EXISTS tord1;
CREATE TABLE tord1(c1 INT NOT NULL PRIMARY KEY, c2 VARCHAR(20));
INSERT INTO tord1 VALUES(1, 'one');
INSERT INTO tord1 VALUES(2, 'two');
INSERT INTO tord1 VALUES(3, 'three');
INSERT INTO tord1 VALUES(4, 'four');
INSERT INTO tord1 VALUES(5, 'five');
INSERT INTO tord1 VALUES(6, 'six');
INSERT INTO tord1 VALUES(7, 'seven');
INSERT INTO tord1 VALUES(8, 'eight');
INSERT INTO tord1 VALUES(9, 'nine');
INSERT INTO tord1 VALUES(10, 'ten');
INSERT INTO tord1 VALUES(11, 'eleven');
INSERT INTO tord1 VALUES(12, 'twelve');
SELECT * FROM tord1;

