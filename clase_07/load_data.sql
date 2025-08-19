-- Ejecutar luego de crear la DB con schema.sql
USE coderhouse;

SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE inscripciones;
TRUNCATE TABLE cursos;
TRUNCATE TABLE categoria;
TRUNCATE TABLE alumnos;

LOAD DATA LOCAL INFILE '/mnt/data/unidad7_assets/categoria.csv'
INTO TABLE categoria
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_categoria, nombre_categoria);

LOAD DATA LOCAL INFILE '/mnt/data/unidad7_assets/cursos.csv'
INTO TABLE cursos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_curso, nombre_curso, id_categoria);

LOAD DATA LOCAL INFILE '/mnt/data/unidad7_assets/alumnos.csv'
INTO TABLE alumnos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_alumno, nombre, apellido, email, dni, edad, telefono, nacionalidad);

LOAD DATA LOCAL INFILE '/mnt/data/unidad7_assets/inscripciones.csv'
INTO TABLE inscripciones
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idx_alumno, idx_curso, inscription_at);

SET FOREIGN_KEY_CHECKS=1;

-- Check rápido
SELECT * FROM cursos_inscripciones_count ORDER BY id_curso;
