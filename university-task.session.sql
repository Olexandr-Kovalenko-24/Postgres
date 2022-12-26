CREATE TABLE faculties (
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK (name != '')
);

CREATE TABLE groups (
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK (name != ''),
    faculty_id int REFERENCES faculties(id)
);

CREATE TABLE students (
    id serial PRIMARY KEY,
    first_name varchar(256) NOT NULL CHECK (first_name != ''),
    last_name varchar(256) NOT NULL CHECK (last_name != ''),
    groups_id int REFERENCES groups(id)
);

CREATE TABLE disciplines (
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK (name != ''),
    professor varchar(256) NOT NULL CHECK (name != '')
);

CREATE TABLE examens (
    student_id int REFERENCES students(id),
    disciplines_id int REFERENCES disciplines(id),
    grade int,
    PRIMARY KEY(student_id, disciplines_id)
);

CREATE TABLE disciplines_to_faculties(
    discipline_id int REFERENCES disciplines(id),
    faculty_id int REFERENCES faculties(id),
    PRIMARY KEY(discipline_id, faculty_id)
);