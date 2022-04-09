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

/* Write queries to answer the following:
- Who was the last animal seen by William Tatcher?
- How many different animals did Stephanie Mendez see?
- List all vets and their specialties, including vets with no specialties.
- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
- What animal has the most visits to vets?
- Who was Maisy Smith's first visit?
- Details for most recent visit: animal information, vet information, and date of visit.
- How many visits were with a vet that did not specialize in that animal's species?
- What specialty should Maisy Smith consider getting? Look for the species she gets the most. */

SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(animals.name) FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name FROM specializations
FULL OUTER JOIN vets ON vets.id = specializations.vet_id
FULL OUTER JOIN species ON species.id = specializations.species_id;

SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-03' AND '2020-08-30';

SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(visits.visit_date) DESC
LIMIT 1;

SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name, visits.visit_date
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT animals.name, vets.name, visits.visit_date FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC
LIMIT 1;

CREATE VIEW Specialty as
SELECT vets.name, species.id
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.species_id;

SELECT COUNT (visits.visit_date) FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
LEFT JOIN specializations ON vets.id = specializations.vet_id
WHERE (animals.species_id != specializations.species_id OR specializations.species_id IS NULL)
AND 2 != (
  SELECT COUNT(Specialty.name)
  FROM Specialty
  WHERE Specialty.name = vets.name
);

SELECT species.name, COUNT(species.name) as visits
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visits DESC
LIMIT 1;
