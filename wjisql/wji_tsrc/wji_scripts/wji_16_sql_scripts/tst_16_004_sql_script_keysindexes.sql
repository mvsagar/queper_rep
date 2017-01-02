-- Sample table to demonstrate wjISQL features on keys and indexes.

-- Drop tables.
DROP TABLE questions;

-- Create tables.
CREATE TABLE questions (book_id INT NOT NULL, part_num INT NOT NULL, ch_num INT NOT NULL
	, secn_num INT NOT NULL, qtn_num INT NOT NULL
	, qtn_text VARCHAR(300), qtn_marks INT, qtn_complexity INT
    , PRIMARY KEY (book_id, part_num, ch_num, secn_num, qtn_num) );

-- Duplicate index 
CREATE INDEX xqtncmplx ON questions(qtn_complexity, qtn_marks);

--- Insert 3 rows
INSERT INTO questions VALUES(1001, 1, 1, 1, 1, 'What is a Java interface?', 1, 1);
INSERT INTO questions VALUES(1001, 1, 1, 1, 2, 'Give an example for Java interface', 2, 2);
INSERT INTO questions VALUES(1001, 1, 1, 1, 3, 'Why does one need interfaces in Java', 5, 3);
