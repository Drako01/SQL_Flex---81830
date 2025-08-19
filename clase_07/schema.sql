-- Unidad 7 - Importación y Gestión de Datos (MySQL)
DROP DATABASE IF EXISTS coderhouse;
CREATE DATABASE coderhouse;
USE coderhouse;

-- 1) Tablas base
CREATE TABLE categoria (
  id_categoria INT PRIMARY KEY AUTO_INCREMENT,
  nombre_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE alumnos (
  id_alumno INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(80) NOT NULL,
  email VARCHAR(150) UNIQUE,
  dni INT UNIQUE NOT NULL,
  edad INT UNSIGNED,
  telefono VARCHAR(20) UNIQUE,
  nacionalidad VARCHAR(30) DEFAULT 'Argentina'
);

CREATE TABLE cursos (
  id_curso INT PRIMARY KEY AUTO_INCREMENT,
  nombre_curso VARCHAR(50) NOT NULL,
  id_categoria INT,
  CONSTRAINT fk_curso_categoria FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE inscripciones (
  idx_alumno INT,
  idx_curso INT,
  inscription_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (idx_alumno, idx_curso),
  CONSTRAINT fk_insc_alumno FOREIGN KEY (idx_alumno)
    REFERENCES alumnos(id_alumno)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_insc_curso FOREIGN KEY (idx_curso)
    REFERENCES cursos(id_curso)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- 2) Vista útil para KPIs rápidos
CREATE OR REPLACE VIEW cursos_inscripciones_count AS
SELECT c.id_curso, COUNT(i.idx_curso) AS cantidad_inscripciones
FROM cursos c
LEFT JOIN inscripciones i ON i.idx_curso = c.id_curso
GROUP BY c.id_curso;
