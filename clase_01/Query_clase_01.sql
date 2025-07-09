CREATE DATABASE IF NOT EXISTS coderhouse;
USE coderhouse;

CREATE TABLE IF NOT EXISTS alumnos(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    dni VARCHAR(9) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    nacionalidad VARCHAR(100) DEFAULT "Argentina"
);

-- Comentado (Todo lo comentado no se ejecuta) ---
-- DROP TABLE persona;
-- DROP TABLE alumnos;

INSERT INTO alumnos(nombre, apellido, dni, email)
	VALUES ("Jesica", "Budip", "30555666", "jesica@email.com");
    
-- SELECT id, nombre, apellido, dni, email FROM alumnos;

SELECT * FROM alumnos;

INSERT INTO alumnos(nombre, apellido, dni, email, nacionalidad)
	VALUES ("Gabriel", "Monardes", "17333555", "gabriel@email.com", "Chile");

INSERT INTO alumnos(nombre, apellido, dni, email, nacionalidad)
	VALUES 
("Gabriel", "Lopez", "22555666", "gabriel1@email.com", "Chile"),
("Gabriela", "Menendez", "12457889", "gabriel2@email.com", "Mexico");