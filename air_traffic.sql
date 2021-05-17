-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE airport_countries
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE airport_cities
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  id_country INTEGER NOT NULL REFERENCES airport_countries(id)
);

CREATE TABLE airlines
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat TEXT NOT NULL,
  departure_time TIMESTAMP NOT NULL,
  arrival_time TIMESTAMP NOT NULL,
  airline_id INTEGER NOT NULL REFERENCES airlines(id),
  from_city_id INTEGER NOT NULL REFERENCES airport_cities(id),
  to_city_id INTEGER NOT NULL REFERENCES airport_cities(id)
);

INSERT INTO airport_countries
  (name)
VALUES
  ('Chile'),
  ('China'),
  ('Japan'),
  ('Mexico'),
  ('Morocco'),
  ('United Kingdom'),
  ('United States'),
  ('France'),
  ('UAE'),
  ('Brazil');

INSERT INTO airport_cities
  (name, id_country)
VALUES
  ('Santiago', 1), 
  ('Beijing', 2),
  ('Tokyo', 3),
  ('Mexico City', 4),
  ('Casablanca', 5), -- 5
  ('London',6),
  ('Cedar Rapids', 7),
  ('Charlotte', 7),
  ('Chicago', 7),
  ('Las Vegas', 7), -- 10
  ('Los Angeles', 7),
  ('New Orleans', 7),
  ('New York', 7),
  ('Seattle', 7),
  ('Washington DC', 7), -- 15
  ('Paris', 8),
  ('Dubai', 9),
  ('Sao Paolo', 10);

INSERT INTO airlines
  ( name )
VALUES
  ( 'Air China' ),
  ( 'American Airlines' ),
  ( 'Avianca Brasil' ),
  ( 'British Airways' ),
  ( 'Delta' ),
  ( 'TUI Fly Belgium' ),
  ( 'United' );

INSERT INTO tickets
  (
    first_name, 
    last_name, 
    seat, 
    departure_time, 
    arrival_time, 
    airline_id,
    from_city_id,
    to_city_id
  )
VALUES
  (
    'Jennifer', 
    'Finch', 
    '33B', 
    '2018-04-08 09:00:00', 
    '2018-04-08 12:00:00', 
    7, 15, 14
  ),
  (
    'Thadeus', 
    'Gathercoal', 
    '8A', 
    '2018-12-19 12:45:00', 
    '2018-12-19 16:15:00', 
    4, 3, 6
  ),
  (
    'Sonja', 
    'Pauley', 
    '12F', 
    '2018-01-02 07:00:00', 
    '2018-01-02 08:03:00', 
    5, 11, 10
  ),
  (
    'Jennifer', 
    'Finch', 
    '20A', 
    '2018-04-15 16:50:00', 
    '2018-04-15 21:00:00', 
    5, 14, 4
  ),
  (
    'Waneta', 
    'Skeleton', 
    '23D', 
    '2018-08-01 18:30:00', 
    '2018-08-01 21:50:00', 
    6, 16, 5
  ),
  (
    'Thadeus', 
    'Gathercoal', 
    '18C', 
    '2018-10-31 01:15:00', 
    '2018-10-31 12:55:00', 
    1, 17, 2
  ),
  (
    'Berkie', 
    'Wycliff', 
    '9E', 
    '2019-02-06 06:00:00', 
    '2019-02-06 07:47:00', 
    7, 13, 8 
  ),
  (
    'Alvin', 
    'Leathes', 
    '1A', 
    '2018-12-22 14:42:00', 
    '2018-12-22 15:56:00', 
    2, 7, 9
  ),
  (
    'Berkie', 
    'Wycliff', 
    '32B', 
    '2019-02-06 16:28:00', 
    '2019-02-06 19:18:00', 
    2, 8, 12
  ),
  (
    'Cory', 
    'Squibbes', 
    '10D', 
    '2019-01-20 19:30:00', 
    '2019-01-20 22:45:00', 
    3, 18, 1
  );

SELECT 
  t.first_name, 
  t.last_name,
  t.seat, 
  t.departure_time, 
  t.arrival_time, 
  airlines.name AS airlines,
  -- t.from_city_id,
  -- t.to_city_id,
  from_city.name AS from_city,
  from_country.name AS from_country,
  to_city.name AS to_city,
  to_country.name AS to_country
FROM 
  tickets t
JOIN airlines ON airlines.id = t.airline_id

JOIN airport_cities AS from_city ON from_city.id = t.from_city_id
JOIN airport_countries AS from_country ON from_country.id = from_city.id_country

JOIN airport_cities AS to_city ON to_city.id = t.to_city_id
JOIN airport_countries AS to_country ON to_country.id = to_city.id_country;
