USE coderhouse;

INSERT INTO categoria (nombre_categoria) VALUES ("Cloud"), ("UX/UI");

-- Insertar datos haciendo una Subconsulta:

SELECT id_categoria FROM categoria WHERE nombre_categoria = "Cloud";
SELECT id_categoria FROM categoria WHERE nombre_categoria = "UX/UI";

INSERT INTO cursos (nombre_curso, id_categoria) VALUES
("Docker", (SELECT id_categoria FROM categoria WHERE nombre_categoria = "Cloud")),
("AWS", (SELECT id_categoria FROM categoria WHERE nombre_categoria = "Cloud")),
("Figma", (SELECT id_categoria FROM categoria WHERE nombre_categoria = "UX/UI")),
("Canva", (SELECT id_categoria FROM categoria WHERE nombre_categoria = "UX/UI"));

INSERT INTO cursos (nombre_curso, id_categoria) VALUES
("Google Cloud", (SELECT id_categoria FROM categoria WHERE nombre_categoria = "Cloud"));

INSERT INTO cursos (nombre_curso, id_categoria) VALUES
("Azure", (SELECT id_categoria FROM categoria WHERE nombre_categoria = "Cloud"));

-- Crear una inscripcion usando Subconsultas DML
INSERT INTO inscripciones (idx_alumno, idx_curso)
SELECT a.id_alumno , c.id_curso
FROM alumnos a
JOIN cursos c ON c.nombre_curso IN ("Canva", "Figma", "AWS", "UX/UI")
WHERE a.nombre IN ("Diego", "Soledad", "Fabrizzio", "Micaela");

-- Hacer Insert usando los Default y los Null
INSERT INTO alumnos (nombre, apellido, email, dni, edad, telefono, nacionalidad) VALUES
("Alejandro", "Ferreira", NULL, 23595656, NULL, NULL, DEFAULT);

-- Insert usando un Select como Subconsulta Simple

SELECT id_curso FROM cursos WHERE nombre_curso = "Google Cloud"; -- 11
SELECT id_alumno FROM alumnos WHERE email IS NOT NULL;

-- Inscribir a todos los alumnos cuyo email es distinto de NULL al curso "Google Cloud"
INSERT INTO inscripciones (idx_alumno, idx_curso)
SELECT id_alumno,  (SELECT id_curso FROM cursos WHERE nombre_curso = "Google Cloud") -- AS id_curso
FROM alumnos WHERE email IS NOT NULL;

-- Insert omitiendo el UNIQUE
INSERT IGNORE INTO alumnos (nombre, apellido, email, dni) VALUES
("Ana", "Ramirez", "ana@mail.com", 23565656);

-- UPDATE
UPDATE alumnos 
SET telefono = "1199998888", email = "alejandro@mail.com"
WHERE id_alumno = 15;

UPDATE alumnos
SET edad = 22, dni = 99888555
WHERE email = "alejandro@mail.com";


-- OJO CON ESTO ES PELIGROSO --
SET SQL_SAFE_UPDATES = 0;

UPDATE alumnos
SET edad = 18
WHERE nacionalidad = "Argentina";

SET SQL_SAFE_UPDATES = 1;
-- OJO CON ESTO ES PELIGROSO --

-- DELETE
DELETE FROM alumnos WHERE id_alumno = 15; 

-- Borrar la inscripcon mas antigua
DELETE FROM inscripciones 
ORDER BY inscription_at ASC
LIMIT 1;


-- Borrar un curso afectado a una categoria

-- Esto falla porque hay una inscripcion relacionada con este curso por medio de una FK
DELETE FROM cursos WHERE nombre_curso = "Canva";

-- Primero borramos las Inscripciones asociadas
DELETE FROM inscripciones 
WHERE idx_curso = (SELECT id_curso FROM cursos WHERE nombre_curso = "Canva"); -- Obtengo el id_curso

DELETE FROM cursos WHERE nombre_curso = "Canva";


-- Subconsultas Bien Bravas


-- Inscribir a todos los alumnos que tengan email 
INSERT INTO inscripciones (idx_alumno, idx_curso)
SELECT a.id_alumno, c.id_curso
FROM alumnos a
CROSS JOIN (SELECT id_curso FROM cursos WHERE nombre_curso = "Azure") c
WHERE a.email IS NOT NULL
AND NOT EXISTS (
	SELECT 1 FROM inscripciones i
    WHERE i.idx_alumno = a.id_alumno AND i.idx_curso = c.id_curso
);

-- UPDATE con Subconsulta
-- Setear id_categoria correctamente en cursos basado en su nombre.
UPDATE cursos c
SET c.id_categoria = (
	SELECT id_categoria FROM categoria cat
    WHERE (cat.nombre_categoria = "Base de Datos" AND c.nombre_curso IN ("SQL Avanzado", "SQL Basico"))
		OR (cat.nombre_categoria = "Programacion" AND c.nombre_curso IN ("Java", "JavaScript", "Python", "Backend"))
        OR (cat.nombre_categoria = "Cloud" AND c.nombre_curso IN ("Docker", "AWS", "Google Cloud", "Azure"))
        OR (cat.nombre_categoria = "UX/UI" AND c.nombre_curso IN ("Figma", "Canva"))
	LIMIT 1
);


-- 


