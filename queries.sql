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