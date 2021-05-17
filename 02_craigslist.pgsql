DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE regions
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE users
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  preferred_region_id INTEGER REFERENCES regions(id) ON DELETE SET NULL
);

CREATE TABLE posts
(
  id SERIAL PRIMARY KEY,
  title TEXT DEFAULT 'untitled',
  post TEXT NOT NULL,
  id_user INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  location TEXT,
  id_region INTEGER REFERENCES regions(id) ON DELETE SET NULL
);

INSERT INTO regions
  (name)
VALUES
  ('Central Europe'),
  ('Eastern Europe'),
  ('Western Europe');

INSERT INTO users
  (name, preferred_region_id)
VALUES
  ('Beethoven', 1),
  ('Chopin', 2),
  ('Debussy', 3),
  ('Mozart', 1),
  ('Rachmaninov', 2);

INSERT INTO posts
  (title,post,id_user,location,id_region)
VALUES
  (
    'Everything must go!',
    'Moving to France; selling everything immediately!',
    '2',
    'Warsaw',
    '2'
  ),
  (
    'New to town!',
    'Looking for a shared apartment. I''m clean and drama-free. Call today!',
    '2',
    'Paris',
    '3'
  );