TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (name, email_address) VALUES ('andy6891', 'andy6891@gmail.com');
INSERT INTO users (name, email_address) VALUES ('john325', 'john325@hotmail.com');
INSERT INTO users (name, email_address) VALUES ('lisa678', 'lisa@hotmail.com');
INSERT INTO users (name, email_address) VALUES ('matt777', 'matt777@hotmail.com');

INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 1', 'content 1', '45', '1');
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 2', 'content 2', '54', '2');
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 3', 'content 3', '81', '3');
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('Title 4', 'content 4', '32', '4');