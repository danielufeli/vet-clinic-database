/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, 'true', 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, 'true', 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, 'false', 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, 'true', 11);


/* Add more data to animals */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, 'false', 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, 'true', 5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, 'false', 12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, 'true', 45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, 'true', 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, 'true', 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, 'true', 22);

/* Insert the following data into the owners table */

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* Insert the following data into the species table */

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

/* Modify your inserted animals so it includes the species_id value */

UPDATE animals
SET species_id = 1;

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

/* Modify your inserted animals to include owner information (owner_id) */

UPDATE animals SET owner_id = 1
WHERE name LIKE 'Agumon';

UPDATE animals SET owner_id = 2
WHERE name LIKE 'Gabumon' OR name LIKE 'Pikachu';

UPDATE animals SET owner_id = 3
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals SET owner_id = 4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals SET owner_id = 5
WHERE name IN ('Angemon', 'Boarmon');

/* Insert data for vets */

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

/* Insert the following data for specialties  */

INSERT INTO specializations (vet_id, species_id)
VALUES
((SELECT id FROM vets WHERE vets.name = 'William Tatcher'), (SELECT id FROM species WHERE species.name = 'Pokemon')),
((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), (SELECT id FROM species WHERE species.name = 'Digimon')),
((SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), (SELECT id FROM species WHERE species.name = 'Pokemon')),
((SELECT id FROM vets WHERE vets.name = 'Jack Harkness'), (SELECT id FROM species WHERE species.name = 'Digimon'));

/* Insert the following data for visits */

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
((SELECT id FROM animals WHERE animals.name = 'Agumon'), (SELECT id FROM vets WHERE vets.name = 'William Tatcher'), '2020-05-24'),
((SELECT id FROM animals WHERE animals.name = 'Agumon'), (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), '2020-07-22'),
((SELECT id FROM animals WHERE animals.name = 'Gabumon'), (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'), '2021-02-02'),
((SELECT id FROM animals WHERE animals.name = 'Pikachu'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2020-01-05'),
((SELECT id FROM animals WHERE animals.name = 'Pikachu'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2020-03-08'),
((SELECT id FROM animals WHERE animals.name = 'Pikachu'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2020-05-14'),
((SELECT id FROM animals WHERE animals.name = 'Devimon'), (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), '2021-05-04'),
((SELECT id FROM animals WHERE animals.name = 'Charmander'), (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'), '2021-02-24'),
((SELECT id FROM animals WHERE animals.name = 'Plantmon'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2019-12-21'),
((SELECT id FROM animals WHERE animals.name = 'Plantmon'), (SELECT id FROM vets WHERE vets.name = 'William Tatcher'), '2020-08-10'),
((SELECT id FROM animals WHERE animals.name = 'Plantmon'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2021-04-07'),
((SELECT id FROM animals WHERE animals.name = 'Squirtle'), (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), '2019-09-29'),
((SELECT id FROM animals WHERE animals.name = 'Angemon'), (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'), '2020-10-03'),
((SELECT id FROM animals WHERE animals.name = 'Angemon'), (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'), '2020-11-04'),
((SELECT id FROM animals WHERE animals.name = 'Boarmon'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2019-01-24'),
((SELECT id FROM animals WHERE animals.name = 'Boarmon'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2019-05-15'),
((SELECT id FROM animals WHERE animals.name = 'Boarmon'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2020-02-27'),
((SELECT id FROM animals WHERE animals.name = 'Boarmon'), (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'), '2020-08-03'),
((SELECT id FROM animals WHERE animals.name = 'Blossom'), (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'), '2020-05-24'),
((SELECT id FROM animals WHERE animals.name = 'Blossom'), (SELECT id FROM vets WHERE vets.name = 'William Tatcher'), '2021-01-11');