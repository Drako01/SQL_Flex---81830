# Unidad 7 - Importación y Gestión de Datos (Material de clase)

Archivos:

- `schema.sql`: crea la base `coderhouse` y tablas con FKs y cascadas.
- `categoria.csv`, `cursos.csv`, `alumnos.csv`, `inscripciones.csv`: datasets de ejemplo.
- `load_data.sql`: usa `LOAD DATA LOCAL INFILE` para importar los CSV.
- `demo_cascade.sql`: script de demostración para `DELETE CASCADE` y `UPDATE CASCADE`.

Orden sugerido:

1. Importar `schema.sql`
2. Importar CSV vía Workbench (Table Data Import Wizard) **o** ejecutar `load_data.sql`
3. Probar `demo_cascade.sql`

Notas:

- Si `LOAD DATA` falla, habilitar `local_infile` en el cliente (`--local-infile=1`) y en el servidor (`SET GLOBAL local_infile=1;`).
- Usuario Windows: ejecutar la consola como administrador si hay errores de permisos al leer archivos locales.
