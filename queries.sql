/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= 10.4  AND weight_kg <= 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE from animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SP;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;

/* Write queries (using JOIN) to answer the following questions:
- What animals belong to Melody Pond?
- List of all animals that are pokemon (their type is Pokemon).
- List all owners and their animals, remember to include those that don't own any animal.
- How many animals are there per species?
- List all Digimon owned by Jennifer Orwell.
- List all animals owned by Dean Winchester that haven't tried to escape.
- Who owns the most animals? */

SELECT name FROM animals ani
JOIN owners own ON ani.owner_id = own.id
WHERE own.full_name = 'Melody Pond';

SELECT ani.name FROM animals ani
JOIN species spec ON ani.species_id = spec.id
WHERE spec.name = 'Pokemon';

SELECT full_name, name
FROM animals ani
FULL OUTER JOIN owners own on own.id = ani.owner_id;

SELECT spec.name, COUNT(*) FROM animals ani
JOIN species spec ON ani.species_id = spec.id
GROUP BY spec.name;

SELECT ani.name
FROM animals ani
JOIN owners own ON ani.owner_id = own.id
JOIN species spec ON ani.species_id = spec.id
WHERE own.full_name = 'Jennifer Orwell'
AND spec.name = 'Digimon';

SELECT ani.name
FROM animals ani
JOIN owners own ON ani.owner_id = own.id
WHERE ani.escape_attempts = 0
AND own.full_name = 'Dean Winchester';

SELECT COUNT(*) as count, full_name
FROM animals as ani
JOIN owners own ON ani.owner_id = own.id
GROUP BY full_name
ORDER BY count desc;
