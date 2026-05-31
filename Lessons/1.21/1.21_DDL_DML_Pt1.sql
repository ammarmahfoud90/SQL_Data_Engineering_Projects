CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

-- DROP DATABASE IF EXISTS jobs_mart;

SELECT
    *
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS jobs_mart.staging;

-- DROP SCHEMA IF EXISTS staging;

SHOW DATABASES;

CREATE TABLE IF NOT EXISTS prefered_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

-- DROP TABLE IF EXISTS prefered_roles;

INSERT INTO  prefered_roles(role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'SOFTWARE Engineer');

SELECT  *
FROM prefered_roles;

ALTER TABLE prefered_roles
ADD COLUMN prefered_role BOOLEAN;

 /*
 ALTER TABLE prefered_roles
 DROP COLUMN prefered_role;
 */

UPDATE prefered_roles
SET prefered_role = TRUE
WHERE role_id = 1 OR role_id= 2;

UPDATE prefered_roles
SET prefered_role = FALSE
WHERE role_id = 3;

ALTER TABLE prefered_roles
RENAME TO priority_roles;

SELECT  *
FROM priority_roles;

ALTER TABLE priority_roles
RENAME COLUMN prefered_role TO PRIORITY_LEVEL;

ALTER TABLE priority_roles
ALTER COLUMN PRIORITY_LEVEL TYPE INTEGER;

UPDATE priority_roles
SET PRIORITY_LEVEL = 3
WHERE role_id = 3;