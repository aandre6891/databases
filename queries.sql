SELECT id, title, release_year 
  FROM albums 
  WHERE title = 'Doolittle' AND release_year = 1989;

SELECT id, title, release_year 
  FROM albums 
  WHERE release_year >= 1970 AND release_year <= 1989;

--to update more things
UPDATE albums
SET release_year = '2000', title = 'whatever...'
WHERE id = 1;

--Dangerous!!!!!

DELETE FROM albums; # delete all albums

--to put conditions
DELETE FROM albums WHERE id = 1;

--to create new records
INSERT INTO table_name
(column1, column2, ...)
VALUES (list of values, ...); 

--example

INSERT INTO artists
( name, genre )
VALUES ( 'Bon Jovi', 'Rock' );

--to create new tables in the database

CREATE TABLE table_name (
  id SERIAL PRIMARY KEY,
  title text,
  release_year int
);

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name text,
	cohort text -- no comma for the last one
);

-- to alter the type of the column
ALTER TABLE recipes
ALTER COLUMN rating TYPE numeric;

-- to check the column type

SELECT pg_typeof(rating)
FROM recipes
LIMIT 1;

-- to delete one artist
--example
DELETE FROM table_name WHERE id = 1;

--to update on artist
-- example

UPDATE table_name SET name = "name", age = "35" WHERE id = 1;