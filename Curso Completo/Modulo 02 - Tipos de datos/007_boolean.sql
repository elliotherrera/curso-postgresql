-- ===== CLASE 007: BOOLEAN =====
--
-- Objetivo: reconocer el tipo BOOLEAN, sus tres estados posibles y su uso para representar condiciones de sí/no en una tabla.
--
-- Concepto: BOOLEAN es el tipo de dato que representa verdadero, falso o desconocido. PostgreSQL lo almacena como un valor booleano y DBeaver lo muestra como true, false o NULL. No es texto: no está pensado para guardar "Sí", "No", "S/N" ni descripciones libres.
--
-- Para qué sirve en análisis de datos:
-- 1. Marcar clientes activos o inactivos sin ambigüedad.
-- 2. Registrar si un pedido fue entregado, confirmado o cancelado.
-- 3. Clasificar productos disponibles, en oferta o revisados.
--
-- Sintaxis general comentada:
-- columna BOOLEAN
--   Declara una columna que solo acepta los estados booleanos.
-- TRUE / FALSE
--   Literales booleanos. También se aceptan variantes de entrada como 't', 'true', 'yes', '1' para verdadero, y 'f', 'false', 'no', '0' para falso.
-- NULL
--   No es verdadero ni falso: representa un dato desconocido o no informado.
--
-- BOOLEAN tiene tres valores, no dos. Esa es la diferencia clave frente a un CHAR(1) con 'S'/'N':
-- el tipo BOOLEAN restringe el dominio a TRUE, FALSE y NULL. Un CHAR(1), en cambio, permite cualquier letra.
-- En DBeaver, una columna BOOLEAN se ve como true, false o NULL. NULL no significa "falso": significa
-- que no se sabe si la condición se cumple o no.
--
-- Ejemplo 1: tabla tareas
-- id_tarea | titulo  | completada | revisada
-- ---------+---------+------------+----------
-- 1        | Informe | true       | false
-- 2        | Backup  | false      | NULL
-- 3        | Reunión | true       | true
-- 4        | Prueba  | NULL       | false
--
-- SELECT * FROM tareas;
--
-- Resultado esperado:
-- id_tarea | titulo  | completada | revisada
-- ---------+---------+------------+----------
-- 1        | Informe | true       | false
-- 2        | Backup  | false      | NULL
-- 3        | Reunión | true       | true
-- 4        | Prueba  | NULL       | false
--
-- La columna completada muestra los tres estados: true, false y NULL.
-- La fila 4 no dice que la prueba esté incompleta: dice que no se sabe si está completada.
--
-- Ejemplo 2: tabla pagos
-- id_pago | cliente | confirmado | monto
-- --------+---------+------------+-------
-- 1       | Ana     | true       | 100.00
-- 2       | Bruno   | false      | 50.00
-- 3       | Carla   | NULL       | 75.00
-- 4       | Diego   | true       | 100.00
--
-- SELECT * FROM pagos;
--
-- Resultado esperado:
-- id_pago | cliente | confirmado | monto
-- --------+---------+------------+-------
-- 1       | Ana     | true       | 100.00
-- 2       | Bruno   | false      | 50.00
-- 3       | Carla   | NULL       | 75.00
-- 4       | Diego   | true       | 100.00
--
-- En análisis de datos, NULL en una columna BOOLEAN suele obligar a decidir explícitamente
-- cómo tratarlo: ¿se cuenta como no confirmado, como dato faltante o se excluye del análisis?
--
-- Errores y buenas prácticas:
-- Error: escribir 'Sí' o 'No' con tilde en una columna BOOLEAN. Mensaje típico: invalid input syntax for type boolean: "Sí". Causa: PostgreSQL solo acepta literales booleanos reconocidos, no texto libre.
-- Error: asumir que NULL se comporta como FALSE al filtrar o contar. No siempre hay mensaje de error, pero las filas con NULL pueden quedar fuera de comparaciones; causa: lógica de tres valores.
-- Error: usar CHAR(1) con 'S'/'N' para un estado binario. No hay error de ejecución, pero se permiten valores inválidos y se complica el análisis; causa: el tipo no restringe el dominio.
-- Buena práctica: usa BOOLEAN para columnas de sí/no y reserva NULL solo para cuando el dato realmente se desconoce.
-- Buena práctica: documenta qué significa NULL en cada columna BOOLEAN, por ejemplo "sin información" frente a "no confirmado".

-- ===== BLOQUE SETUP =====
-- Las sentencias CREATE TABLE e INSERT se explicarán más adelante.
-- Aquí solo preparan datos variados para observar el tipo BOOLEAN y otras columnas.

DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

CREATE TABLE suscripciones (
    id_suscripcion INTEGER,
    cliente VARCHAR(40),
    activa BOOLEAN,
    renovacion_automatica BOOLEAN,
    fecha_alta DATE,
    monto NUMERIC(8,2)
);

INSERT INTO suscripciones VALUES
(1, 'Ana', TRUE, TRUE, '2024-01-10', 120.00),
(2, 'Bruno', FALSE, FALSE, '2024-02-15', 80.50),
(3, 'Carla', TRUE, NULL, '2024-03-01', 95.00),
(4, 'Diego', NULL, TRUE, '2024-03-20', 150.00),
(5, 'Elena', TRUE, FALSE, '2024-04-05', 120.00),
(6, 'Fabián', FALSE, NULL, '2024-04-18', 60.00),
(7, 'Gloria', NULL, NULL, '2024-05-02', 200.00),
(8, 'Hugo', TRUE, TRUE, '2024-05-09', 80.50);

CREATE TABLE productos (
    id_producto INTEGER,
    nombre VARCHAR(40),
    disponible BOOLEAN,
    en_oferta BOOLEAN,
    stock INTEGER,
    precio NUMERIC(8,2)
);

INSERT INTO productos VALUES
(1, 'Teclado', TRUE, FALSE, 15, 25.00),
(2, 'Mouse', TRUE, TRUE, 0, 12.50),
(3, 'Monitor', FALSE, FALSE, 4, 180.00),
(4, 'Cable HDMI', TRUE, NULL, 30, 8.00),
(5, 'Webcam', NULL, TRUE, 7, 45.00),
(6, 'Parlante', TRUE, FALSE, 12, 35.00),
(7, 'Hub USB', FALSE, NULL, 0, 20.00),
(8, 'Lámpara', NULL, FALSE, 9, 18.00);

CREATE TABLE empleados (
    id_empleado INTEGER,
    nombre VARCHAR(40),
    activo BOOLEAN,
    remoto BOOLEAN,
    salario NUMERIC(10,2),
    fecha_ingreso DATE
);

INSERT INTO empleados VALUES
(1, 'Lucía', TRUE, TRUE, 2500.00, '2021-03-01'),
(2, 'Martín', TRUE, FALSE, 2100.00, '2022-06-15'),
(3, 'Nora', FALSE, NULL, 1800.00, '2020-11-20'),
(4, 'Oscar', NULL, TRUE, 3000.00, '2019-01-07'),
(5, 'Paula', TRUE, TRUE, 2500.00, '2023-02-13'),
(6, 'Quique', FALSE, FALSE, 1700.00, '2022-09-30'),
(7, 'Rosa', NULL, NULL, 2200.00, '2021-12-01'),
(8, 'Sergio', TRUE, FALSE, 2100.00, '2024-04-22');

CREATE TABLE envios (
    id_envio INTEGER,
    destino VARCHAR(40),
    entregado BOOLEAN,
    prioridad BOOLEAN,
    peso_kg NUMERIC(6,2),
    fecha_envio DATE
);

INSERT INTO envios VALUES
(1, 'Rosario', TRUE, FALSE, 2.50, '2024-05-01'),
(2, 'Córdoba', FALSE, TRUE, 1.20, '2024-05-02'),
(3, 'Mendoza', TRUE, NULL, 8.00, '2024-05-03'),
(4, 'La Plata', NULL, FALSE, 3.40, '2024-05-04'),
(5, 'Salta', TRUE, TRUE, 2.50, '2024-05-05'),
(6, 'Neuquén', FALSE, FALSE, 5.10, '2024-05-06'),
(7, 'Tucumán', NULL, NULL, 1.20, '2024-05-07'),
(8, 'Bahía Blanca', TRUE, FALSE, 4.70, '2024-05-08');

-- ===== BLOQUE EJERCICIOS =====
-- Clase 007: práctica guiada observacional y preguntas de comprensión.
-- No se piden WHERE, funciones, cálculos ni DDL/DML en esta práctica.

/*
PRÁCTICA GUIADA EN DBEAVER

Checklist de pasos a completar:

1. Abre DBeaver, conéctate a tu base de datos y abre un editor SQL. ✔️
2. Ejecuta el BLOQUE SETUP completo para crear el esquema practica y sus tablas. ✔️
3. Ejecuta SELECT * FROM suscripciones; y observa la pestaña de resultados.
   Anota qué columnas parecen BOOLEAN y qué valores aparecen: true, false o NULL.
   RPTA: columnas: activa y renovacion_automatica
   
🛠️🛠️🛠️ CONFIGURACION 🛠️🛠️🛠️: por defecto Dbeaver muestra los boolean como [v], [] y [NULL]. Ademas se cambian con un simple click desde la tabla. Cambiaremos eso de la siguiente manera: Vamos a Ventana > Preferencias > Editores > Data Editor > Appearance > Tabla - Aqui desmarcamos Show booleans as checkboxes | Toggle boolean on click

4. Ejecuta SELECT * FROM productos; y repite la observación.
   Presta atención a disponible y en_oferta. ✔️
5. Ejecuta SELECT * FROM empleados; y observa activo y remoto. ✔️
6. Ejecuta SELECT * FROM envios; y observa entregado y prioridad. ✔️
7. Revisa si hay valores NULL en las columnas BOOLEAN. Para cada caso, escribe qué significa ese NULL:
   ¿dato desconocido, no informado, pendiente de revisar? ✔️
   RPTA: NULL es un dato no informado
   
8. Compara una columna BOOLEAN con una columna VARCHAR. Responde en comentarios:
   ¿qué ventaja tiene BOOLEAN para representar sí/no? ✔️
   RPTA: la ventaja de boolean es que limita las respuestas a 3 tipos true, false y NULL y esto hace que se mas facil analizar, mientras que un VARCHAR podria contener muchas variasntes como true: si, yes, Si, SI, ok, verdadero, etc.
   

Preguntas de comprensión:

1. ¿Cuántos estados puede representar una columna BOOLEAN en PostgreSQL? Nombra cada uno y explica qué significa NULL.
RPTA: true, false y NULL. NULL significa un dato no declarado

2. ¿Por qué no conviene usar VARCHAR(2) con valores como 'SI' y 'NO' para representar una condición de sí/no? Menciona al menos una ventaja de BOOLEAN.
RPTA: No conviene usar VARCHAR(2) ni CHAR(2) porque pueden tirar muchas combinaciones, mientras que un boolean las limita a solo 3.

3. En las tablas del SETUP, elige una columna BOOLEAN con valores NULL. Explica qué decisión tomarías al analizar esos datos: tratar NULL como false, como dato faltante o excluirlo. Justifica brevemente.
RPTA: No le asignaria un true, o false, lo excluiria.
*/



