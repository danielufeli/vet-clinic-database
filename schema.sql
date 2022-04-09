/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id serial PRIMARY KEY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

/* Add column species of type string */

ALTER TABLE animals
ADD COLUMN species TEXT;


/* Create a table named owners */

CREATE TABLE owners (
  id serial PRIMARY KEY,
  full_name varchar(100),
  age INT
);

/* Create a table named species */

CREATE TABLE species (
  id serial PRIMARY KEY,
  name varchar(100)
);

/* Modify animals table */

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT,
ADD CONSTRAINT species_key
  FOREIGN KEY (species_id)
    REFERENCES species(id),
ADD COLUMN owner_id INT,
ADD CONSTRAINT owner_key
  FOREIGN KEY (owner_id)
    REFERENCES owners(id);

/* Create a table named vets */

CREATE TABLE vets (
id int NOT NULL IDENTITY(1,1),
name varchar(255),
age int,
date_of_graduation date,
PRIMARY KEY (id) );

/* Many-to-many relationship between the tables species and vets */

CREATE TABLE specializations (
  species_id int,
  vet_id int
  );

/* There is a many-to-many relationship between the tables animals and vets */

CREATE TABLE visits (
  animal_id INT,
  vet_id INT,
  visit_date DATE,
  FOREIGN KEY (animal_id) REFERENCES animals (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);
