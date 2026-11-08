-- =====================================================================
-- ===== CLASE 011: NÚMEROS ENTEROS: SMALLINT, INTEGER, BIGINT =====
-- =====================================================================

-- =====================================================================
-- BLOQUE SETUP
-- =====================================================================
-- Selecciona TODO este bloque y ejecútalo como script (Alt+X).

DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

-- Tabla 1: estaciones meteorológicas (columnas enteras SMALLINT)
CREATE TABLE estaciones_meteo (
    id_estacion      SMALLINT,
    nombre           VARCHAR(30),   -- VARCHAR es texto (clase 013)
    altitud_m        SMALLINT,
    anio_instalacion SMALLINT
);

INSERT INTO estaciones_meteo (id_estacion, nombre, altitud_m, anio_instalacion) VALUES
(1, 'Laguna del Carbón', -105, 1990),
(2, 'Buenos Aires',        25, 1985),
(3, 'Rosario',             25, 1990),
(4, 'Lima',               154, 1985),
(5, 'Cusco',             3399, 1998),
(6, 'La Paz',            3640, 2001),
(7, 'Ushuaia',             14, 1990),
(8, 'Aconcagua',         6961, 2010);

-- Tabla 2: almacén de productos (SMALLINT e INTEGER)
CREATE TABLE almacen_productos (
    id_producto       INTEGER,
    nombre            VARCHAR(30),
    stock             SMALLINT,
    unidades_vendidas INTEGER
);

INSERT INTO almacen_productos (id_producto, nombre, stock, unidades_vendidas) VALUES
(1, 'Tornillo 6 mm',    32767, 2147483647),
(2, 'Clavo 2 pulgadas', 15000,     950000),
(3, 'Martillo',           120,      45300),
(4, 'Taladro',             35,      12800),
(5, 'Cinta métrica',      120,       8200),
(6, 'Guantes',              0,     560000),
(7, 'Casco',               -3,      31000),
(8, 'Escalera',             8,       8200);

-- Tabla 3: canal de videos (INTEGER y BIGINT)
CREATE TABLE canal_videos (
    id_video     INTEGER,
    titulo       VARCHAR(40),
    duracion_seg INTEGER,
    vistas       BIGINT
);

INSERT INTO canal_videos (id_video, titulo, duracion_seg, vistas) VALUES
(1, 'Tutorial de DBeaver',       1260,              85000),
(2, 'Instalar PostgreSQL',        840,            2100000),
(3, 'Canción del verano',         215,         4300000000),
(4, 'Receta de arepas',           600,         2147483648),
(5, 'Resumen del partido',        600,           95000000),
(6, 'Podcast de datos',          3600,              85000),
(7, 'Video viral',                 45,         9000000000),
(8, 'Documental de volcanes',    5400,              78000),
(9, 'Contador de prueba',          10, 9223372036854775807);

-- Comprobación rápida: debe mostrar las filas de la primera tabla.
SELECT * FROM estaciones_meteo;



-- =====================================================================
-- BLOQUE EJERCICIOS
-- =====================================================================
-- Escribe tus respuestas en comentarios (--) debajo de cada ejercicio.

-- ---------------------------------------------------------------------
-- EJERCICIOS BÁSICOS (3)
-- ---------------------------------------------------------------------

/* EJERCICIO 1
   Muestra todas las filas y todas las columnas de la tabla estaciones_meteo.
   Tabla: estaciones_meteo (id_estacion, nombre, altitud_m, anio_instalacion)
*/


/* EJERCICIO 2
   Muestra todas las filas y todas las columnas de la tabla almacen_productos.
   Tabla: almacen_productos (id_producto, nombre, stock, unidades_vendidas)
*/


/* EJERCICIO 3
   Muestra todo el contenido de la tabla canal_videos y escribe en un
   comentario cuántas filas devolvió (DBeaver lo indica en la parte inferior
   del panel de resultados).
   Tabla: canal_videos (id_video, titulo, duracion_seg, vistas)
*/


-- ---------------------------------------------------------------------
-- EJERCICIOS INTERMEDIOS (4)
-- ---------------------------------------------------------------------

/* EJERCICIO 4
   Escribe un script con las tres consultas SELECT * FROM (una por tabla).
   Antes de cada consulta, agrega un comentario con -- que diga qué tabla
   se consulta. Ejecuta el script completo con Alt+X y comprueba que
   aparecen tres pestañas de resultados.
   Tablas: estaciones_meteo (id_estacion, nombre, altitud_m, anio_instalacion)
           almacen_productos (id_producto, nombre, stock, unidades_vendidas)
           canal_videos (id_video, titulo, duracion_seg, vistas)
*/


/* EJERCICIO 5
   Desde el navegador de DBeaver (Database Navigator), abre las tablas
   almacen_productos y canal_videos. En la pestaña Properties > Columns,
   mira el tipo de dato. Escribe en un comentario el tipo (SMALLINT, INTEGER
   o BIGINT) de cada columna numérica de ambas tablas.
   Tablas: almacen_productos (id_producto, nombre, stock, unidades_vendidas)
           canal_videos (id_video, titulo, duracion_seg, vistas)
*/


/* EJERCICIO 6
   Consulta las tres tablas con SELECT * FROM. Luego, mirando los resultados,
   responde en comentarios:
   (a) ¿Qué valores de las tres tablas NO cabrían en una columna INTEGER?
   (b) ¿Qué columnas tienen al menos un valor que NO cabría en un SMALLINT?
   Tablas: estaciones_meteo (id_estacion, nombre, altitud_m, anio_instalacion)
           almacen_productos (id_producto, nombre, stock, unidades_vendidas)
           canal_videos (id_video, titulo, duracion_seg, vistas)
*/


/* EJERCICIO 7
   Crea un script de análisis con este orden:
   1) Un comentario de encabezado con /* */ que diga "Clase 011" y tu nombre.
   2) Las tres consultas SELECT * FROM, cada una precedida de un comentario --.
   3) Al final, un comentario que, para las columnas altitud_m,
      unidades_vendidas y vistas, indique: el valor máximo que ves en la
      tabla, el tipo más pequeño que alcanza HOY y el tipo que recomendarías
      para el FUTURO, con una frase de justificación.
   Ejecútalo con Alt+X.
   Tablas: estaciones_meteo (id_estacion, nombre, altitud_m, anio_instalacion)
           almacen_productos (id_producto, nombre, stock, unidades_vendidas)
           canal_videos (id_video, titulo, duracion_seg, vistas)
*/


-- ---------------------------------------------------------------------
-- POR QUÉ NO FUNCIONA (3)
-- ---------------------------------------------------------------------

/* EJERCICIO 8
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla: almacen_productos (id_producto, nombre, stock, unidades_vendidas)
*/
SELECT * almacen_productos;


/* EJERCICIO 9
   Camila quiere saber qué video del canal tiene más vistas. Ejecuta la
   consulta siguiente y concluye que el máximo es 2147483647.
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tablas: almacen_productos (id_producto, nombre, stock, unidades_vendidas)
           canal_videos (id_video, titulo, duracion_seg, vistas)
*/
SELECT * FROM almacen_productos;


/* EJERCICIO 10
   Un compañero afirma: "Dejemos la columna vistas del canal como INTEGER:
   2 mil millones de vistas es más que suficiente para cualquier video".
   Para respaldarlo usa la consulta siguiente.
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla: canal_videos (id_video, titulo, duracion_seg, vistas)
*/
SELECT * FROM canal_videos;