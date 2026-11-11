-- ===== CLASE 009: NULL: QUÉ ES Y CÓMO SE COMPORTA =====
--
-- OBJETIVO: entender qué es NULL, por qué no es un valor común y cómo afecta
-- las comparaciones y los cálculos antes de aprender a filtrarlo (clase 038).
--
-- CONCEPTO: NULL no es cero, ni texto vacío, ni FALSE: es la ausencia de dato
-- o un dato desconocido. Por eso cualquier operación en la que participa
-- devuelve NULL, y la lógica deja de tener dos valores para tener tres:
-- verdadero, falso y desconocido.
--
-- PARA QUÉ SIRVE EN ANÁLISIS DE DATOS:
-- 1. Representar campos opcionales: un bono que no se otorgó, una fecha de
--    entrega que todavía no ocurrió, un teléfono que el cliente no dio.
-- 2. Distinguir "no aplica" de "vale cero": una precipitación de 0.0 mm es un
--    dato medido; NULL significa "no se midió".
-- 3. Evitar conclusiones falsas: promedios, sumas y conteos tratan los NULL
--    de forma especial y pueden cambiar el resultado de un reporte.
--
-- SINTAXIS GENERAL:
-- NULL                 literal que representa el dato ausente.
-- columna = NULL       comparación incorrecta: siempre devuelve NULL.
-- columna IS NULL      forma correcta de preguntar si falta el dato (clase 038).
-- columna IS NOT NULL  forma correcta de preguntar si el dato existe.
-- NULL en un INSERT    deja la columna sin valor (o aplica el DEFAULT, clase 011).
--
-- En DBeaver las celdas con NULL se muestran como (null) en color gris. Ese
-- texto NO es la cadena 'null': es la representación visual de la ausencia
-- de dato.

-- EJEMPLO 1: NULL nunca es igual a nada, ni siquiera a otro NULL.
SELECT
    NULL = NULL AS r_igual,
    NULL <> NULL AS r_distinto,
    10 = NULL AS r_numero;

-- Resultado:
--  r_igual | r_distinto | r_numero
-- ---------+------------+----------
--  (null)  |   (null)   |  (null)
--
-- La comparación no puede responder "verdadero" ni "falso": el dato falta,
-- así que la respuesta es "desconocido", que se representa con NULL.

-- EJEMPLO 2: NULL contamina la aritmética y la concatenación.
SELECT
    NULL + 5 AS suma,
    NULL * 0 AS producto,
    'Total: ' || NULL AS texto;

-- Resultado:
--  suma  | producto | texto
-- -------+----------+--------
-- (null) |  (null)  | (null)
--
-- Multiplicar NULL por 0 no da 0: si el valor es desconocido, el resultado
-- también lo es. Pegar texto a un NULL tampoco produce texto.

-- EJEMPLO 3: lógica de tres valores. La siguiente tabla muestra el resultado
-- de combinar TRUE, FALSE y NULL con AND, OR y NOT:
--
--   TRUE  AND NULL -> NULL      TRUE  OR NULL -> TRUE
--   FALSE AND NULL -> FALSE     FALSE OR NULL -> NULL
--   NULL  AND NULL -> NULL      NULL  OR NULL -> NULL
--   NOT NULL       -> NULL
--
-- Solo hay un caso en el que un NULL no contagia el resultado: FALSE AND NULL
-- es FALSE (porque el resultado ya era falso sin importar el otro lado) y
-- TRUE OR NULL es TRUE (porque el resultado ya era verdadero).

-- EJEMPLO 4: NULL dentro de una tabla. Se observa la diferencia entre un
-- dato ausente y un cero real.
SELECT *
FROM (VALUES
    (1, 'Ana',  2500.00),
    (2, 'Luis', NULL),
    (3, 'Eva',  0.00)
) AS empleados(id_empleado, nombre, comision);

-- Resultado:
--  id_empleado | nombre | comision
-- -------------+--------+----------
--            1 | Ana    |  2500.00
--            2 | Luis   |   (null)
--            3 | Eva    |     0.00
--
-- Ana cobra comisión, Eva cobra comisión cero y de Luis no se sabe: son tres
-- situaciones distintas. Más adelante verás que las funciones de agregación
-- (clases 049 a 051) ignoran los NULL al calcular, y que una PRIMARY KEY no
-- admite NULL (clase 012) mientras que UNIQUE sí admite varios (clase 014).
--
-- ERRORES FRECUENTES Y BUENAS PRÁCTICAS:
-- - Filtrar con WHERE columna = NULL: no da error, devuelve 0 filas, porque
--   la comparación produce NULL y no TRUE; se corrige con IS NULL (clase 038).
-- - Asumir que NULL es 0: un AVG ignora los NULL y el promedio calculado no
--   representa a toda la plantilla; hay que decidir cómo tratarlos.
-- - Guardar '' (cadena vacía) como "sin dato": el dato existe y no es NULL,
--   así que filtros y cálculos lo tratarán de forma distinta a un NULL real.
-- - Documentar qué significa NULL en cada columna: "desconocido" no es lo
--   mismo que "no aplica" y el reporte puede leerse de dos maneras.
-- - Declarar NOT NULL con DEFAULT desde el diseño (clases 011 y 015) cuando
--   el dato es obligatorio, en lugar de confiar en que nadie lo deje vacío.

-- ============================================================
-- BLOQUE SETUP
-- (CREATE TABLE e INSERT se explican más adelante; por ahora
-- solo ejecútalos para tener datos con los que observar.)
-- ============================================================
DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

CREATE TABLE empleados (
    id_empleado INTEGER,
    nombre VARCHAR(40),
    area VARCHAR(20),
    salario NUMERIC(10,2),
    bono NUMERIC(10,2)
);

INSERT INTO empleados VALUES
(1, 'Ana Torres',  'Ventas',    2500.00, 300.00),
(2, 'Luis Paredes','Ventas',    2500.00, NULL),
(3, 'Eva Ríos',    'Compras',   3100.00, 0.00),
(4, 'Mario Salas', 'Compras',   3100.00, NULL),
(5, 'Rita Cano',   'Logística', 2100.00, 150.00),
(6, 'Iván Mora',   'Logística', 2100.00, NULL),
(7, 'Sofía Lema',  'Ventas',    2500.00, 0.00),
(8, 'Diego Paz',   NULL,        1800.00, NULL);

CREATE TABLE envios (
    id_envio INTEGER,
    destino VARCHAR(30),
    peso_kg NUMERIC(6,2),
    fecha_entrega DATE,
    costo NUMERIC(10,2)
);

INSERT INTO envios VALUES
(1, 'Quito',     12.50, DATE '2024-03-01', 45.00),
(2, 'Guayaquil',  8.00, DATE '2024-03-02', NULL),
(3, 'Cuenca',     NULL, DATE '2024-03-04', 30.00),
(4, 'Loja',       0.00, NULL,               0.00),
(5, 'Ambato',    25.00, NULL,              NULL),
(6, 'Quito',     12.50, DATE '2024-03-01', 45.00),
(7, 'Manta',      3.75, DATE '2024-03-05', 18.50),
(8, 'Cuenca',     NULL, NULL,              NULL);

CREATE TABLE lecturas_clima (
    id_lectura INTEGER,
    ciudad VARCHAR(30),
    temperatura NUMERIC(4,1),
    humedad SMALLINT,
    precipitacion NUMERIC(5,1)
);

INSERT INTO lecturas_clima VALUES
(1, 'Quito',      14.5, 78,   0.0),
(2, 'Quito',      15.0, NULL, 2.5),
(3, 'Guayaquil',  28.3, 85,   0.0),
(4, 'Guayaquil',  NULL, 90,   NULL),
(5, 'Cuenca',     12.0, NULL, 0.0),
(6, 'Cuenca',     11.5, 70,   5.2),
(7, 'Loja',       16.8, NULL, NULL),
(8, 'Loja',       16.8, 65,   0.0);

CREATE TABLE clientes (
    id_cliente INTEGER,
    nombre VARCHAR(40),
    correo VARCHAR(60),
    telefono VARCHAR(15)
);

INSERT INTO clientes VALUES
(1, 'Ana Torres',   'ana@mail.com',  '0991112222'),
(2, 'Luis Paredes', '',              NULL),
(3, 'Eva Ríos',     NULL,            '0993334444'),
(4, 'Mario Salas',  'mario@mail.com', NULL),
(5, 'Rita Cano',    NULL,            NULL),
(6, 'Iván Mora',    '',              '0995556666'),
(7, 'Sofía Lema',   'sofia@mail.com','0997778888'),
(8, 'Diego Paz',    'diego@mail.com', NULL);

-- ============================================================
-- BLOQUE PRÁCTICA GUIADA (DBeaver)
-- Marca cada paso a medida que lo completas.
-- ============================================================
/*
CHECKLIST
[ ] 1. Abre DBeaver, conecta la base y abre una hoja de editor SQL nueva.
[ ] 2. Ejecuta el bloque SETUP completo (selecciónalo y usa Ctrl+Enter).
[ ] 3. Revisa la pestaña de mensajes: deben aparecer cuatro CREATE TABLE y
       cuatro INSERT sin error.
[ ] 4. En el panel de navegación, actualiza el esquema practica y confirma
       que existen las tablas empleados, envios, lecturas_clima y clientes.
[ ] 5. Ejecuta:  SELECT * FROM empleados;
       Observa cuántas filas hay y qué celdas aparecen como (null).
[ ] 6. Repite el paso 5 con envios, lecturas_clima y clientes, una por una.
[ ] 7. En comentarios debajo de cada consulta, anota qué columnas tienen
       NULL, cuántas filas afectan y qué significa ese NULL en el negocio.
[ ] 8. Compara casos que se parecen pero no son iguales:
       - empleados.bono: NULL (no se sabe) frente a 0.00 (bono cero).
       - envios.peso_kg: NULL (no se pesó) frente a 0.00 (peso cero).
       - lecturas_clima.precipitacion: NULL (no se midió) frente a 0.0 mm.
       - clientes.correo: NULL, '' (cadena vacía) y una dirección real.
[ ] 9. Repaso de tipos (clases 004 a 008): para cada columna de las cuatro
       tablas, anota en un comentario qué tipo le asignarías y por qué.
       Fíjate en salario NUMERIC(10,2) frente a humedad SMALLINT, y en
       temperatura NUMERIC(4,1) frente a peso_kg NUMERIC(6,2). Pregúntate
       qué pasaría si eligieras un tipo más chico o entero para salario.
[ ] 10. Guarda el script en tu equipo con un nombre como clase_009.sql.
*/

/*
PREGUNTAS DE COMPRENSIÓN (responde en comentarios)
1. ¿Por qué NULL = NULL no devuelve TRUE? ¿Qué devuelve exactamente y qué
   implica eso para cualquier filtro que escribas más adelante?
2. En empleados, la columna bono tiene NULL y 0.00. ¿Qué diferencia hay entre
   ambos para el negocio? ¿Cuál usarías para "no recibió bono" y cuál para
   "todavía no se registró"?
3. En clientes, la columna correo tiene '', NULL y direcciones reales. ¿Qué
   representa cada caso y por qué conviene no usar '' para "sin correo"?
*/