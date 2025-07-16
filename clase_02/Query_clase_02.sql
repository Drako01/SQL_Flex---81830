/*
 Comentarios en 
 varios 
 renglones
*/

-- Una sola linea de Comentario

/*
 Sublenguajes SQL
 DDL - Data Definition Language
 DML - Data Manipulation Language
 DCL - Data Control Language -- Controlar Permisos
 TCL - Transaction Control Language -- Controlar Transacciones 
*/

-- DDL - Data Definition Language
USE coderhouse;
CREATE DATABASE IF NOT EXISTS coderhouse;
CREATE TABLE IF NOT EXISTS coderhouse.alumnos(
	id_alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    email VARCHAR(150) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'Argentina'
);

-- DROP TABLE coderhouse.alumnos;
ALTER TABLE coderhouse.alumnos ADD COLUMN fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE coderhouse.alumnos ADD COLUMN instituto VARCHAR(120);
ALTER TABLE coderhouse.alumnos ADD COLUMN edad INT UNSIGNED DEFAULT NULL;
ALTER TABLE coderhouse.alumnos MODIFY COLUMN instituto VARCHAR(60) DEFAULT 'CoderHouse';


-- DML Data Manipulation Language
SELECT * FROM alumnos;

INSERT INTO alumnos(nombre, apellido, dni) VALUES ("Alejandro", "Di Stefano", 22333555);
INSERT INTO alumnos(nombre, apellido, email, dni, edad) VALUES ("Diego", "Fernandez", "diego@mail.com", 23565656, 25);
INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("Sabrina", "Gonzalez", "sabri@mail.com", 33556565, 23, "11555666");

INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("Soledad", "Pastoruti", "lasole@mail.com", 40565655, 35, "1156666"),
("Enrique", "Octavo", "henry@mail.com", 6521212, 22, "2265656");


INSERT INTO alumnos(
nombre, apellido, email, dni, edad, telefono
) VALUES 
("German", "Legresti", "german@mail.com", 23455987, 35, "12345663"),
("Soledad", "Ferreyra", NULL, 326655655, 41, NULL),
("Hernan", "Garcia", "asdadasd@mail.com", 23555656, 30, "16521212");

-- SET SQL_SAFE_UPDATES = 0;
-- SET SQL_SAFE_UPDATES = 1;

UPDATE alumnos SET edad = 49 WHERE id_alumno = 1;
UPDATE alumnos SET email = "diegoreyes@mail.com", telefono = "22651656", apellido = "Reyes" WHERE id_alumno = 3;
UPDATE alumnos SET nacionalidad = "Uruguaya" WHERE  id_alumno > 6;
DELETE FROM alumnos WHERE id_alumno = 5;

DELETE FROM alumnos WHERE edad > 35;

-- Uso de Alias
SELECT COUNT(*) AS alumnos_uruguayos FROM alumnos WHERE nacionalidad = "Uruguaya";
SELECT COUNT(*) AS alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";

SELECT SUM(edad) AS suma_total_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";
SELECT AVG(edad) AS promedio_edades_alumnos_argentinos FROM alumnos WHERE nacionalidad = "Argentina";

SELECT
		COUNT(edad) AS cantidad_alumnos,
        SUM(edad) AS suma_edades,
        AVG(edad) AS promedio_edades
FROM alumnos 
	WHERE nacionalidad = "Argentina";



SELECT nombre, apellido, edad 
FROM alumnos
WHERE edad >= 18
ORDER BY edad DESC;

-- Consultar Mas Joven y el Mayor
SELECT
	MIN(edad) AS Joven,
    MAX(edad) AS Mayor
FROM alumnos;

SELECT nombre, apellido, email, edad, telefono, nacionalidad
FROM alumnos
ORDER BY nacionalidad ASC
LIMIT 10;



SELECT nacionalidad,
COUNT(*) AS Grupo_Nacionalidad
FROM alumnos
GROUP BY nacionalidad;












