# Curso SQL

## 1. ¿Qué es un JOIN?

En SQL, un **JOIN** es la forma de **combinar datos de dos o más tablas** en base a una relación lógica entre ellas.
Normalmente, esa relación se basa en **claves primarias (Primary Key)** y **claves foráneas (Foreign Key)**, aunque también puedes unir por cualquier columna que tenga datos en común.

### Ejemplo básico de relación

Supongamos que tenemos estas tablas:

**Tabla `alumnos`**

| id\_alumno | nombre | nacionalidad |
| ---------- | ------ | ------------ |
| 1          | Ana    | Argentina    |
| 2          | Juan   | Chile        |
| 3          | Laura  | Perú         |

**Tabla `cursos`**

| id\_curso | nombre\_curso |
| --------- | ------------- |
| 101       | SQL Básico    |
| 102       | Python        |
| 103       | Excel         |

**Tabla `inscripciones`**

| id\_inscripcion | idx\_alumno | idx\_curso |
| --------------- | ----------- | ---------- |
| 1               | 1           | 101        |
| 2               | 1           | 102        |
| 3               | 2           | 103        |

Aquí, `inscripciones.idx_alumno` es **clave foránea** que apunta a `alumnos.id_alumno`, y `inscripciones.idx_curso` apunta a `cursos.id_curso`.

---

## 2. Tipos de JOIN

### 2.1 INNER JOIN

Devuelve **solo las filas que tienen coincidencia en ambas tablas**.

```sql
SELECT a.nombre, c.nombre_curso
FROM alumnos a
INNER JOIN inscripciones i ON a.id_alumno = i.idx_alumno
INNER JOIN cursos c ON c.id_curso = i.idx_curso;
```

**Resultado**:

| nombre | nombre\_curso |
| ------ | ------------- |
| Ana    | SQL Básico    |
| Ana    | Python        |
| Juan   | Excel         |

> Los alumnos sin inscripciones no aparecen.

---

### 2.2 LEFT JOIN (o LEFT OUTER JOIN)

Devuelve **todas las filas de la tabla izquierda**, aunque no tengan coincidencia en la derecha.
Si no hay coincidencia, los campos de la derecha salen como `NULL`.

```sql
SELECT a.nombre, c.nombre_curso
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
LEFT JOIN cursos c ON c.id_curso = i.idx_curso;
```

**Resultado**:

| nombre | nombre\_curso |
| ------ | ------------- |
| Ana    | SQL Básico    |
| Ana    | Python        |
| Juan   | Excel         |
| Laura  | NULL          |

> Laura aparece aunque no esté inscrita en ningún curso.

---

### 2.3 RIGHT JOIN (o RIGHT OUTER JOIN)

Es lo opuesto al LEFT JOIN: devuelve **todas las filas de la tabla derecha** y solo las que coinciden de la izquierda.

```sql
SELECT a.nombre, c.nombre_curso
FROM alumnos a
RIGHT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
RIGHT JOIN cursos c ON c.id_curso = i.idx_curso;
```

En MySQL, normalmente se prefiere usar LEFT JOIN cambiando el orden de las tablas, pero RIGHT JOIN es útil en algunos casos.

---

### 2.4 FULL JOIN (FULL OUTER JOIN)

Devuelve **todas las filas de ambas tablas**, coincidan o no.
⚠ MySQL no lo soporta directamente, pero se puede simular con `UNION`.

```sql
-- Simulación en MySQL
SELECT a.nombre, c.nombre_curso
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
LEFT JOIN cursos c ON c.id_curso = i.idx_curso

UNION

SELECT a.nombre, c.nombre_curso
FROM alumnos a
RIGHT JOIN inscripciones i ON a.id_alumno = i.idx_alumno
RIGHT JOIN cursos c ON c.id_curso = i.idx_curso;
```

---

### 2.5 CROSS JOIN

Combina **todas las filas de una tabla con todas las filas de la otra** (producto cartesiano).
No requiere condición `ON`.

```sql
SELECT a.nombre, c.nombre_curso
FROM alumnos a
CROSS JOIN cursos c;
```

Si `alumnos` tiene 3 filas y `cursos` tiene 3, obtendrás 9 combinaciones.

---

## 3. Relaciones más comunes

### 3.1 Uno a Muchos

Un alumno puede tener **muchas inscripciones**:

```
alumnos.id_alumno 1 ---- n inscripciones.idx_alumno
```

### 3.2 Muchos a Muchos

Un alumno puede estar en muchos cursos, y un curso tener muchos alumnos:

```
alumnos <--- inscripciones ---> cursos
```

La tabla intermedia `inscripciones` es necesaria.

---

## 4. Consejos prácticos

* Siempre que puedas, usa **alias** (`a`, `c`, `i`) para que las consultas sean más legibles.
* Filtra en el `ON` para relaciones y en el `WHERE` para condiciones adicionales.
* Evita `SELECT *` en joins grandes para no traer datos innecesarios.
* Si la relación es grande, revisa que las columnas usadas en el `ON` tengan **índices**.

---

## 🧑‍🏫 Profesor  

👨‍💻 **Alejandro Daniel Di Stefano**  
📌 **Desarrollador Full Stack**  
🔗 **GitHub:** [Drako01](https://github.com/Drako01)  
