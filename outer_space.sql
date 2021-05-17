-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE orbit_centers
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE galaxies
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  id_orbits_around INTEGER NOT NULL REFERENCES orbit_centers(id),
  id_galaxy INTEGER NOT NULL REFERENCES galaxies(id)
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  planet_id INTEGER NOT NULL REFERENCES planets(id)
);

-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');

INSERT INTO orbit_centers
  ( name )
VALUES
  ('The Sun'),
  ('Gliese 876'),
  ('Proxima Centauri');

INSERT INTO galaxies
  ( name )
VALUES
  ( 'Milky Way' );

INSERT INTO planets (
    name,
    orbital_period_in_years,
    id_orbits_around,
    id_galaxy
  )
VALUES
  (
    'Earth',
    1.00,
    1,
    1
  ),
  (
    'Mars',
    1.88,
    1,
    1
  ),
  (
    'Venus',
    0.62,
    1,
    1
  ),
  (
    'Neptune',
    164.8,
    1,
    1
  ),
  (
    'Proxima Centauri b',
    0.03,
    3,
    1
  ),
  (
    'Gliese 876 b',
    0.23,
    2,
    1
  );

INSERT INTO moons 
  ( name, planet_id ) 
VALUES 
  ( 'The Moon', 1 ),
  ( 'Phobos', 2 ),
  ( 'Deimos', 2 ),
  ( 'Naiad', 4 ),
  ( 'Thalassa', 4 ),
  ( 'Despina', 4 ),
  ( 'Galatea', 4 ),
  ( 'Larissa', 4 ),
  ( 'S/2004 N 1', 4 ),
  ( 'Proteus', 4 ),
  ( 'Triton', 4 ),
  ( 'Nereid', 4 ),
  ( 'Halimede', 4 ),
  ( 'Sao', 4 ),
  ( 'Laomedeia', 4 ),
  ( 'Psamathe', 4 ),
  ( 'Neso', 4 );

SELECT 
  p.name AS planet, 
  p.orbital_period_in_years, o.name AS orbits_around, 
  g.name AS galaxy,
  (
    SELECT STRING_AGG(m.name, ', ') AS moons
    FROM moons m
    WHERE p.id = m.planet_id
  )
FROM planets p
JOIN orbit_centers o on o.id = p.id_orbits_around
JOIN galaxies g on g.id = p.id_galaxy
ORDER BY p.id ASC;

-- CONCAT (
--   SELECT name FROM moons
-- );

-- SELECT STRING_AGG(m.name, ', ') AS moons
-- FROM moons m
-- join planets p ON p.id = m.planet_id
-- group by m.planet_id;