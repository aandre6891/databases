TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Carbonara', '30', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Cacio e pepe', '45', '4');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Tiramisù', '60', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Risotto ai funghi', '120', '3');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('Lasagne', '110', '3');