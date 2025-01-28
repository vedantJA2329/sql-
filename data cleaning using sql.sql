CREATE DATABASE punjabi;
DROP DATABASE punjabi;
CREATE DATABASE IF NOT EXISTS vedant;
CREATE DATABASE IF NOT EXISTS punjabi;
USE vedant;
CREATE TABLE paradise(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT NOT NULL
    );
DROP DATABASE IF EXISTS lol;
SHOW TABLES;
INSERT INTO paradise
(id,name,age)
VALUES
(101,"karan",21),
(102,"vedant",22),
(103,"ram",23);
SELECT * FROM paradise;
INSERT INTO paradise
(id,name,age)
VALUES
(104,"lol",24);
SELECT * FROM paradise;
INSERT INTO paradise VALUES (105,"krish",25);
CREATE TABLE temp(
mainid int,
FOREIGN KEY (mainid) references paradise(id));
SELECT * FROM temp;
CREATE TABLE hump(
salary INT DEFAULT 2500);
SELECT * FROM hump;