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