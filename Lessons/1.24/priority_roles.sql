CREATE OR REPLACE TABLE priority_roles (
    role_id      INTEGER PRIMARY KEY,
    role_name    VARCHAR,
    priority_level INTEGER
);

INSERT INTO priority_roles (role_id, role_name, priority_level)
VALUES
    (1, 'Data Engineer', 1),
    (2, 'Senior Data Engineer', 1),
    (3, 'Software Engineer', 3);

    SELECT * FROM priority_roles;