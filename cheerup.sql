CREATE DATABASE cheerup;
\c cheerup;

SELECT * FROM posts;

INSERT INTO posts (name, body) VALUES ('keitheous', 'this is my first post');
INSERT INTO posts (name, body) VALUES ('keith', 'this is my second post');

ALTER TABLE posts ADD COLUMN
  title VARCHAR (30);

  CREATE TABLE posts (
    id SERIAL4 PRIMARY KEY,
    user_id VARCHAR(50),
    body TEXT,
    tag_id INTEGER,
    comment_id INTEGER,
  );
