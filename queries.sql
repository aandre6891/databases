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

-- JOIN query

SELECT [columns to select]
  FROM [table name]
  JOIN [other table name]
  ON [join condition]

-- example

SELECT albums.id,
      albums.title,
      artists.id,
      artists.name
  FROM albums
    JOIN artists
    ON artists.id = albums.artist_id;

-- we can add AS to rename the column in order to not have to id columns
    SELECT albums.id,
       albums.title,
       artists.id AS artist_id,
       artists.name
  FROM albums
    JOIN artists
    ON artists.id = albums.artist_id;
    ---------------------------------------

    -- example of creating two tables with a many to many relationship (you need to create a third table)

    -- EXAMPLE
-- file: posts_tags.sql

-- Replace the table name, columm names and types.

-- Create the first table.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Create the second table.
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name text
);

-- Create the join table.
CREATE TABLE posts_tags (
  post_id int,
  tag_id int,
  constraint fk_post foreign key(post_id) references posts(id) on delete cascade,
  constraint fk_tag foreign key(tag_id) references tags(id) on delete cascade,
  PRIMARY KEY (post_id, tag_id)
);

---