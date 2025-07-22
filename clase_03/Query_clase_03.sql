USE coderhouse;

CREATE TABLE IF NOT EXISTS alumnos(
	id_alumno INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    edad INT UNSIGNED DEFAULT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'Argentina'
);

CREATE TABLE IF NOT EXISTS cursos(
	id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS inscripciones (
	idx_alumno INT,
	idx_curso INT,
    inscription_at DATETIME DEFAULT CURRENT_TIMESTAMP,    
    PRIMARY KEY (idx_alumno, idx_curso),
    FOREIGN KEY (idx_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (idx_curso) REFERENCES cursos(id_curso)
);


/*
 Iserciones
*/

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("Diego", "Fernandez", "diego@mail.com", 23565656, 25, "1133366"),
("Sabrina", "Gonzalez", "sabri@mail.com", 33556565, 23, "11555666"),
("Soledad", "Pastoruti", "lasole@mail.com", 40565655, 35, "1156666"),
("Enrique", "Octavo", "henry@mail.com", 6521212, 22, "2265656");
INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES
("Fabrizzio", "Primero", "fabri@mail.com", 2564862, 33, "2299656");

SELECT * FROM alumnos;

INSERT INTO cursos(nombre_curso) VALUES
	("SQL Basico"),
    ("SQL Avanzado"),
    ("JavaScript"),
    ("Backend"),
    ("Java"),
    ("Python");
    
SELECT * FROM cursos;

-- Realizar Inscripciones:
INSERT INTO inscripciones (idx_alumno, idx_curso) VALUES
(1,1), (1,2), (1,6), (2, 6), (2, 4), (3, 3), (4,1), (4,2), (4, 3),(4,6);

SELECT * FROM inscripciones;
INSERT INTO inscripciones (idx_alumno, idx_curso) VALUES
(1,3);
INSERT INTO inscripciones (idx_alumno, idx_curso) VALUES
(1,5);

-- UNION de Tablas

-- INNER JOIN
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    INNER JOIN inscripciones i ON a.id_alumno = i.idx_alumno
    INNER JOIN cursos c ON i.idx_curso = c.id_curso;

-- LEFT JOIN
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    LEFT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
    LEFT JOIN cursos c ON i.idx_curso = c.id_curso;
    
-- RIGHT JOIN
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    RIGHT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
    RIGHT JOIN cursos c ON i.idx_curso = c.id_curso;
    
-- UNION 
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    LEFT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
    LEFT JOIN cursos c ON i.idx_curso = c.id_curso
    
    UNION
    
SELECT a.nombre, a.apellido, a.dni, c.nombre_curso
	FROM alumnos a
    RIGHT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
    RIGHT JOIN cursos c ON i.idx_curso = c.id_curso;
    
-- -------------------------------------------------------------------------

/*
	Uso de LIKE, Comodines y REGEX
*/

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono, nacionalidad
) VALUES 
("Micaela", "Fernandez", "mica@mail.com", 33365656, 25, "12345678", "Uruguay"),
("Sabrina Lorena", "Gonzalez", "sabrilo@mail.com", 33599965, 29, "11551166", "Brasil"),
("Soledad", "Hecheverrria", "sole@mail.com", 4999655, 35, "11534666", "Uruguay"),
("Enrique", "Pintos", "enrique@mail.com", 16521212, 22, "12265656", "Chile");

SELECT * FROM alumnos;
-- Traer todos los alumnos que empiecen con A
SELECT nombre, apellido, dni, telefono, nacionalidad
	FROM alumnos
    WHERE nombre LIKE "S%"
    ORDER BY nombre ASC;

-- Traer todos los alumnos que contengan A
SELECT nombre, apellido, dni, telefono, nacionalidad
	FROM alumnos
    WHERE nombre LIKE "%a%"
    ORDER BY nombre ASC;

-- Traer a todos lo alumnos que tenga GMAIL
SELECT nombre, apellido, dni, telefono, nacionalidad
	FROM alumnos
    WHERE email LIKE "%@gmail.com"
    ORDER BY nombre ASC;

SELECT nombre, apellido, dni, telefono, nacionalidad
	FROM alumnos
    WHERE nombre LIKE "M%"
    OR nombre LIKE "S%"
    ORDER BY nombre ASC;

-- USANDO REGEX
SELECT nombre, apellido, dni, telefono, nacionalidad
	FROM alumnos
    WHERE nombre REGEXP "^[A-M]"
    ORDER BY nombre ASC;

-- ------------------------------------------------------------------------
-- Subconsultas SQL
SELECT * FROM alumnos;
-- Traer el/la Alumno de mayor edad

SELECT nombre, apellido, dni, telefono
	FROM alumnos
    WHERE edad = (SELECT MAX(edad) FROM alumnos);
    
-- Traer de la Tabla de Alumnos a los alumnos mas chicos de cada Pais
SELECT nombre, apellido, dni, telefono, nacionalidad
	FROM alumnos
    WHERE (nacionalidad, edad) IN (
    SELECT nacionalidad, MIN(edad)
    FROM alumnos
    GROUP BY nacionalidad);
 
 -- Funciones de Texto
 
 -- Traer a todos los alumnos que esten por encima del promedio de edad
 SELECT UPPER(email) AS email_mayuscula, nombre, LOWER(apellido) AS APELLIDO, edad
	FROM alumnos
    WHERE edad > (SELECT AVG(edad) FROM alumnos);
    
SELECT a.nombre, a.apellido, i.inscription_at AS fecha_inscripcion
	FROM alumnos a
    INNER JOIN inscripciones i ON a.id_alumno = i.idx_alumno
    WHERE i.inscription_at < DATE_SUB(NOW(), INTERVAL 1 YEAR);
    
    
-- DDL
TRUNCATE inscripciones;

-- No es romendable por ser DESTRUCTIVO
RENAME TABLE alumnos TO estudiantes;
RENAME TABLE estudiantes TO alumnos;
    