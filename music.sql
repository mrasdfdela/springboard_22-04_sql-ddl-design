-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists
( 
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE producers
( 
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE albums
( 
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  release_date DATE NOT NULL
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  album_id INTEGER NOT NULL REFERENCES albums(id)
);

CREATE TABLE song_artists
(
  id SERIAL PRIMARY KEY,
  artist_id INTEGER NOT NULL REFERENCES artists(id),
  song_id INTEGER NOT NULL REFERENCES songs(id)
);

CREATE TABLE song_producers
(
  id SERIAL PRIMARY KEY,
  producer_id INTEGER NOT NULL REFERENCES producers(id),
  song_id INTEGER NOT NULL REFERENCES songs(id)
);

INSERT INTO artists
  (name)
VALUES
  ('Alicia Keys'),
  ('Avril Lavigne'),
  ('Boyz II Men'),
  ('Destiny''s Child'),
  ('Bradley Cooper'), -- 5
  ('Christina Aguilera'),
  ('Hanson'),
  ('Jay Z'),
  ('Juicy J'),
  ('Katy Perry'), -- 10
  ('Lady Gaga'),
  ('Mariah Cary'),
  ('Maroon 5'),
  ('Nickelback'),
  ('Queen'); --15

INSERT INTO producers
  (name)
VALUES
  ('Dust Brothers'),
  ('Stephen Lironi'),
  ('Roy Thomas Baker'),
  ('Walter Afanasieff'),
  ('Benjamin Rice'), -- 5
  ('Rick Parashar'),
  ('Al Shux'),
  ('Max Martin'),
  ('Cirkut'),
  ('Shellback'), --10
  ('Benny Blanco'),
  ('The Matrix'),
  ('Darkchild');


INSERT INTO albums
  (title, release_date)
VALUES
  ('Middle of Nowhere','04-15-1997'),
  ('A Night at the Opera','10-31-1975'),
  ('Daydream','11-14-1995'),
  ('A Star Is Born','09-27-2018'),
  ('Silver Side Up','08-21-2001'),
  ('The Blueprint 3','10-20-2009'),
  ('Prism','12-17-2013'),
  ('Hands All Over','06-21-2011'),
  ('Let Go','05-14-2002'),
  ('The Writing''s on the Wall','11-07-1999');


INSERT INTO songs
  (title, duration_in_seconds, album_id)
VALUES
  ('MMMBop', 238, 1),
  ('Bohemian Rhapsody', 355, 2),
  ('One Sweet Day', 282, 3),
  ('Shallow', 216, 4),
  ('How You Remind Me', 223, 5),
  ('New York State of Mind', 276, 6),
  ('Dark Horse', 215, 7),
  ('Moves Like Jagger', 201, 8),
  ('Complicated', 244, 9),
  ('Say My Name', 240, 10);


INSERT INTO song_artists
  (artist_id, song_id)
VALUES
  (7,1),
  (15,2),
  (12,3),
  (3,3),
  (11,4),
  (5,4),
  (14,5),
  (8,6),
  (1,6),
  (10,7),
  (9,7),
  (13,8),
  (6,8),
  (2,9),
  (4,10);

INSERT INTO song_producers
  (producer_id, song_id)
VALUES
  (1,1),
  (2,1),
  (3,2),
  (4,3),
  (5,4),
  (6,5),
  (7,6),
  (8,7),
  (9,7),
  (10,8),
  (11,8),
  (12,9),
  (13,10);

select 
  s.title,
  s.duration_in_seconds,
  a.release_date,
  (
    SELECT STRING_AGG(artists.name, ', ') AS artists
    FROM artists
    JOIN song_artists sa ON sa.artist_id = artists.id
    where sa.song_id = s.id
  ),
  a.title,
  (
    SELECT STRING_AGG(producers.name, ', ') AS producers
    FROM producers
    JOIN song_producers sp ON sp.producer_id = producers.id
    where sp.song_id = s.id
  )
from songs s
  join albums a on a.id = s.album_id