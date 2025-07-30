USE coderhouse;

-- Crear un Indice 
CREATE INDEX idx_apellido ON alumnos(apellido);

CREATE INDEX idx_nombre_curso ON cursos(nombre_curso);

-- VISTAS
CREATE VIEW view_inscripciones_alumnos AS
SELECT
	CONCAT(a.nombre, ' ', a.apellido) AS nombre_completo,
    a.email,
    c.nombre_curso,
    i.inscription_at
FROM inscripciones i
JOIN alumnos a ON i.idx_alumno = a.id_alumno
JOIN cursos c ON i.idx_curso = c.id_curso;

-- Agregamos Inscripciones
INSERT INTO inscripciones (idx_alumno, idx_curso) VALUES
(1,1), (1,2), (1,6), (2, 6), (2, 4), (3, 3), (4,1), (4,2), (4, 3),(4,6);

-- Para llamar a la vista
SELECT * FROM view_inscripciones_alumnos;

SELECT * FROM view_inscripciones_alumnos WHERE nombre_curso = 'SQL Basico';

-- Stored Procedures
DELIMITER //

CREATE PROCEDURE ObtenerInscripcionesPorDia()
BEGIN
	SELECT DATE(inscription_at) AS fecha,
    COUNT(*) AS cantidad_inscripciones
    FROM inscripciones
    GROUP BY fecha
    ORDER By fecha;
END //

DELIMITER ;

CALL ObtenerInscripcionesPorDia();

-- Triggers
CREATE TABLE cursos_inscripciones_count (
	id_curso INT PRIMARY KEY,
    cantidad_inscripciones INT DEFAULT 0,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

DELIMITER //

CREATE TRIGGER after_inscription_insert
AFTER INSERT ON inscripciones
FOR EACH ROW
BEGIN
	DECLARE curso_count INT;

    SELECT cantidad_inscripciones INTO curso_count
    FROM cursos_inscripciones_count
    WHERE id_curso = NEW.idx_curso;

    IF curso_count IS NULL THEN
		INSERT INTO cursos_inscripciones_count (id_curso, cantidad_inscripciones)
        VALUES (NEW.idx_curso, 1);
	ELSE	
		UPDATE cursos_inscripciones_count
        SET cantidad_inscripciones = cantidad_inscripciones + 1
        WHERE id_curso = NEW.idx_curso;
	END IF;
END //

DELIMITER ;

-- Generamos una Inscripcion
INSERT INTO inscripciones (idx_alumno, idx_curso) VALUES
(3,4);

-- Trigger que me avisa si el alumno ya estaba inscripto en un curso
DELIMITER //

CREATE TRIGGER before_inscription_insert
BEFORE INSERT ON inscripciones
FOR EACH ROW
BEGIN
	DECLARE existe INT;
    
    SELECT COUNT(*) INTO existe
    FROM inscripciones
    WHERE idx_alumno = NEW.idx_alumno AND idx_curso = NEW.idx_curso;
    
    IF existe > 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El Alumno ya esta inscripto en este curso';
        END IF;	
END //
        
DELIMITER ;


DROP TRIGGER IF EXISTS before_inscription_insert;
-- Probamos el trigger
INSERT INTO inscripciones (idx_alumno, idx_curso) VALUES
(1,2);


-- Funciones
DELIMITER //

CREATE FUNCTION CantidadDeInscriptosCurso(idCurso INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cantidad INT;
    
    SELECT COUNT(*) INTO cantidad
    FROM inscripciones 
    WHERE idx_curso = idCurso;
    
    RETURN cantidad;
END //

DELIMITER ;

-- Llamar a la Funcion

SELECT CantidadDeInscriptosCurso(5) AS cantidad_inscriptos;


-- Diagrama Entidad - Relacion
