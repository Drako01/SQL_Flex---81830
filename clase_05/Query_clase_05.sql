USE coderhouse;

-- VISTAS

-- Vistas Simples
CREATE VIEW view_alumnos AS SELECT nombre, apellido, email FROM coderhouse.alumnos;

SELECT nombre, apellido, email FROM coderhouse.alumnos;
SELECT * FROM view_alumnos;

CREATE VIEW view_alumnos_completa AS SELECT nombre, apellido, email, telefono, edad FROM coderhouse.alumnos;

SELECT nombre, apellido, email, telefono, edad FROM coderhouse.alumnos;
SELECT * FROM view_alumnos_completa;

-- Vistas compuestas

CREATE VIEW view_inscripciones_alumnos AS
SELECT 
	a.id_alumno,
    CONCAT(a.nombre, ' ',a.apellido) AS nombre_completo,
    a.email,
    a.edad,
    a.telefono,
    a.nacionalidad,
    c.nombre_curso,
    i.inscription_at
FROM inscripciones i
JOIN alumnos a ON i.idx_alumno = a.id_alumno
JOIN cursos c ON i.idx_curso = c.id_curso;
    
SELECT * FROM view_inscripciones_alumnos;


-- Si lo que quiero ver son todos los alumnos y los cursos a los que estan inscriptos.
CREATE VIEW view_alumnos_cursos AS
SELECT
	CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    c.nombre_curso
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
LEFT JOIN cursos c ON c.id_curso = i.idx_curso;


-- Si lo que quiero es ver los cursos y sus alumnos incriptos
CREATE VIEW view_alumnos_inscriptos_por_curso AS
SELECT
	c.id_curso,
    c.nombre_curso,
    CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    a.email,
    a.nacionalidad
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.idx_curso
LEFT JOIN alumnos a ON i.idx_alumno = a.id_alumno
ORDER BY c.id_curso;

-- Podemos 1ro Eliminar la vista
DROP VIEW view_cursos_x_alumno;
-- 2do Recrearla con dato nuevos o modificados
CREATE VIEW view_cursos_x_alumno AS
SELECT
	c.id_curso,
    c.nombre_curso,
    CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    a.email,
    a.edad,
    a.nacionalidad
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.idx_curso
LEFT JOIN alumnos a ON i.idx_alumno = a.id_alumno
ORDER BY c.id_curso;

-- Al momento de crearla validar si existe, sino reemplazarla
CREATE OR REPLACE VIEW view_cursos_x_alumno AS
SELECT
	c.id_curso,
    c.nombre_curso,
    CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    a.email,
    a.edad,
    a.nacionalidad
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.idx_curso
LEFT JOIN alumnos a ON i.idx_alumno = a.id_alumno
ORDER BY c.id_curso;

CREATE OR REPLACE VIEW view_cursos_x_alumno AS
SELECT
	c.id_curso,
    c.nombre_curso,
    CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.idx_curso
LEFT JOIN alumnos a ON i.idx_alumno = a.id_alumno
ORDER BY c.id_curso;
SELECT * FROM view_cursos_x_alumno;

-- Agregamos una columna de Categoria a Cursos
-- 1ro Creamos la tabla Categorias
CREATE TABLE categoria (
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categoria (nombre_categoria) VALUES ("Base de Datos"), ("Programacion");
SELECT * FROM categoria;

ALTER TABLE cursos ADD COLUMN id_categoria INT;
ALTER TABLE cursos ADD CONSTRAINT fk_curso_categoria
FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria);


-- Mostrar la categoria con mas cursos asociados
CREATE VIEW view_categoria_con_mas_cursos AS
SELECT
	cat.nombre_categoria,
    COUNT(cur.id_curso) AS cantidad_cursos
FROM categoria cat
LEFT JOIN cursos cur ON cur.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria
ORDER BY cantidad_cursos DESC;


-- Mostrar toda la informacion de las inscripciones de los alumnos

CREATE VIEW view_inscripciones_alumno_categoria AS
SELECT
	CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    c.nombre_curso,
    cat.nombre_categoria,
    a.nacionalidad
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
LEFT JOIN cursos c ON c.id_curso = i.idx_curso
LEFT JOIN categoria cat ON cat.id_categoria = c.id_categoria
ORDER BY nombre_categoria DESC;

-- 
CREATE VIEW view_inscripciones_alumno_categoria_agrupadas AS
SELECT
	CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
	c.nombre_curso,
    cat.nombre_categoria,
    a.nacionalidad
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
LEFT JOIN cursos c ON c.id_curso = i.idx_curso
LEFT JOIN categoria cat ON cat.id_categoria = c.id_categoria
GROUP BY nombre_completo, c.nombre_curso, cat.nombre_categoria, a.nacionalidad
ORDER BY c.nombre_curso DESC;


SELECT * FROM view_inscripciones_alumno_categoria_agrupadas;