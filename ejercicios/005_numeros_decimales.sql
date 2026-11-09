-- ===== BLOQUE SETUP =====
-- Nota: CREATE TABLE e INSERT se explican en clases posteriores (010 y 021).
-- Por ahora solo ejecuta este bloque completo (Alt+X en DBeaver) sin modificarlo.

DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

-- Dominio: ventas de una cafetería
CREATE TABLE ventas_cafeteria (
    id_venta        INTEGER,
    producto        VARCHAR(30),
    precio_unitario NUMERIC(8,2),
    tasa_iva        NUMERIC(4,3),
    peso_kg         REAL
);

INSERT INTO ventas_cafeteria VALUES
    (1, 'Cafe americano',     2.50,  0.210, 0.35),
    (2, 'Cafe latte',         3.75,  0.210, 0.40),
    (3, 'Croissant',          2.50,  0.100, 0.12),
    (4, 'Sandwich mixto',     6.99,  0.100, 0.30),
    (5, 'Jugo natural',       4.20,  0.105, 0.45),
    (6, 'Torta de chocolate', 12.00, 0.210, 1.10),
    (7, 'Cafe en grano 1 kg', 24.99, 0.210, 1.00),
    (8, 'Agua mineral',       1.00,  0.000, 0.50);

-- Dominio: meteorología
CREATE TABLE estaciones_clima (
    id_estacion   INTEGER,
    ciudad        VARCHAR(30),
    temperatura_c NUMERIC(4,1),
    humedad_pct   REAL,
    presion_hpa   DOUBLE PRECISION,
    latitud       DOUBLE PRECISION,
    longitud      DOUBLE PRECISION
);

INSERT INTO estaciones_clima VALUES
    (1, 'Lima',         19.5, 83.5, 1013.25, -12.046374, -77.042793),
    (2, 'Buenos Aires', 24.3, 61.0, 1009.8,  -34.603722, -58.381592),
    (3, 'Ushuaia',      -4.0, 78.2, 985.4,   -54.801912, -68.302951),
    (4, 'Quito',        14.8, 70.5, 742.6,   -0.180653,  -78.467834),
    (5, 'Bogota',       14.8, 72.0, 748.9,   4.710989,   -74.072092),
    (6, 'La Paz',       9.0,  45.5, 650.1,   -16.489689, -68.119293),
    (7, 'Sao Paulo',    27.6, 66.0, 1012.0,  -23.55052,  -46.633308),
    (8, 'Montevideo',   22.1, 77.7, 1015.5,  -34.901112, -56.164532),
    (9, 'Punta Arenas', 0.0,  81.0, 998.7,   -53.16383,  -70.917071);

-- Dominio: finanzas
CREATE TABLE cuentas_banco (
    id_cuenta    INTEGER,
    titular      VARCHAR(30),
    saldo        NUMERIC(14,2),
    tasa_anual   NUMERIC(6,4),
    limite_cuota NUMERIC(5,2)
);

INSERT INTO cuentas_banco VALUES
    (1, 'Marta Ruiz',        15230.75,     0.0450, 999.99),
    (2, 'Jorge Salas',       0.00,         0.0000, 0.01),
    (3, 'Corporacion Delta', 987654321098.76, 0.0325, 500.00),
    (4, 'Luis Vega',         -1250.40,     0.1850, -999.99),
    (5, 'Rosa Mendoza',      15230.75,     0.0450, 250.50),
    (6, 'Pedro Rios',        320.10,       0.0125, 100.00),
    (7, 'Elena Cruz',        1.99,         0.0000, 0.01),
    (8, 'Tomas Gil',         48000.00,     0.0725, 999.99);

-- Dominio: laboratorio
CREATE TABLE laboratorio_muestras (
    id_muestra       INTEGER,
    compuesto        VARCHAR(30),
    concentracion_mg REAL,
    masa_g           DOUBLE PRECISION,
    ph               NUMERIC(4,2)
);

INSERT INTO laboratorio_muestras VALUES
    (1, 'Glucosa',   123456.789,        123456.789,        7.40),
    (2, 'Sodio',     16777217,          16777217,          6.85),
    (3, 'Potasio',   0.1,               0.1,               7.00),
    (4, 'Calcio',    0.0000001,         0.0000001,         8.20),
    (5, 'Urea',      3.14159265358979,  3.14159265358979,  5.50),
    (6, 'Hierro',    0,                 0,                 6.10),
    (7, 'Zinc',      -2.5,              -2.5,              7.40),
    (8, 'Magnesio',  15000000000,       15000000000,       7.00);


-- ===== BLOQUE EJERCICIOS =====

/*
PRÁCTICA GUIADA EN DBEAVER (marca cada paso al completarlo)

[ ] 1. Selecciona todo el script de este archivo y ejecútalo con Alt+X
       (Ejecutar script). Verifica en la pestaña de salida que no hay errores.
[ ] 2. En el Navegador de bases de datos, haz clic derecho sobre tu base de
       datos y elige Refrescar (F5). Expande Esquemas > practica > Tablas y
       confirma que aparecen las 4 tablas del SETUP.
[ ] 3. Escribe debajo de este comentario una consulta SELECT * FROM por cada
       tabla (ventas_cafeteria, estaciones_clima, cuentas_banco,
       laboratorio_muestras) y ejecútalas una por una con Ctrl+Enter.
[ ] 4. En cada resultado, observa cuántos decimales muestra cada columna y
       cuáles muestran decimales fijos aunque el valor termine en cero.
[ ] 5. Para cada columna decimal, escribe en comentarios: qué tipo le asignarías
       (NUMERIC con qué precision y escala, REAL o DOUBLE PRECISION) y por qué.
[ ] 6. Identifica en comentarios los valores más cercanos a los límites de su
       tipo (los más grandes, los más pequeños, los negativos y los ceros) y
       razona qué pasaría si eligieras un tipo con menos capacidad.
[ ] 7. Abre cada tabla con doble clic > pestaña Columnas y compara el tipo
       real con el que habías supuesto. Anota en comentarios cualquier diferencia.
*/

-- Escribe aquí tus consultas SELECT * FROM:



-- Escribe aquí tus razonamientos en comentarios:



/*
PREGUNTAS DE COMPRENSIÓN (responde en comentarios, con tus palabras)

1. Una tienda guarda sus precios en una columna DOUBLE PRECISION. ¿Qué riesgo
   corre al sumar miles de ventas y por qué NUMERIC(p,s) lo evita?

2. Una columna se declara NUMERIC(4,1). ¿Cuántos dígitos enteros admite y cuál
   es el valor positivo más grande que puede guardar? ¿Qué ocurre si se intenta
   guardar uno mayor?

3. En laboratorio_muestras, las columnas concentracion_mg (REAL) y masa_g
   (DOUBLE PRECISION) reciben los mismos valores. Observa los resultados:
   ¿cuál de las dos pierde dígitos en alguno de ellos y a qué se debe esa
   diferencia entre ambos tipos?
*/