CREATE DATABASE cheerup;
\c cheerup;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  email VARCHAR(50) NOT NULL,
  password_digest VARCHAR (400) NOT NULL
);
-- id SERIAL4 PRIMARY KEY,						POINT B
-- post_id INTEGER	,							Point A	Has many Posts
-- comment_id INTEGER,						Point C	Has many Comments
-- INSERT INTO users (name, email, password) VALUES (1,1,1,'Keith','keith@ga.com','##');
-- password wouldnt work - must use pry and set password


CREATE TABLE posts (
  id SERIAL4 PRIMARY KEY,
  user_id INTEGER,
  title VARCHAR (30) NOT NULL,
  body TEXT NOT NULL
);

-- id SERIAL4 PRIMARY KEY,				POINT A
-- user_id INTEGER,						Point B	Belongs to a User
-- tag_id INTEGER, 						Point D	Has many Tags
-- comment_id INTEGER,					Point C	Has many Comments
INSERT INTO posts (user_id, title, body) VALUES (1,'BOY STORY','There was a story of a boy and he died the end');

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  post_id INTEGER,
  user_id INTEGER,
  body TEXT NOT NULL
);
-- id SERIAL4 PRIMARY KEY,				POINT C
-- post_id INTEGER,						Point A	Belongs to a Post
-- user_id INTEGER,						Point B	Belongs to a User
INSERT INTO comments (post_id, user_id, body) VALUES (1,1,'THIS IS AWESOME');

CREATE TABLE tags (
	id SERIAL4 PRIMARY KEY,
  post_id INTEGER,
	label VARCHAR (20) NOT NULL
 );
 -- id SERIAL4 PRIMARY KEY,					POINT D
 --  post_id INTEGER,								Point A	Belongs to a Post
 -- INSERT INTO tags (post_id, post_id, label) VALUES (1,1,'Inspiration');
 INSERT INTO tags (post_id, label) VALUES (1,'Motivational');
