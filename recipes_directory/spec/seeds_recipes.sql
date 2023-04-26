-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Stir Fry Noodles', '30', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Baked Potato', '60', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Carbonara', '30', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Cacio e pepe', '45', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Tiramisù', '60', '5');