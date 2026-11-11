-- ===== CLASE 008: FECHAS Y HORAS: DATE, TIME, TIMESTAMP, TIMESTAMPTZ =====
--
-- Objetivo: distinguir cuándo guardar solo una fecha, solo una hora, una fecha con hora sin zona y un instante con zona horaria.
--
-- Concepto: PostgreSQL separa la fecha, la hora y el instante. DATE guarda año, mes y día; TIME guarda una hora del día; TIMESTAMP guarda fecha y hora sin información de zona; TIMESTAMPTZ guarda un instante absoluto y lo normaliza internamente a UTC. Elegir mal el tipo hace que se pierdan datos o que dos eventos parezcan distintos cuando ocurrieron al mismo tiempo.
--
-- Para qué sirve:
-- 1. Registrar eventos con fecha y hora local, como ferias o conciertos.
-- 2. Guardar vuelos, sensores o transacciones que ocurren en distintas zonas horarias.
-- 3. Modelar turnos de trabajo, nacimientos o entregas donde importa el día y la hora por separado.
--
-- Sintaxis general:
-- DATE 'YYYY-MM-DD'                  -- año, mes y día
-- TIME 'HH:MI:SS'                    -- hora del día, hasta 24:00:00
-- TIMESTAMP 'YYYY-MM-DD HH:MI:SS'    -- fecha y hora sin zona horaria
-- TIMESTAMPTZ 'YYYY-MM-DD HH:MI:SS+HH' -- fecha, hora y offset respecto a UTC
--
-- DATE no incluye hora. TIME no incluye fecha. TIMESTAMP no sabe en qué zona se registró. TIMESTAMPTZ sí conserva el instante: si guardas 10:00+01 y 04:00-05, ambos son las 09:00 UTC y representan el mismo momento. Los rangos son amplios: DATE admite valores como 'infinity'; TIME llega hasta '24:00:00'; TIMESTAMP y TIMESTAMPTZ admiten fechas lejanas y también 'infinity'.
--
-- Ejemplo 1: cada tipo guarda una parte distinta del tiempo.
SELECT
    DATE '2024-03-15' AS solo_fecha,
    TIME '14:30:00' AS solo_hora,
    TIMESTAMP '2024-03-15 14:30:00' AS fecha_y_hora,
    TIMESTAMPTZ '2024-03-15 14:30:00+00' AS fecha_hora_con_zona;
-- Resultado:
-- solo_fecha | solo_hora | fecha_y_hora        | fecha_hora_con_zona
-- 2024-03-15 | 14:30:00  | 2024-03-15 14:30:00 | 2024-03-15 14:30:00+00
-- La última columna puede mostrarse con otro offset si tu sesión usa otra zona horaria, pero el instante es el mismo.
--
-- Ejemplo 2: límites y valores especiales.
SELECT
    DATE 'infinity' AS fecha_infinita,
    TIME '24:00:00' AS fin_del_dia,
    DATE '2024-02-29' AS bisiesto;
-- Resultado:
-- fecha_infinita | fin_del_dia | bisiesto
-- infinity       | 24:00:00    | 2024-02-29
--
-- Ejemplo 3: una fecha inexistente no se puede guardar.
-- SELECT DATE '2023-02-29';
-- ERROR: date/time field value out of range: "2023-02-29"
--
-- Ejemplo 4: TIMESTAMPTZ conserva el instante aunque cambie el offset.
SELECT
    TIMESTAMPTZ '2024-03-15 10:00:00+01' AS madrid,
    TIMESTAMPTZ '2024-03-15 04:00:00-05' AS bogota;
-- Ambas columnas representan las 09:00 UTC. El visualizador puede mostrarlas con el mismo offset.
--
-- Errores y buenas prácticas:
-- - Error: escribir DATE '2023-02-29'. Mensaje típico: date/time field value out of range. Causa: esa fecha no existe.
-- - Error: usar TIME para una duración de 30 horas. TIME solo llega a 24:00:00; no representa duraciones.
-- - Error silencioso: guardar fechas como VARCHAR y aceptar '31/02/2024' sin validación. La base no corrige el error.
-- - Buena práctica: usar DATE para fechas sin hora y TIMESTAMPTZ para eventos que ocurren en un instante global.
-- - Buena práctica: no confiar en la zona horaria del servidor; si el dato es un instante, usar TIMESTAMPTZ.

-- ===== BLOQUE SETUP =====
-- El SETUP usa CREATE TABLE e INSERT; se explicarán en clases posteriores.
DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

CREATE TABLE eventos (
    id_evento INTEGER,
    nombre VARCHAR(40),
    fecha_evento DATE,
    hora_inicio TIME,
    creado TIMESTAMP,
    actualizado TIMESTAMPTZ
);

INSERT INTO eventos (id_evento, nombre, fecha_evento, hora_inicio, creado, actualizado)
VALUES
    (1, 'Feria', DATE '2024-03-15', TIME '09:00:00', TIMESTAMP '2024-01-10 08:30:00', TIMESTAMPTZ '2024-02-01 10:00:00+00'),
    (2, 'Concierto', DATE '2024-07-20', TIME '20:30:00', TIMESTAMP '2024-02-15 12:00:00', TIMESTAMPTZ '2024-03-01 09:15:00-05'),
    (3, 'Taller', DATE '2024-11-05', TIME '14:00:00', TIMESTAMP '2024-03-20 15:45:00', TIMESTAMPTZ '2024-04-01 16:00:00+02'),
    (4, 'Exposición', DATE 'infinity', TIME '10:00:00', TIMESTAMP '2024-04-05 09:00:00', TIMESTAMPTZ '2024-05-01 11:30:00+00'),
    (5, 'Charla', DATE '2024-05-10', TIME '24:00:00', TIMESTAMP '2024-05-01 18:00:00', TIMESTAMPTZ '2024-05-02 08:00:00-03'),
    (6, 'Cine', DATE '2024-08-01', NULL, TIMESTAMP '2024-05-10 20:00:00', NULL),
    (7, 'Teatro', DATE '2024-09-12', TIME '19:15:00', NULL, TIMESTAMPTZ '2024-06-01 12:00:00+00'),
    (8, 'Danza', DATE '2024-12-31', TIME '23:59:59', TIMESTAMP '2024-06-15 07:30:00', TIMESTAMPTZ '2024-06-15 07:30:00+00'),
    (9, 'Música', DATE '2025-01-01', TIME '00:00:00', TIMESTAMP '2024-07-01 00:00:00', TIMESTAMPTZ '2024-07-01 00:00:00+00');

CREATE TABLE vuelos (
    id_vuelo INTEGER,
    origen VARCHAR(3),
    destino VARCHAR(3),
    salida TIMESTAMPTZ,
    llegada TIMESTAMPTZ,
    estado VARCHAR(10)
);

INSERT INTO vuelos (id_vuelo, origen, destino, salida, llegada, estado)
VALUES
    (1, 'MAD', 'BOG', TIMESTAMPTZ '2024-03-15 10:00:00+01', TIMESTAMPTZ '2024-03-15 15:30:00-05', 'programado'),
    (2, 'BOG', 'MAD', TIMESTAMPTZ '2024-03-16 18:00:00-05', TIMESTAMPTZ '2024-03-17 10:00:00+01', 'programado'),
    (3, 'MEX', 'LIM', TIMESTAMPTZ '2024-03-15 08:00:00-06', TIMESTAMPTZ '2024-03-15 15:00:00-05', 'retrasado'),
    (4, 'LIM', 'MEX', TIMESTAMPTZ '2024-03-15 23:00:00-05', TIMESTAMPTZ '2024-03-16 04:00:00-06', 'programado'),
    (5, 'EZE', 'SCL', TIMESTAMPTZ '2024-03-16 01:30:00-03', TIMESTAMPTZ '2024-03-16 03:00:00-03', 'cancelado'),
    (6, 'SCL', 'EZE', TIMESTAMPTZ '2024-03-16 05:00:00-03', TIMESTAMPTZ '2024-03-16 06:45:00-03', NULL),
    (7, 'BOG', 'MEX', TIMESTAMPTZ '2024-03-17 00:30:00-05', TIMESTAMPTZ '2024-03-17 04:00:00-06', 'programado'),
    (8, 'MAD', 'LIM', TIMESTAMPTZ '2024-03-18 12:00:00+01', TIMESTAMPTZ '2024-03-18 18:00:00-05', 'programado'),
    (9, 'MEX', 'MAD', TIMESTAMPTZ '2024-03-19 07:00:00-06', TIMESTAMPTZ '2024-03-20 02:00:00+01', 'programado');

CREATE TABLE turnos (
    id_turno INTEGER,
    empleado VARCHAR(30),
    fecha DATE,
    entrada TIME,
    salida TIME
);

INSERT INTO turnos (id_turno, empleado, fecha, entrada, salida)
VALUES
    (1, 'Ana', DATE '2024-03-01', TIME '08:00:00', TIME '16:00:00'),
    (2, 'Luis', DATE '2024-03-01', TIME '16:00:00', TIME '24:00:00'),
    (3, 'Marta', DATE '2024-03-02', TIME '00:00:00', TIME '08:00:00'),
    (4, 'Pedro', DATE '2024-03-02', TIME '22:00:00', TIME '06:00:00'),
    (5, 'Ana', DATE '2024-03-03', TIME '08:00:00', NULL),
    (6, 'Luis', DATE '2024-03-03', NULL, TIME '16:00:00'),
    (7, 'Marta', DATE '2024-03-04', TIME '12:00:00', TIME '12:00:00'),
    (8, 'Pedro', DATE '2024-03-05', TIME '23:59:59', TIME '00:00:00');

CREATE TABLE sensores (
    id_registro INTEGER,
    sensor VARCHAR(10),
    marca_tiempo TIMESTAMPTZ,
    valor NUMERIC(6,2)
);

INSERT INTO sensores (id_registro, sensor, marca_tiempo, valor)
VALUES
    (1, 'S01', TIMESTAMPTZ '2024-03-15 00:00:00+00', 12.50),
    (2, 'S01', TIMESTAMPTZ '2024-03-15 06:00:00+00', 13.00),
    (3, 'S02', TIMESTAMPTZ '2024-03-15 00:00:00-05', 20.10),
    (4, 'S02', TIMESTAMPTZ '2024-03-15 06:00:00-05', 19.80),
    (5, 'S03', TIMESTAMPTZ '2024-03-15 12:00:00+02', NULL),
    (6, 'S03', TIMESTAMPTZ '2024-03-15 18:00:00+02', 22.40),
    (7, 'S01', TIMESTAMPTZ '2024-03-16 00:00:00+00', 11.90),
    (8, 'S02', TIMESTAMPTZ '2024-03-16 00:00:00-05', 20.50);

CREATE TABLE personas (
    id_persona INTEGER,
    nombre VARCHAR(30),
    fecha_nacimiento DATE,
    hora_nacimiento TIME,
    alta TIMESTAMP
);

INSERT INTO personas (id_persona, nombre, fecha_nacimiento, hora_nacimiento, alta)
VALUES
    (1, 'Ana', DATE '1990-05-12', TIME '08:30:00', TIMESTAMP '2024-01-01 10:00:00'),
    (2, 'Luis', DATE '1985-11-30', TIME '23:45:00', TIMESTAMP '2024-01-02 11:30:00'),
    (3, 'Marta', DATE '2000-02-29', TIME '12:00:00', TIMESTAMP '2024-02-29 12:00:00'),
    (4, 'Pedro', DATE '1978-07-04', NULL, TIMESTAMP '2024-03-01 09:00:00'),
    (5, 'Sofía', DATE '2010-10-10', TIME '00:00:00', TIMESTAMP '2024-03-02 14:00:00'),
    (6, 'Diego', NULL, TIME '18:00:00', TIMESTAMP '2024-03-03 16:00:00'),
    (7, 'Elena', DATE '1999-12-31', TIME '23:59:59', TIMESTAMP '2024-03-04 08:00:00'),
    (8, 'Raúl', DATE '2024-01-01', TIME '24:00:00', TIMESTAMP '2024-03-05 10:00:00');

-- ===== PRÁCTICA GUIADA EN DBEAVER =====
-- Completa cada paso en el editor SQL de DBeaver. Ejecuta una consulta a la vez.
-- No necesitas escribir WHERE ni funciones: solo observa los valores y razona sobre los tipos.
--
-- CHECKLIST:
-- [✔️] 1. Ejecuta SELECT * FROM eventos. Observa fecha_evento, hora_inicio, creado y actualizado.
--         Anota en un comentario qué tipo le asignarías a cada columna y por qué.
--         Fíjate en 'infinity' en fecha_evento y en '24:00:00' en hora_inicio.
--		   RPTA: fecha_evento DATE porque solo muestra fecha,
--		   		 hora_inicio TIME porque solo muestra hora,
--		   		 creado TIMESTAMP porque muestra fecha y hora,
--		   		 actualizado TIMESTAMPZ porque muestra fecha, hora y zona horaria UTC
--
-- [✔️] 2. Ejecuta SELECT * FROM vuelos. Observa salida y llegada con offsets +01, -05, -06, -03.
--         Pregúntate qué tipo usarías para que el instante no se pierda al cambiar de zona horaria.
--		   RPTA: Utilizaria TIMESTAMPZ
--
-- [✔️] 3. Ejecuta SELECT * FROM turnos. Observa entrada y salida.
--         ¿Qué pasa con el turno que cruza medianoche? ¿TIME alcanza para representar una duración?
--		   RPTA: No alcanza porque TIME solo acepta hasta 24:00:00, para casos como estos utilizaria formato TIMESTAMP
--
-- [✔️] 4. Ejecuta SELECT * FROM sensores. Observa marca_tiempo.
--         ¿Qué diferencia hay entre los registros con +00, -05 y +02?
--		   RPTA: Esos registros se toman desde diferentes zonas, pero el offset ingresado les da el valor absoluto
--
-- [✔️] 5. Ejecuta SELECT * FROM personas. Observa fecha_nacimiento, hora_nacimiento y alta.
--         Identifica el 29 de febrero, el 24:00:00 y los NULL.
--         RPTA: 29 de febrero solo es valido en año bisiesto, 24:00:00 es el equivalente a 00:00:00 del dia siguiente, NULL significa desconocido


-- ===== PREGUNTAS DE COMPRENSIÓN =====
/*
PREGUNTA 1
En la tabla vuelos, salida y llegada usan TIMESTAMPTZ. ¿Qué diferencia habría si se hubieran declarado como TIMESTAMP?
Explica qué ocurre con un vuelo que sale de Madrid y llega a Bogotá.
RPTA: con TIMESTAMP las horas no son absolutas, un vuelo de Madrid a Bogota dura alrededor de 8 horas y la diferencia horaria entre esos 2 paises es de 6 horas. con TIMESTAMP se registraria como un vuelo de solo 2 horas y compromete tambien fecha y hora.

PREGUNTA 2
En la tabla eventos, fecha_evento contiene 'infinity' y hora_inicio contiene '24:00:00'.
¿Qué tipo le asignarías a cada columna? ¿Por qué no usar VARCHAR para ambas?
RPTA: para fecha_evento uso DATE y para hora_inicio TIME. Guartdarlo como VARCHAR puede aceptar un error, ademas infinity lo tomaria como un texto plano quitandole la utilidad real.

PREGUNTA 3
En la tabla personas, fecha_nacimiento es DATE y hora_nacimiento es TIME.
¿Qué pasaría si fecha_nacimiento se declarara como TIME? ¿Y si se declarara como TIMESTAMP?
RPTA: si fecha_nacimiento fuera TIME habria un error de tipo YY-MM-DD, y si se guarda como TIMESTAMP la hora seria 00:00:00 para todas pero se puede juntar ambas columnas y hacer una sola con TIMESTAMP fecha_nacimiento + hora_nacimiento a fecha_y_hora_nacimiento
*/


