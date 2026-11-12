-- ===== CLASE 011: NOT NULL y DEFAULT =====

-- OBJETIVO: obligar a que una columna nunca quede vacía (NOT NULL) y definir
-- el valor que se guarda cuando no se especifica (DEFAULT).

-- CONCEPTO: NOT NULL es una restricción de columna que rechaza cualquier NULL;
-- DEFAULT es una expresión que PostgreSQL usa cuando la columna se omite al
-- cargar una fila. Son independientes: un DEFAULT no impide que alguien
-- inserte NULL explícito, y NOT NULL no aporta ningún valor por sí solo.

-- PARA QUÉ SIRVE (análisis de datos):
-- 1. Garantizar que las claves de negocio (documento, código, email) siempre
--    tengan valor, para que los cruces y conteos no pierdan filas.
-- 2. Evitar que columnas de estado (activo, entregado, nivel) queden en NULL y
--    rompan los filtros booleanos o los CASE WHEN posteriores.
-- 3. Ahorrar trabajo repetitivo en la carga: fecha de alta, país, moneda o
--    cantidad inicial se completan solos cuando no se indican.

-- SINTAXIS GENERAL
-- CREATE TABLE nombre_tabla (
--   columna  TIPO  [NOT NULL]  [DEFAULT valor]  [, ...]
-- );
--   NOT NULL        rechaza NULL en esa columna.
--   DEFAULT valor   valor que se usa si la columna no aparece en el INSERT.
-- El orden entre NOT NULL y DEFAULT es libre; ambos son opcionales.

-- EJEMPLO 1: lo mínimo
CREATE TABLE teoria_socios (
  id_socio   INTEGER      NOT NULL,
  nombre     VARCHAR(60)  NOT NULL,
  correo     VARCHAR(120),
  activo     BOOLEAN      NOT NULL DEFAULT TRUE,
  categoria  VARCHAR(20)  NOT NULL DEFAULT 'general',
  puntos     INTEGER      DEFAULT 0
);

-- Estructura resultante (pestaña Propiedades / DDL de DBeaver):
-- columna    | tipo         | admite NULL | default
-- -----------+--------------+-------------+-----------
-- id_socio   | integer      | no          | -
-- nombre     | varchar(60)  | no          | -
-- correo     | varchar(120) | sí          | -
-- activo     | boolean      | no          | true
-- categoria  | varchar(20)  | no          | 'general'
-- puntos     | integer      | sí          | 0

-- Lectura: correo puede quedar vacío; activo y categoria no, y si se omiten
-- toman TRUE y 'general'. puntos es opcional pero arranca en 0.

-- EJEMPLO 2: el orden de las palabras clave no importa
CREATE TABLE teoria_reservas (
  id_reserva  INTEGER       NOT NULL,
  fecha       DATE          NOT NULL DEFAULT '2025-01-01',
  personas    SMALLINT      DEFAULT 2 NOT NULL,
  salon       VARCHAR(30)   NOT NULL DEFAULT 'sin asignar',
  observacion TEXT
);

-- columna     | tipo        | admite NULL | default
-- ------------+-------------+-------------+--------------
-- id_reserva  | integer     | no          | -
-- fecha       | date        | no          | '2025-01-01'
-- personas    | smallint    | no          | 2
-- salon       | varchar(30) | no          | 'sin asignar'
-- observacion | text        | sí          | -

-- personas demuestra que DEFAULT puede escribirse antes o después de NOT NULL:
-- el efecto es el mismo (valor por defecto 2 y prohibido el NULL).

-- EJEMPLO 3: DEFAULT no es lo mismo que NOT NULL
CREATE TABLE teoria_notas (
  id_nota    INTEGER   NOT NULL,
  detalle    TEXT      DEFAULT 'sin detalle',
  prioridad  SMALLINT  DEFAULT 3 NOT NULL
);

-- En detalle: si la columna se omite se guarda 'sin detalle', pero si alguien
-- escribe NULL de forma explícita, se guarda NULL (la columna lo admite).
-- En prioridad: omitirla da 3, y un NULL explícito se rechaza con
-- "null value in column "prioridad" violates not-null constraint".
-- Moraleja: para blindar una columna hacen falta las dos cosas, o solo NOT NULL
-- si no quieres valor por defecto.

-- ERRORES Y BUENAS PRÁCTICAS
-- Error: escribir la restricción antes del tipo (nombre NOT NULL VARCHAR(50)) -> ERROR: syntax error at or near "VARCHAR"; el tipo debe ir primero.
-- Error: DEFAULT incompatible con el tipo (precio NUMERIC(8,2) DEFAULT 'gratis') -> ERROR: invalid input syntax for type numeric: "gratis".
-- Error silencioso: CHAR(5) DEFAULT 'pendiente' crea la tabla sin avisar, pero el valor queda truncado a 'pendi'.
-- Buena práctica: si el dato no se conoce, deja la columna nulable; un DEFAULT inventado ('sin correo', 0 en un sueldo) contamina promedios y conteos.
-- Buena práctica: declara NOT NULL en toda columna que uses en filtros, cálculos o claves de negocio, para que los NULL no aparezcan recién en el análisis.

-- ===== BLOQUE SETUP =====
-- Nota: CREATE TABLE e INSERT se explican en detalle más adelante (clases 010 y 021);
-- aquí solo preparan los datos de práctica.
DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

CREATE TABLE inventario_repuestos (
  id_repuesto     INTEGER PRIMARY KEY,
  nombre          VARCHAR(60) NOT NULL,
  categoria       VARCHAR(30),
  stock           INTEGER,
  precio_unitario NUMERIC(10,2),
  activo          BOOLEAN
);

INSERT INTO inventario_repuestos VALUES
(1, 'Filtro de aceite',       'motor',          40,  12.50, TRUE),
(2, 'Pastillas de freno',     'frenos',          0,  45.00, TRUE),
(3, 'Batería 12V',            'eléctrico',      15,  89.90, TRUE),
(4, 'Bomba de agua',          'motor',           7, 120.00, FALSE),
(5, 'Amortiguador',           'suspensión',   NULL,  65.00, TRUE),
(6, 'Bujía',                  'motor',         120,   4.25, TRUE),
(7, 'Radiador',               'refrigeración',   3,   NULL, TRUE),
(8, 'Espejo lateral',         'carrocería',   NULL,   NULL, FALSE),
(9, 'Correa de distribución', 'motor',          22,  35.75, TRUE);

CREATE TABLE envios_logistica (
  id_envio      INTEGER PRIMARY KEY,
  destino       VARCHAR(40) NOT NULL,
  transportista VARCHAR(30),
  peso_kg       NUMERIC(6,2),
  fecha_envio   DATE,
  entregado     BOOLEAN
);

INSERT INTO envios_logistica VALUES
(1, 'Rosario', 'Andes', 12.50, '2025-03-01', TRUE),
(2, 'Córdoba', 'Andes', 12.50, '2025-03-01', FALSE),
(3, 'Mendoza', NULL,     7.20, '2025-03-02', FALSE),
(4, 'La Plata','Sur',    3.00, '2025-03-02', TRUE),
(5, 'Salta',   'Norte', 25.00, '2025-03-03', TRUE),
(6, 'Rosario', 'Sur',    NULL, '2025-03-03', FALSE),
(7, 'Neuquén', 'Norte', 18.40, '2025-03-04', TRUE),
(8, 'Tucumán', NULL,     NULL, '2025-03-05', FALSE);

CREATE TABLE biblioteca_prestamos (
  id_prestamo   INTEGER PRIMARY KEY,
  socio         VARCHAR(40) NOT NULL,
  titulo        VARCHAR(60) NOT NULL,
  dias_prestamo INTEGER,
  devuelto      BOOLEAN
);

INSERT INTO biblioteca_prestamos VALUES
(1, 'Ana Ruiz',  'Rayuela',    15, TRUE),
(2, 'Luis Paz',  'Ficciones', NULL, FALSE),
(3, 'Ana Ruiz',  'El túnel',    7, TRUE),
(4, 'Marta Gil', 'Rayuela',    30, FALSE),
(5, 'Luis Paz',  'Bestiario',   7, TRUE),
(6, 'Sofía León','Ficciones', NULL, FALSE),
(7, 'Marta Gil', 'El túnel',   15, TRUE);

CREATE TABLE empleados_turnos (
  id_empleado INTEGER PRIMARY KEY,
  nombre      VARCHAR(40) NOT NULL,
  area        VARCHAR(20),
  turno       VARCHAR(15),
  salario     NUMERIC(10,2),
  bono        NUMERIC(10,2)
);

INSERT INTO empleados_turnos VALUES
(1, 'Carla Soto', 'logística',     'mañana', 850000,  NULL),
(2, 'Diego Ruiz', 'logística',     'tarde',  850000, 50000),
(3, 'Elena Paz',  'compras',       'mañana', 920000,  NULL),
(4, 'Fabián Mora','compras',       'noche',     NULL, 30000),
(5, 'Gloria Nin', 'logística',     'tarde',  780000, 50000),
(6, 'Hugo Paz',   'mantenimiento', 'mañana', 760000,  NULL),
(7, 'Irene Cruz', 'mantenimiento', NULL,     760000, 20000),
(8, 'Julián Vega','compras',       'noche',  990000,  NULL);

CREATE TABLE veterinaria_mascotas (
  id_mascota INTEGER PRIMARY KEY,
  nombre     VARCHAR(30) NOT NULL,
  especie    VARCHAR(20),
  edad       SMALLINT,
  peso_kg    NUMERIC(5,2),
  vacunado   BOOLEAN
);

INSERT INTO veterinaria_mascotas VALUES
(1, 'Rocky',  'perro',   5, 22.40, TRUE),
(2, 'Michi',  'gato', NULL,  4.10, TRUE),
(3, 'Luna',   'perro',   3, 18.00, FALSE),
(4, 'Nube',   'gato',    7,  NULL, TRUE),
(5, 'Toby',   'perro',   5, 22.40, TRUE),
(6, 'Kira',   'conejo',  2,  1.80, FALSE),
(7, 'Simba',  'gato', NULL,  NULL, FALSE),
(8, 'Canela', 'conejo',  2,  1.80, TRUE);

-- ===== BLOQUE EJERCICIOS =====
-- Nota: DROP TABLE se enseña en la clase 019. Si una tabla ya existe porque
-- repetiste la clase, bórrala desde el panel de DBeaver (clic derecho > Eliminar).

/* EJERCICIO 1 (básico)
   Crea la tabla soporte_tickets con estas columnas:
   soporte_tickets (id_ticket, asunto, descripcion, estado).
   id_ticket debe ser INTEGER obligatorio, asunto VARCHAR(80) obligatorio,
   descripcion TEXT que admita NULL y estado VARCHAR(15) obligatorio.
*/

/* EJERCICIO 2 (básico)
   Crea la tabla inventario_equipos con estas columnas:
   inventario_equipos (id_equipo, nombre, disponible, ubicacion, garantia_meses).
   id_equipo INTEGER obligatorio, nombre VARCHAR(50) obligatorio,
   disponible BOOLEAN con DEFAULT TRUE, ubicacion VARCHAR(30) con DEFAULT 'deposito'
   y garantia_meses SMALLINT con DEFAULT 12.
*/

/* EJERCICIO 3 (básico)
   Crea la tabla clientes_fidelidad con estas columnas:
   clientes_fidelidad (id_cliente, nombre, correo, puntos, nivel, activo).
   Combina en una misma tabla tres columnas NOT NULL (id_cliente, nombre, nivel)
   y tres columnas con DEFAULT (puntos 0, nivel 'bronce', activo TRUE).
   correo debe admitir NULL y no llevar DEFAULT.
*/

/* EJERCICIO 4 (intermedio)
   Combina tipos de datos (clases 004 a 009) con CREATE TABLE (010).
   Crea la tabla taller_ordenes con estas columnas:
   taller_ordenes (id_orden, descripcion, horas_trabajo, costo_repuestos, entregada, fecha_ingreso).
   Usa SMALLINT para id_orden, VARCHAR(80) para descripcion, NUMERIC(5,2) para horas_trabajo,
   NUMERIC(10,2) para costo_repuestos, BOOLEAN para entregada y DATE para fecha_ingreso.
   Decide qué columnas deben ser NOT NULL y cuáles llevan DEFAULT, y deja un comentario
   explicando por qué cada columna obligatoria lo es.
*/

/* EJERCICIO 5 (intermedio)
   Combina DEFAULT con la elección de tipos (004 a 009).
   Crea la tabla camping_reservas con estas columnas:
   camping_reservas (id_reserva, titular, parcela, personas, tarifa_diaria, pago_confirmado, fecha_ingreso).
   Asigna a cada columna un DEFAULT coherente con su tipo (un entero para personas,
   un decimal para tarifa_diaria, un texto para parcela, un booleano para pago_confirmado
   y una fecha literal para fecha_ingreso). Comenta por qué elegiste cada valor.
*/

/* EJERCICIO 6 (intermedio, mezcla 3 temas: tipos 004-009, NULL 009, CREATE TABLE 010)
   Crea la tabla farmacia_medicamentos con estas columnas:
   farmacia_medicamentos (id_medicamento, nombre, principio_activo, stock, precio, receta_obligatoria, vencimiento).
   Al menos dos columnas deben admitir NULL de forma deliberada (justifica por qué en un comentario)
   y al menos dos deben ser NOT NULL. Incluye un DEFAULT en una columna que sí admita NULL,
   para dejar claro que DEFAULT y NOT NULL son cosas distintas.
*/

/* EJERCICIO 7 (intermedio, mezcla 3 temas: tipos 004-009, NULL 009, CREATE TABLE 010 + interfaz de DBeaver)
   Crea la tabla cine_funciones con estas columnas:
   cine_funciones (id_funcion, pelicula, sala, butacas_totales, butacas_vendidas, precio_entrada, funcion_3d).
   Usa al menos tres tipos distintos, tres columnas NOT NULL y tres columnas con DEFAULT.
   Después abre la pestaña DDL (o Propiedades) de la tabla en DBeaver y verifica que cada
   restricción y cada default aparezcan tal como los declaraste.
*/

/* EJERCICIO 8
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla a crear: gimnasio_socios (id_socio, nombre, cuota, alta)
*/
CREATE TABLE gimnasio_socios (
  id_socio INTEGER,
  nombre   NOT NULL VARCHAR(50),
  cuota    NUMERIC(8,2) DEFAULT 0,
  alta     DATE DEFAULT '2025-01-01'
);

/* EJERCICIO 9
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla a crear: deposito_palets (id_palet, codigo, peso_kg)
*/
CREATE TABLE deposito_palets (
  id_palet INTEGER NOT NULL,
  codigo   CHAR(5) DEFAULT 'pendiente',
  peso_kg  NUMERIC(6,2)
);

/* EJERCICIO 10
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla a crear: nomina_empleados (id_empleado, nombre, correo, salario_base)
*/
CREATE TABLE nomina_empleados (
  id_empleado  INTEGER NOT NULL,
  nombre       VARCHAR(40) NOT NULL,
  correo       VARCHAR(120) NOT NULL DEFAULT 'sin-correo',
  salario_base NUMERIC(10,2) NOT NULL DEFAULT 0
);