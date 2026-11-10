-- ===== CLASE 004: NÚMEROS ENTEROS (SMALLINT, INTEGER, BIGINT) =====

/*
OBJETIVO
Elegir el tipo entero adecuado (SMALLINT, INTEGER o BIGINT) según el rango de valores que debe guardar una columna.

CONCEPTO
Un tipo entero guarda números sin parte decimal. PostgreSQL ofrece tres tamaños:
cuantos más bytes ocupa el tipo, más grande es el rango, pero más espacio gasta cada valor.
Si un valor no cabe en el rango del tipo, PostgreSQL lo rechaza con un error.

PARA QUÉ SIRVE (casos reales en análisis de datos)
1. Columnas de conteo o cantidad (unidades vendidas, número de clics) con el tamaño justo.
2. Identificadores de registros (id_cliente, id_pedido) que pueden crecer a millones.
3. Cifras muy grandes (población, montos en centavos, bytes transferidos) que exigen BIGINT.

TABLA DE REFERENCIA

  Tipo       Alias       Bytes   Rango
  ---------  ----------  ------  ------------------------------------------------------
  SMALLINT   INT2        2       -32.768 a 32.767
  INTEGER    INT, INT4   4       -2.147.483.648 a 2.147.483.647
  BIGINT     INT8        8       -9.223.372.036.854.775.808 a 9.223.372.036.854.775.807

SINTAXIS GENERAL
(la creación de tablas se explicará en la clase 010; aquí solo se muestra dónde va el tipo)

  CREATE TABLE nombre_tabla (
      nombre_columna  tipo_entero
  );

  - nombre_columna: nombre con el que se identifica el dato.
  - tipo_entero: SMALLINT, INTEGER o BIGINT; define el rango permitido.
  - Los tres admiten negativos, cero y positivos.

DESARROLLO

Cada ejemplo parte de una tabla ilustrativa (no existe en el SETUP) y se consulta con SELECT * FROM.
Los tipos de cada columna se indican entre paréntesis en la firma.

--- Ejemplo 1: SMALLINT e INTEGER conviviendo ---
libros (id_libro SMALLINT, paginas SMALLINT, ejemplares INTEGER)

-- SELECT * FROM libros;

-- Resultado esperado:
--  id_libro | paginas | ejemplares
-- ----------+---------+-----------
--         1 |     320 |      15000
--         2 |    1200 |    2300000
--         3 |      85 |        980

-- Las páginas nunca superan 32.767, así que SMALLINT alcanza.
-- Los ejemplares pueden crecer mucho más, por eso INTEGER.

--- Ejemplo 2: cuando INTEGER se queda corto ---
poblacion_regiones (id_region SMALLINT, region, habitantes BIGINT)

-- SELECT * FROM poblacion_regiones;

-- Resultado esperado:
--  id_region | region | habitantes
-- -----------+--------+-----------
--          1 | Asia   | 4700000000
--          2 | Africa | 1400000000
--          3 | Europa |  745000000

-- 4.700.000.000 supera 2.147.483.647, por eso la columna debe ser BIGINT.
-- Africa (1.400.000.000) todavía cabría en INTEGER, pero la columna
-- se define según el valor más grande posible.

--- Ejemplo 3: negativos y cero ---
estaciones (id_estacion SMALLINT, estacion, temp_min_c SMALLINT)

-- SELECT * FROM estaciones;

-- Resultado esperado:
--  id_estacion | estacion  | temp_min_c
-- -------------+-----------+-----------
--            1 | Vostok    |        -89
--            2 | Lima      |         14
--            3 | Glaciar X |          0

-- Los enteros guardan negativos sin ningún ajuste; PostgreSQL no tiene enteros "sin signo".

ERRORES Y BUENAS PRÁCTICAS
- Error: guardar un valor fuera de rango. Mensaje típico: "ERROR: integer out of range"
  (o "smallint out of range"). Causa: el valor no cabe en los bytes que usa el tipo.
- Error: suponer que SMALLINT llega a 65.535. Al guardar 40000 aparece "smallint out of range".
  Causa: PostgreSQL no tiene enteros sin signo; el máximo de SMALLINT es 32.767.
- Buena práctica: usar INTEGER como opción por defecto para conteos e identificadores comunes.
- Buena práctica: usar BIGINT cuando el dato pueda superar 2.147.483.647 (montos en centavos, población, eventos).
- Buena práctica: usar SMALLINT solo si el máximo está garantizado por la naturaleza del dato (edad, mes, páginas).
*/

-- ===== BLOQUE SETUP =====
-- Nota: CREATE TABLE e INSERT se explican más adelante (clases 010 y 021). Aquí se usan solo para preparar los datos de observación.
--
DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

CREATE TABLE ciudades (
    id_ciudad SMALLINT,
    nombre VARCHAR(40),
    habitantes INTEGER,
    altitud_metros SMALLINT,
    anio_fundacion SMALLINT
);

INSERT INTO ciudades (id_ciudad, nombre, habitantes, altitud_metros, anio_fundacion) VALUES
(1, 'La Paz', 816000, 3640, 1548),
(2, 'Amsterdam', 872000, -2, 1275),
(3, 'Jericó', 20000, -258, -9000),
(4, 'Cusco', 447000, 3399, 1100),
(5, 'Roma', 2800000, 21, -753),
(6, 'El Alto', 943000, 4150, 1985),
(7, 'Nueva Orleans', 383000, -2, 1718),
(8, 'Quito', 2011000, 2850, 1534),
(9, 'Potosí', 240000, 4067, 1545),
(10, 'Arequipa', 1008000, 2335, 1540),
(11, 'Tiahuanaco', NULL, 3840, -200);

CREATE TABLE cuentas_bancarias (
    id_cuenta INTEGER,
    titular VARCHAR(50),
    saldo_centavos BIGINT,
    sucursal SMALLINT
);

INSERT INTO cuentas_bancarias (id_cuenta, titular, saldo_centavos, sucursal) VALUES
(1, 'Ana Torres', 150000, 12),
(2, 'Luis Prado', -25000, 3),
(3, 'Marta Ruiz', 3000000000, 32767),
(4, 'Carlos Vega', 0, 8),
(5, 'Elena Soto', 2147483647, 15),
(6, 'Jorge Lima', 2147483648, 22),
(7, 'Nadia Cruz', NULL, 5),
(8, 'Pedro Gil', 999999999999, 100),
(9, 'Rosa Mena', 12000, 45),
(10, 'Iván Paz', -2147483648, 0);

CREATE TABLE inventario_repuestos (
    id_repuesto SMALLINT,
    nombre VARCHAR(40),
    stock SMALLINT,
    stock_minimo SMALLINT
);

INSERT INTO inventario_repuestos (id_repuesto, nombre, stock, stock_minimo) VALUES
(1, 'Filtro de aceite', 32767, 50),
(2, 'Bujía', 0, 10),
(3, 'Correa', 120, 20),
(4, 'Batería', NULL, 5),
(5, 'Faro', 32766, 8),
(6, 'Espejo', 45, 45),
(7, 'Llanta', 45, 45),
(8, 'Parabrisas', 12, 3),
(9, 'Radiador', -5, 2),
(10, 'Alternador', 30000, 15);

CREATE TABLE eventos_log (
    id_evento BIGINT,
    codigo_error SMALLINT,
    duracion_milisegundos INTEGER,
    usuario_id BIGINT,
    bytes_transferidos BIGINT
);

INSERT INTO eventos_log (id_evento, codigo_error, duracion_milisegundos, usuario_id, bytes_transferidos) VALUES
(1, -32768, 2147483647, 9223372036854775807, 5000000000),
(2, 0, 0, 1, 0),
(3, -1, 1500, 42, 1048576),
(4, 404, 32767, 100, 999999999999),
(5, NULL, 120000, 7, NULL),
(6, 500, -2147483648, 10000000000, 3000000000),
(7, 200, 45, 3, 1);

-- ===== BLOQUE PRÁCTICA =====
--
-- Checklist de pasos:
-- 1. Abre DBeaver y conéctate a tu base local de PostgreSQL; abre un editor SQL nuevo.
-- 2. Ejecuta este archivo completo o solo el bloque SETUP. Verifica en el panel de resultados que no haya errores.
-- 3. Actualiza el navegador de base de datos y confirma que existen las cuatro tablas del esquema practica.
-- 4. Ejecuta SELECT * FROM ciudades; y observa cada columna.
--    En un comentario nuevo escribe qué tipo entero asignarías a habitantes, altitud_metros y anio_fundacion, y por qué.
-- 5. Ejecuta SELECT * FROM cuentas_bancarias; y compara saldo_centavos con los límites de SMALLINT, INTEGER y BIGINT.
--    Anota en comentarios qué valores de esa columna no cabrían en SMALLINT y cuáles no cabrían en INTEGER.
-- 6. Ejecuta SELECT * FROM inventario_repuestos; e identifica los valores cercanos a 32767, los ceros y los negativos.
--    Explica en comentarios qué ocurriría si stock se declarara SMALLINT y llegara a 40000.
-- 7. Ejecuta SELECT * FROM eventos_log; y observa duracion_milisegundos y bytes_transferidos.
--    Indica en comentarios qué tipo usarías para cada una y qué riesgo existe si eliges un tipo más pequeño.
--
-- Preguntas de comprensión (responde en comentarios):
-- 1. ¿Qué diferencia hay entre SMALLINT, INTEGER y BIGINT en términos de rango y almacenamiento?
-- 2. ¿Por qué una columna con valores hasta 3.000.000.000 no puede ser INTEGER?
-- 3. ¿Qué error esperas si intentas guardar 40.000 en una columna SMALLINT y por qué?