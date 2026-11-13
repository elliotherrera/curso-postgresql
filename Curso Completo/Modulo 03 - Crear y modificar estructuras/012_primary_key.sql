-- ===== CLASE 012: PRIMARY KEY =====
--
-- OBJETIVO: declarar la clave primaria de una tabla para que cada fila quede identificada de forma única.
--
-- CONCEPTO: PRIMARY KEY es la restricción que marca la columna (o la combinación de columnas) que
-- identifica cada fila. Exige a la vez unicidad y ausencia de NULL, y PostgreSQL la hace cumplir con un
-- índice único interno llamado <tabla>_pkey. Una tabla puede tener una sola PRIMARY KEY, pero esa clave
-- puede estar formada por varias columnas (clave compuesta).
--
-- PARA QUÉ SIRVE (análisis de datos):
-- 1. Catálogo de artículos: el código de artículo evita filas duplicadas al cargar planillas externas.
-- 2. Registro de asistencia: la pareja (empleado, fecha) garantiza una sola marca por día y persona.
-- 3. Conciliación de pagos: el id de pago permite cruzar el sistema contable con el operativo sin contar dos veces.
--
-- SINTAXIS GENERAL
-- CREATE TABLE tabla (
--     columna   tipo PRIMARY KEY,                       -- clave de una sola columna
--     otra      tipo,
--     CONSTRAINT nombre_pk PRIMARY KEY (col1, col2)     -- clave compuesta y con nombre propio
-- );
--   PRIMARY KEY           -> restricción de unicidad + NOT NULL sobre las columnas indicadas
--   CONSTRAINT nombre_pk  -> le da un nombre legible; si se omite, PostgreSQL usa <tabla>_pkey
--
-- ---------------------------------------------------------------------------
-- EJEMPLO 1: clave de una columna
-- ---------------------------------------------------------------------------
-- CREATE TABLE clientes (
--     id_cliente INTEGER PRIMARY KEY,
--     nombre     VARCHAR(60) NOT NULL,
--     ciudad     VARCHAR(40)
-- );
--
-- Datos que tendría la tabla:
--  id_cliente |  nombre  |  ciudad
-- ------------+----------+-----------
--           1 | Ana      | Lima
--           2 | Beto     | Cusco
--           3 | Carla    | (NULL)
--
-- SELECT * FROM clientes;  devuelve exactamente esas 3 filas.
--
-- Si se intenta cargar otro id_cliente = 2:
--   ERROR: duplicate key value violates unique constraint "clientes_pkey"
-- Si se intenta cargar id_cliente sin valor:
--   ERROR: null value in column "id_cliente" violates not-null constraint
-- Es decir: la PRIMARY KEY ya rechaza NULL, aunque no se haya escrito NOT NULL en la columna.
-- La columna ciudad sí admite NULL porque no forma parte de la clave.
--
-- ---------------------------------------------------------------------------
-- EJEMPLO 2: clave compuesta
-- ---------------------------------------------------------------------------
-- CREATE TABLE inscripciones (
--     id_socio  INTEGER,
--     id_taller INTEGER,
--     CONSTRAINT pk_inscripciones PRIMARY KEY (id_socio, id_taller)
-- );
--
-- Datos válidos:
--  id_socio | id_taller
-- ----------+-----------
--         1 |        10
--         1 |        20
--         2 |        10
--
-- La pareja (1, 10) no puede repetirse, pero el socio 1 sí puede aparecer en varios talleres:
-- la unicidad se evalúa sobre la combinación, no sobre cada columna por separado.
-- Un segundo intento de (1, 10) produce:
--   ERROR: duplicate key value violates unique constraint "pk_inscripciones"
--
-- ---------------------------------------------------------------------------
-- EJEMPLO 3: clave con nombre sobre una sola columna
-- ---------------------------------------------------------------------------
-- CREATE TABLE salas (
--     codigo CHAR(3),
--     nombre VARCHAR(40) NOT NULL,
--     CONSTRAINT pk_salas PRIMARY KEY (codigo)
-- );
--
-- En DBeaver, al abrir la tabla en el editor (pestaña DDL o Propiedades) se ve que codigo quedó como
-- NOT NULL y que existe la restricción pk_salas. Nombrar la restricción ayuda cuando hay que leer
-- mensajes de error en cargas grandes: el nombre dice de inmediato qué regla se rompió.
--
-- ---------------------------------------------------------------------------
-- CUÁNDO CONVIENE CADA FORMA
-- ---------------------------------------------------------------------------
-- Clave de una columna: cuando existe un identificador estable y corto (id_cliente, codigo de sala).
-- Clave compuesta: cuando la fila solo tiene sentido como combinación (socio + taller, sala + fecha + turno).
-- Evita usar como clave datos que cambian o son largos (correo, teléfono, nombre completo): si el valor
-- se modifica, hay que actualizar la clave en todas partes.
--
-- ERRORES Y BUENAS PRÁCTICAS
-- - Dos PRIMARY KEY en la misma tabla -> "multiple primary keys for table ... are not allowed": la tabla admite una sola clave primaria.
-- - Repetir la misma columna dentro de la clave -> "column ... appears twice in primary key constraint": la lista de columnas debe ser distinta.
-- - Crear la tabla sin PRIMARY KEY no da error, pero después nada impide filas idénticas y los conteos dejan de ser confiables.
-- - Nombra la restricción (pk_<tabla>) cuando sea compuesta: los mensajes de error se vuelven legibles.
-- - Prefiere claves cortas, estables y sin significado de negocio; deja los datos mutables en columnas comunes.

-- ===== BLOQUE SETUP =====
-- Las sentencias CREATE TABLE e INSERT se explican más adelante en el curso; aquí solo preparan los datos.

DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

CREATE TABLE socios (
    id_socio INTEGER PRIMARY KEY,
    nombre   VARCHAR(60) NOT NULL,
    ciudad   VARCHAR(40),
    alta     DATE NOT NULL DEFAULT DATE '2023-01-01'
);

CREATE TABLE salas (
    codigo    CHAR(3) PRIMARY KEY,
    nombre    VARCHAR(40) NOT NULL,
    capacidad SMALLINT NOT NULL
);

CREATE TABLE inscripciones (
    id_socio  INTEGER,
    id_taller SMALLINT,
    fecha     DATE NOT NULL,
    CONSTRAINT pk_inscripciones PRIMARY KEY (id_socio, id_taller)
);

CREATE TABLE pagos (
    id_pago    INTEGER PRIMARY KEY,
    id_socio   INTEGER NOT NULL,
    monto      NUMERIC(10,2) NOT NULL,
    fecha_pago DATE
);

CREATE TABLE reservas (
    codigo_sala CHAR(3),
    fecha       DATE,
    turno       VARCHAR(10),
    plazas      SMALLINT NOT NULL DEFAULT 1,
    CONSTRAINT pk_reservas PRIMARY KEY (codigo_sala, fecha, turno)
);

INSERT INTO socios (id_socio, nombre, ciudad, alta) VALUES
(1, 'Ana',   'Lima',     DATE '2023-02-01'),
(2, 'Beto',  'Cusco',    DATE '2023-02-15'),
(3, 'Carla', NULL,       DATE '2023-03-01'),
(4, 'Diego', 'Lima',     DATE '2023-03-10'),
(5, 'Elena', 'Trujillo', DATE '2023-04-05'),
(6, 'Fabio', NULL,       DATE '2023-04-20'),
(7, 'Gina',  'Cusco',    DATE '2023-05-02'),
(8, 'Hugo',  'Lima',     DATE '2023-05-18');

INSERT INTO salas (codigo, nombre, capacidad) VALUES
('S1', 'Aula Norte',      20),
('S2', 'Aula Sur',        15),
('S3', 'Laboratorio',     12),
('S4', 'Taller de arte',  25),
('S5', 'Sala de musica',  18),
('S6', 'Auditorio',       60);

INSERT INTO inscripciones (id_socio, id_taller, fecha) VALUES
(1, 10, DATE '2023-06-01'),
(1, 20, DATE '2023-06-01'),
(2, 10, DATE '2023-06-02'),
(2, 30, DATE '2023-06-02'),
(3, 20, DATE '2023-06-03'),
(4, 10, DATE '2023-06-03'),
(4, 30, DATE '2023-06-05'),
(5, 20, DATE '2023-06-06'),
(7, 10, DATE '2023-06-07');

INSERT INTO pagos (id_pago, id_socio, monto, fecha_pago) VALUES
(1, 1, 150.00, DATE '2023-06-05'),
(2, 1, 150.00, DATE '2023-06-05'),
(3, 2,  99.90, NULL),
(4, 3, 200.00, DATE '2023-06-10'),
(5, 4,  99.90, DATE '2023-06-11'),
(6, 4,  75.50, NULL),
(7, 6, 120.00, DATE '2023-06-15'),
(8, 7, 120.00, DATE '2023-06-16');

INSERT INTO reservas (codigo_sala, fecha, turno, plazas) VALUES
('S1', DATE '2023-07-01', 'manana', 10),
('S1', DATE '2023-07-01', 'tarde',  12),
('S2', DATE '2023-07-01', 'manana',  8),
('S1', DATE '2023-07-02', 'manana', 10),
('S3', DATE '2023-07-02', 'tarde',   5),
('S5', DATE '2023-07-03', 'manana',  0),
('S6', DATE '2023-07-03', 'tarde',  40);

-- ===== BLOQUE EJERCICIOS =====

/* EJERCICIO 1 (básico)
   Crea la tabla proveedores con las columnas id_proveedor (entero, clave primaria),
   nombre (texto de hasta 80 caracteres, obligatorio) y pais (texto de hasta 40 caracteres).
   Después muestra todo su contenido.
   Tabla a crear: proveedores (id_proveedor, nombre, pais)
*/
CREATE TABLE proveedores (
    id_proveedor INTEGER PRIMARY KEY,
    nombre       VARCHAR(80) NOT NULL,
    pais         VARCHAR(40)
);

SELECT *
FROM proveedores;

/* EJERCICIO 2 (básico)
   Crea la tabla asistencias donde una marca se identifica por la pareja empleado + fecha.
   Usa una clave primaria compuesta llamada pk_asistencias.
   Luego muestra todo su contenido.
   Tabla a crear: asistencias (id_empleado, fecha, presente)
*/
CREATE TABLE asistencias (
    id_empleado INTEGER,
    fecha       DATE,
    presente    BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_asistencias PRIMARY KEY (id_empleado, fecha)
);

SELECT *
FROM asistencias;

/* EJERCICIO 3 (básico)
   Crea la tabla sedes con id_sede como clave primaria declarada mediante una restricción
   con nombre propio (pk_sedes), nombre obligatorio y fecha de apertura obligatoria cuyo valor
   por defecto sea el 1 de enero de 2024.
   Muestra después todo su contenido.
   Tabla a crear: sedes (id_sede, nombre, apertura)
*/
CREATE TABLE sedes (
    id_sede  INTEGER,
    nombre   VARCHAR(50) NOT NULL,
    apertura DATE NOT NULL DEFAULT DATE '2024-01-01',
    CONSTRAINT pk_sedes PRIMARY KEY (id_sede)
);

SELECT *
FROM sedes;

/* EJERCICIO 4 (intermedio)
   Diseña la tabla envios con: id_envio entero como clave primaria, destino obligatorio de hasta
   60 caracteres, peso con dos decimales y hasta 8 dígitos en total (obligatorio), fecha_envio de
   tipo DATE y entregado de tipo booleano que por defecto sea FALSE.
   Verifica la estructura creada mostrando todas sus filas.
   Tabla a crear: envios (id_envio, destino, peso, fecha_envio, entregado)
*/
CREATE TABLE envios (
    id_envio    INTEGER PRIMARY KEY,
    destino     VARCHAR(60) NOT NULL,
    peso        NUMERIC(8,2) NOT NULL,
    fecha_envio DATE,
    entregado   BOOLEAN NOT NULL DEFAULT FALSE
);

SELECT *
FROM envios;

/* EJERCICIO 5 (intermedio)
   Crea la tabla matriculas cuya clave primaria sea la combinación de tres columnas:
   id_alumno (entero), codigo_curso (texto fijo de 6 caracteres) y periodo (fecha).
   Agrega la columna nota de tipo NUMERIC(4,2), sin obligación de tener valor, y la columna
   estado de hasta 15 caracteres obligatoria con valor por defecto 'inscrito'.
   Nombra la restricción pk_matriculas y muestra el contenido de la tabla.
   Tabla a crear: matriculas (id_alumno, codigo_curso, periodo, nota, estado)
*/
CREATE TABLE matriculas (
    id_alumno    INTEGER,
    codigo_curso CHAR(6),
    periodo      DATE,
    nota         NUMERIC(4,2),
    estado       VARCHAR(15) NOT NULL DEFAULT 'inscrito',
    CONSTRAINT pk_matriculas PRIMARY KEY (id_alumno, codigo_curso, periodo)
);

SELECT *
FROM matriculas;

/* EJERCICIO 6 (intermedio)
   Crea dos tablas: paises, cuya clave primaria sea el codigo de tipo CHAR(2), con nombre
   obligatorio de hasta 50 caracteres; y ciudades, con id_ciudad entero como clave primaria,
   codigo_pais CHAR(2) obligatorio y nombre de hasta 60 caracteres obligatorio.
   Muestra el contenido de ambas tablas.
   Tablas a crear: paises (codigo, nombre) y ciudades (id_ciudad, codigo_pais, nombre)
*/
CREATE TABLE paises (
    codigo CHAR(2) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE ciudades (
    id_ciudad   INTEGER PRIMARY KEY,
    codigo_pais CHAR(2) NOT NULL,
    nombre      VARCHAR(60) NOT NULL
);

SELECT *
FROM paises;

SELECT *
FROM ciudades;

/* EJERCICIO 7 (intermedio)
   Crea la tabla inventario con id_articulo entero como clave primaria, descripcion de hasta
   100 caracteres obligatoria, stock de tipo SMALLINT obligatorio que por defecto valga 0,
   precio NUMERIC(10,2) obligatorio y activo booleano obligatorio que por defecto sea TRUE.
   Después muestra todas las columnas de la tabla en el orden en que quedaron definidas.
   Tabla a crear: inventario (id_articulo, descripcion, stock, precio, activo)
*/
CREATE TABLE inventario (
    id_articulo INTEGER PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    stock       SMALLINT NOT NULL DEFAULT 0,
    precio      NUMERIC(10,2) NOT NULL,
    activo      BOOLEAN NOT NULL DEFAULT TRUE
);

SELECT *
FROM inventario;

/* EJERCICIO 8
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla: turnos (id_turno, id_empleado, hora_inicio)
*/
CREATE TABLE turnos (
    id_turno    INTEGER PRIMARY KEY,
    id_empleado INTEGER PRIMARY KEY,
    hora_inicio TIME NOT NULL
);

/* EJERCICIO 9
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Se busca que cada sucursal tenga su propio identificador y que una misma empresa pueda
   tener varias sucursales.
   Tabla: sucursales (id_sucursal, id_empresa, nombre)
*/
CREATE TABLE sucursales (
    id_sucursal INTEGER NOT NULL,
    id_empresa  INTEGER PRIMARY KEY,
    nombre      VARCHAR(60) NOT NULL
);

/* EJERCICIO 10
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla: cuentas (id_cuenta, email, fecha_alta)
*/
CREATE TABLE cuentas (
    id_cuenta  INTEGER NOT NULL,
    email      VARCHAR(120) PRIMARY KEY,
    fecha_alta DATE NOT NULL DEFAULT DATE '2024-01-01'
);