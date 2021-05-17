-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE doctors
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  speciality TEXT NOT NULL
);

CREATE TABLE patients
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE visits
(
  id SERIAL PRIMARY KEY,
  id_doctor INTEGER REFERENCES doctors(id) ON DELETE SET NULL,
  id_patient INTEGER REFERENCES patients(id) ON DELETE SET NULL
);

CREATE TABLE results
(
  id SERIAL PRIMARY KEY,
  id_visit INTEGER NOT NULL REFERENCES visits(id),
  diagnosis TEXT NOT NULL
);

INSERT INTO doctors
  (name, speciality)
VALUES
  ('Doctor Zhivago', 'Family Medicine'),
  ('Doctor Doolittle', 'Speech Therapy'),
  ('Doctor Martens', 'Podiatry'),
  ('Doctor Van Helsing', 'Heart Surgery'),
  ('Doctor Strange', 'Neurosurgeon'),
  ('Doctor Octopus', 'Hand surgeon'),
  ('Doctor Xavier', 'Psychiatrist'),
  ('Doctor Frankenstein', 'Orthopedic Surgeon');

INSERT INTO patients
  (name)
VALUES
  ('Amadeus'),
  ('Beethoven'),
  ('Chopin'),
  ('Debussy'),
  ('Rachmaninov');

INSERT INTO visits
  (id_doctor,id_patient)
VALUES
  (7, 1),
  (5, 1),
  (2,2),
  (4,3),
  (1,4),
  (6,5),
  (8,5);

INSERT INTO results
  (id_visit,diagnosis)
VALUES
  (1,'Insanity'),
  (3,'Deafness'),
  (4,'Broken Heart'),
  (4,'Poetic Genius'),
  (6,'Hand Gigantism'),
  (7,'Future Organ Donor')