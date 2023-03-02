-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('pasta', '20', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('pizza', '60', '5');
INSERT INTO recipes (name, average_cooking_time, rating) VALUES ('sandwich', '5', '3');