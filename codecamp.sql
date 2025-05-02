-- adding unique constraints

CREATE TABLE table_name (
    column_name UNIQUE
);

ALTER TABLE table_name
ADD CONSTRAINT some_name UNIQUE(column_name);

-- add or delete not null
CREATE TABLE table_name (
    ssn id integer not null 
);

ALTER COLUMN column_name SET NOT NULL;
ALTER COLUMN column_name DROP NOT NULL;

--- sample 
ALTER TABLE organizations
ADD CONSTRAINT organization_unq UNIQUE(organization)

-- surrogate keys
ALTER TABLE characters
ADD column id serial primary key

-- Count the number of distinct rows with columns make, model
SELECT COUNT(DISTINCT(make, model)) 
FROM cars;

-- Add the id column
ALTER TABLE cars
ADD COLUMN id varchar(128);

-- Update id with make + model
UPDATE cars
SET id = CONCAT(make, model);

-- Make id a primary key
ALTER TABLE cars
ADD CONSTRAINT id_pk PRIMARY KEY(id);

-- Have a look at the table
SELECT * FROM cars;


-- adding releationship
-- REFERENCES
-- CREATE TABLE table_name (
--      col_name type REFERENCES table_name(column_name)
--)
-- Add a professor_id column
ALTER TABLE affiliations
ADD COLUMN professor_id integer REFERENCES professors (id);

-- Rename the organization column to organization_id
ALTER TABLE affiliations
RENAME organization TO organization_id;

-- Add a foreign key on organization_id
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_fkey FOREIGN KEY (organization_id) REFERENCES organizations (id)



-- Here's a way to update columns of a table based on values in another table:
UPDATE table_a
SET column_to_update = table_b.column_to_update_from
FROM table_b
WHERE condition1 AND condition2 AND ...;

--SAMPLE 
-- Update professor_id to professors.id where firstname, lastname correspond to rows in professors
UPDATE affiliations
SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname AND affiliations.lastname = professors.lastname;

-- REFERENCIAL INTEGRITY
-- NO ACTION
-- CASCADE
-- RESTRICT
-- SET NULL
-- SET DEFAULT