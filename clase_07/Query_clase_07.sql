USE coderhouse;

/*
JSON JavaScript Object Notation (Key - Value)
{
	"id_alumno" : 1,
    "nombre" : "Diego",
    "apellido" : "Fernandez",
	"email" : "diego@mail.com",
    "dni" : 23565656,
    "edad" : 18,
    "telefono" : "1133366",
    "nacionalidad" : "Argentina"
}

CSV
1,	Diego,	Fernandez,	diego@mail.com,	23565656,	18,	1133366,	Argentina

// POR CONSOLA
mysql -u root -p > alumnos.sql
*/

/*
	Desbloquear el cheq de las FK
    
    SET FOREIGN_KEY_CHECKS = 0; // Deshabilitar -- Impportar, Truncar, Etc
    SET FOREIGN_KEY_CHECKS = 1; // Volver a habilitar
*/

SET FOREIGN_KEY_CHECKS = 0; -- False = 0
SET FOREIGN_KEY_CHECKS = 1; -- True  = 1

TRUNCATE TABLE inscripciones;
DELETE FROM inscripciones;

TRUNCATE TABLE categoria;
DELETE FROM categoria;

TRUNCATE TABLE cursos;
DELETE FROM cursos;

TRUNCATE TABLE alumnos;
DELETE FROM alumnos;

ALTER TABLE inscripciones DROP FOREIGN KEY inscripciones_ibfk_1;

-- Para poder importar todas las tablas sin problema, eliminamos la Base de Datos y Creamos otra nuevamente
DROP DATABASE IF EXISTS coderhouse;
CREATE DATABASE coderhouse;
USE coderhouse;

-- A partir de aca Importamos las tablas.
-- El Orden Seria:
/*
- Catagoria
- Cursos
- Alumnos 
- Insripciones
*/

-- Importar una Tabla usando Load Data a partir de un archivo CSV

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'secure_file_priv';

-- Desde carpeta Local CON PERMISOS
LOAD DATA INFILE 'E:/CoderHouse/sql/SQL_Flex---81830/clase_07/inscripciones.csv'
INTO TABLE inscripciones
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(idx_alumno, idx_curso, inscription_at);

-- Desde Carpeta Segura Sin necesidad de Permisos
LOAD DATA INFILE 'C:/Program Files/MySQL/MySQL Server 8.0/Uploads/inscripciones.csv'
INTO TABLE inscripciones
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(idx_alumno, idx_curso, inscription_at);






