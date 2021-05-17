DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

CREATE TABLE teams
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE players
(
  id SERIAL PRIMARY KEY,
  id_team INTEGER REFERENCES teams(id) ON DELETE SET NULL,
  name TEXT NOT NULL
);
CREATE TABLE referees
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE matches
(
  id SERIAL PRIMARY KEY,
  id_team_home INTEGER NOT NULL REFERENCES teams(id),
  id_team_away INTEGER NOT NULL REFERENCES teams(id),
  id_referee INTEGER NOT NULL REFERENCES referees(id),
  match_date DATE NOT NULL
);

CREATE TABLE goals
(
  id SERIAL PRIMARY KEY,
  id_player INTEGER NOT NULL REFERENCES players(id),
  id_match INTEGER NOT NULL REFERENCES matches(id)
);

CREATE TABLE league_table
(
  id SERIAL PRIMARY KEY,
  id_team INTEGER NOT NULL REFERENCES teams(id),
  wins INTEGER DEFAULT 0,
  losses INTEGER DEFAULT 0,
  ties INTEGER DEFAULT 0
);

INSERT INTO teams
  (name)
VALUES
  ('Manchester City'),
  ('Manchester United'),
  ('Leicester City'),
  ('Chelsea');

INSERT INTO players
  (name, id_team)
VALUES
  ('Fernandinho', 1),
  ('Harry Maguire', 2),
  ('Wes Morgan', 3),
  ('Cesar Azpilicueta', 4);

INSERT INTO referees
  (name)
VALUES
  ('Mike Dean'),
  ('Martin Atkinson'),
  ('Michael Oliver'),
  ('Jonathan Moss'),
  ('Andre Marriner');

INSERT INTO matches
  (id_team_home, id_team_away, id_referee, match_date)
VALUES (
    1, -- Manchester City
    2, -- Manchester United
    3,
    '2021-05-01'
  ),
  (
    3, -- Leicester City
    4, -- Chelsea
    2,
    '2021-05-01'
  ),
  (
    1, -- Manchester City
    3, -- Leicester City
    5,
    '2021-05-05'
  ),
  (
    2, -- Manchester United
    4, -- Chelsea
    1,
    '2021-05-04'
  );

INSERT INTO goals
  (id_player, id_match)
VALUES
  ('1', 1),
  ('1', 1),
  ('2', 1),
  ('3', 2),
  ('4', 2),
  ('1', 3),
  ('1', 3),
  ('1', 3),
  ('3', 3),
  ('1', 3),
  ('2', 4),
  ('4', 4),
  ('4', 4),
  ('2', 4);

-- For returing the start and end of the season
-- SELECT MIN(DATE) season_start, MAX(DATE) season_end FROM matches;
INSERT INTO league_table
  (id_team, wins, losses, ties)
VALUES
  (1, 2, 0, 0),
  (2, 0, 1, 1),
  (3, 1, 1, 0),
  (4, 0, 1, 1)
