USE coderhouse;

-- 1) DEMO DELETE CASCADE: borrar un alumno y ver cómo se borran sus inscripciones
SELECT COUNT(*) AS antes FROM inscripciones WHERE idx_alumno = 1;
DELETE FROM alumnos WHERE id_alumno = 1;
SELECT COUNT(*) AS despues FROM inscripciones WHERE idx_alumno = 1;

-- 2) DEMO UPDATE CASCADE: cambiar el id_curso (prohibido en la vida real, pero sirve para mostrar el efecto)
--    Primero reponemos datos para que exista el curso con id=4 y sus inscripciones.
INSERT INTO alumnos (id_alumno, nombre, apellido, email, dni, edad, telefono, nacionalidad)
VALUES (1,'Ana','Pérez','ana@example.com',30111222,28,'113334444','Argentina')
ON DUPLICATE KEY UPDATE nombre=VALUES(nombre);

INSERT INTO inscripciones (idx_alumno, idx_curso, inscription_at)
VALUES (1,4,NOW())
ON DUPLICATE KEY UPDATE inscription_at=VALUES(inscription_at);

SELECT idx_curso FROM inscripciones WHERE idx_curso IN (4,40) ORDER BY idx_curso;

UPDATE cursos SET id_curso = 40 WHERE id_curso = 4; -- Cascada actualiza inscripciones.idx_curso

SELECT idx_curso FROM inscripciones WHERE idx_curso IN (4,40) ORDER BY idx_curso;
