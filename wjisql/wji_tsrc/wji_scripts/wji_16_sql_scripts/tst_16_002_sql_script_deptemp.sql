-- Sample department and employee tables to demonstrate execution of multiple statements
-- from SQL statement window of wjISQL.

-- Drop tables.
DROP TABLE emp;
DROP TABLE dept;

-- Create tables.
CREATE TABLE dept (dno INT NOT NULL PRIMARY KEY
    , dname VARCHAR(20));
CREATE TABLE emp(eno INT NOT NULL PRIMARY KEY
    , ename VARCHAR(20), dno INT REFERENCES dept(dno));

-- Insert data into the tables.
INSERT INTO dept(dno, dname) VALUES(1, 'Research');
INSERT INTO dept(dno, dname)  VALUES(2, 'Development');
INSERT INTO dept(dno, dname)  VALUES(3, 'Marketing');
INSERT INTO emp VALUES(1001, 'Brahma', 1);
INSERT INTO emp VALUES(1002, 'Vishnu', 1);
INSERT INTO emp VALUES(1003, 'Narayana', 2);
INSERT INTO emp VALUES(1004, 'Krishna', 2);
INSERT INTO emp VALUES(1005, 'Narada', 3);
INSERT INTO emp VALUES(1006, 'Hanuman', 3);

-- Select data from the tables
SELECT * FROM dept;
SELECT * from emp;