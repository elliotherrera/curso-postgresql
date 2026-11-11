-- ===== CLASE 006: TEXTO: CHAR, VARCHAR, TEXT =====

/*
OBJETIVO
Elegir el tipo de texto adecuado (CHAR, VARCHAR o TEXT) según la forma y el largo
de la información que se va a guardar.

CONCEPTO
PostgreSQL guarda texto con tres tipos. CHAR(n) guarda exactamente n caracteres y
rellena con espacios si el valor es más corto. VARCHAR(n) guarda hasta n caracteres
sin relleno. TEXT no tiene límite declarado (hasta 1 GB). Si un valor supera el
límite n de CHAR o VARCHAR, PostgreSQL lo rechaza con un error: no lo corta.

PARA QUÉ SIRVE (casos de uso en análisis de datos)
1. Códigos de largo fijo (código de país ISO, SKU, código de envío): CHAR(n).
2. Nombres, ciudades, categorías y estados con un largo máximo razonable, que luego
   se usan para agrupar y filtrar: VARCHAR(n).
3. Comentarios, descripciones, observaciones y logs de largo impredecible, que se
   analizan como texto libre: TEXT.

SINTAXIS GENERAL (al definir una columna; CREATE TABLE se explica más adelante)

   nombre_columna CHAR(n)
   nombre_columna VARCHAR(n)
   nombre_columna TEXT

   - nombre_columna : el nombre de la columna.
   - CHAR(n)        : largo fijo; si el valor tiene menos de n caracteres, se
                      completa con espacios a la derecha.
   - VARCHAR(n)     : largo variable con tope de n caracteres.
   - TEXT           : largo variable sin tope declarado.
   - n              : cantidad máxima de caracteres (no de bytes). Un acento o una
                      ñ cuentan como un carácter.
   - Los valores de texto se escriben entre comillas simples: 'Lima'.
*/

-- ----------------------------------------------------------------------------
-- COMPARACIÓN: cómo se guarda el valor 'AB' según el tipo
-- ----------------------------------------------------------------------------
--   CHAR(5)      'AB'  se guarda como  'AB   '   (3 espacios de relleno)
--   VARCHAR(5)   'AB'  se guarda como  'AB'
--   TEXT         'AB'  se guarda como  'AB'
--
--   Valor 'ABCDEFG' (7 caracteres):
--   CHAR(5)      -> ERROR: value too long for type character(5)
--   VARCHAR(5)   -> ERROR: value too long for type character varying(5)
--   TEXT         -> se guarda completo
--
-- En PostgreSQL no hay diferencia de rendimiento entre los tres tipos.

-- ----------------------------------------------------------------------------
-- DATOS DE EJEMPLO DE LA TEORÍA (esquema propio, separado de la práctica)
-- CREATE TABLE e INSERT se explicarán más adelante; por ahora solo ejecútalos.
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS teoria CASCADE;
CREATE SCHEMA teoria;
SET search_path TO teoria;

CREATE TABLE libros (
    codigo  CHAR(5),
    titulo  VARCHAR(40),
    idioma  CHAR(2),
    resumen TEXT
);

INSERT INTO libros (codigo, titulo, idioma, resumen) VALUES
('L0001', 'Cien años de soledad', 'ES', 'Saga de la familia Buendía en Macondo.'),
('L0002', 'El Aleph',             'ES', 'Colección de cuentos de Borges.'),
('L0003', 'Pedro Páramo',         'ES', 'Un hijo viaja a Comala en busca de su padre.'),
('L0004', 'The Hobbit',           'EN', 'Aventura de Bilbo Bolsón y un anillo.');

-- Datos de la tabla libros:
-- +--------+----------------------+--------+----------------------------------------------+
-- | codigo | titulo               | idioma | resumen                                      |
-- +--------+----------------------+--------+----------------------------------------------+
-- | L0001  | Cien años de soledad | ES     | Saga de la familia Buendía en Macondo.       |
-- | L0002  | El Aleph             | ES     | Colección de cuentos de Borges.              |
-- | L0003  | Pedro Páramo         | ES     | Un hijo viaja a Comala en busca de su padre. |
-- | L0004  | The Hobbit           | EN     | Aventura de Bilbo Bolsón y un anillo.        |
-- +--------+----------------------+--------+----------------------------------------------+

-- ----------------------------------------------------------------------------
-- EJEMPLO 1: ver los datos
-- ----------------------------------------------------------------------------
SELECT * FROM libros;
-- Resultado esperado: las 4 filas de la tabla anterior, en ese orden.
-- Para ver el tipo de cada columna: clic derecho sobre la tabla libros en el
-- Navegador de DBeaver > Ver tabla > pestaña Columns, o doble clic sobre la tabla.

-- ----------------------------------------------------------------------------
-- EJEMPLO 2: un valor que no cabe en VARCHAR(40) (ejecútalo y observa el error)
-- ----------------------------------------------------------------------------
INSERT INTO libros (codigo, titulo, idioma, resumen) VALUES
('L0005', 'Tratado completo sobre la historia de las bibliotecas del mundo antiguo', 'ES', 'Texto de prueba.');
-- Error esperado: ERROR: value too long for type character varying(40)
-- El título tiene más de 40 caracteres. No se inserta nada.

-- ----------------------------------------------------------------------------
-- EJEMPLO 3: TEXT acepta cualquier largo; el título sí cabe en VARCHAR(40)
-- ----------------------------------------------------------------------------
INSERT INTO libros (codigo, titulo, idioma, resumen) VALUES
('L0005', 'Rayuela', 'ES', 'Novela experimental que puede leerse en dos órdenes distintos: el lineal y el propuesto por el autor, saltando entre capítulos. El resumen puede ser tan largo como haga falta porque la columna es TEXT.');

SELECT * FROM libros;
-- Resultado esperado: ahora hay 5 filas; la última es L0005 | Rayuela | ES | (resumen largo).

-- ----------------------------------------------------------------------------
-- ERRORES Y BUENAS PRÁCTICAS
-- ----------------------------------------------------------------------------
-- * Error: texto más largo que el límite. Mensaje: "ERROR: value too long for type
--   character varying(40)". Causa: PostgreSQL rechaza el valor, no lo recorta.
-- * Error: usar comillas dobles para un valor. Mensaje: "ERROR: column "Perú" does
--   not exist". Causa: las comillas dobles nombran columnas; el texto va entre comillas simples.
-- * Error: usar CHAR(n) para texto de largo variable. No muestra mensaje, pero el
--   valor queda con espacios de relleno al final, lo que genera resultados confusos.
-- * Buena práctica: usar CHAR(n) solo para códigos que siempre tienen el mismo largo
--   (ISO de país, SKU); para el resto, VARCHAR(n) o TEXT.
-- * Buena práctica: usar VARCHAR(n) solo si existe un límite real del negocio; si no
--   lo hay, TEXT evita errores por límites arbitrarios.


-- ===== BLOQUE SETUP =====
-- CREATE TABLE e INSERT se explicarán más adelante; por ahora solo ejecútalos.
-- Ejecuta todo el script con Alt + X.
DROP SCHEMA IF EXISTS practica CASCADE;
CREATE SCHEMA practica;
SET search_path TO practica;

-- Países de referencia (códigos de largo fijo y nombres de largo variable)
CREATE TABLE paises_ref (
    iso2    CHAR(2),
    iso3    CHAR(3),
    nombre  VARCHAR(40),
    capital VARCHAR(20)
);

INSERT INTO paises_ref (iso2, iso3, nombre, capital) VALUES
('AR', 'ARG', 'Argentina',                          'Buenos Aires'),
('PE', 'PER', 'Perú',                               'Lima'),
('CL', 'CHL', 'Chile',                              'Santiago'),
('CO', 'COL', 'Colombia',                           'Bogotá'),
('UY', 'URY', 'Uruguay',                            'Montevideo'),
('BO', 'BOL', 'Estado Plurinacional de Bolivia',    'Sucre'),
('BR', 'BRA', 'Brasil',                             'Brasilia'),
('VE', 'VEN', 'República Bolivariana de Venezuela', 'Caracas');

-- Registro de envíos (logística)
CREATE TABLE envios_log (
    codigo_envio CHAR(8),
    destino      VARCHAR(25),
    estado       VARCHAR(12),
    observacion  TEXT
);

INSERT INTO envios_log (codigo_envio, destino, estado, observacion) VALUES
('ENV00001', 'Buenos Aires',      'Entregado', 'Sin novedades'),
('ENV00002', 'Córdoba',           'En camino', 'Retraso por lluvia intensa en la ruta nacional 9 cerca de Rosario'),
('ENV00003', 'Mendoza',           'Entregado', ''),
('ENV00004', 'Lima',              'entregado', 'Cliente recibió el paquete en recepción'),
('ENV00005', 'Santiago de Chile', 'Pendiente', 'Esperando autorización de aduana'),
('ENV00006', 'Montevideo',        'En camino', 'Sin novedades'),
('ENV00007', 'Bogotá',            'Devuelto',  'Dirección incorrecta; el repartidor intentó contactar al cliente tres veces sin respuesta. Se devuelve al depósito para reprogramar.'),
('ENV00008', 'Rosario',           'Pendiente', 'Sin novedades');

-- Empleados (RRHH)
CREATE TABLE empleados_rrhh (
    id_empleado INTEGER,
    sigla_area  CHAR(3),
    nombre      VARCHAR(25),
    apellido    VARCHAR(30),
    cargo       VARCHAR(40),
    biografia   TEXT
);

INSERT INTO empleados_rrhh (id_empleado, sigla_area, nombre, apellido, cargo, biografia) VALUES
(1, 'VEN', 'Ana',                      'Quispe Mamani', 'Ejecutiva de ventas',          'Trabaja en la empresa desde 2019.'),
(2, 'VEN', 'Luis',                     'Quispe Mamani', 'Jefe de ventas',               ''),
(3, 'LOG', 'Juan Sebastián Alejandro', 'Ríos',          'Coordinador de logística',     'Responsable de las rutas del norte.'),
(4, 'LOG', 'María José',               'Gómez',         'Analista de logística',        'Ingresó como pasante y fue promovida en su segundo año.'),
(5, 'RRH', 'Carla',                    'Núñez',         'Analista de recursos humanos', 'Coordina los procesos de selección y la capacitación interna de todas las áreas.'),
(6, 'TIC', 'Pedro',                    'O''Brien',      'Desarrollador',                'Mantiene los sistemas internos.'),
(7, 'TIC', 'Ana',                      'Torres',        'Desarrolladora',               'Trabaja en automatización de reportes.');

-- Inventario de productos
CREATE TABLE productos_inventario (
    sku         CHAR(6),
    descripcion VARCHAR(30),
    unidad      CHAR(3),
    nota        TEXT
);

INSERT INTO productos_inventario (sku, descripcion, unidad, nota) VALUES
('TO-001', 'Tornillo hexagonal acero inox.', 'UND', 'Caja de 100 unidades'),
('TO-002', 'Tuerca M8',                      'UND', 'Caja de 100 unidades'),
('PI-010', 'Pintura latex blanca',           'LTS', ''),
('PI-011', 'Pintura latex blanca',           'LTS', 'Lote con fecha de vencimiento cercana'),
('CA-100', 'Cable unipolar 2.5 mm',          'MTS', 'Rollo de 100 metros; almacenar lejos de la humedad y del calor directo'),
('CE-200', 'Cemento Portland',               'KGS', 'Bolsa de 50 kg'),
('AR-300', 'Arena fina',                     'KGS', 'Pedido por camión; ver ficha de proveedor');

-- ===== BLOQUE EJERCICIOS =====
-- (Clases 001 a 009: práctica guiada en DBeaver y preguntas de comprensión)

/*
PRÁCTICA GUIADA EN DBEAVER (marca cada paso al completarlo)

[✔️] 1. Selecciona todo el script y ejecútalo con Alt + X (Ejecutar script).
[✔️] 2. En el Navegador de bases de datos, haz clic derecho sobre tu base de datos
       y elige Refrescar (F5). Despliega el esquema practica y comprueba que
       aparecen 4 tablas: paises_ref, envios_log, empleados_rrhh y
       productos_inventario.
[✔️] 3. Ejecuta, una por una (Ctrl + Enter), estas consultas:
       SELECT * FROM paises_ref;
       SELECT * FROM envios_log;
       SELECT * FROM empleados_rrhh;
       SELECT * FROM productos_inventario;
[✔️] 4. Haz doble clic sobre cada tabla en el Navegador y abre la pestaña
       Columns (o Propiedades) para ver el tipo y el largo de cada columna.
[✔️] 5. Por cada tabla, recorre las filas del resultado y anota en comentarios:
       a) Qué tipo de texto (CHAR, VARCHAR, TEXT) le asignarías a cada columna.
       b) Qué valores específicos están peligrosamente cerca o exactamente en el
          límite total del largo propuesto para su columna.
       c)  Qué pasaría si eligieras un límite más chico.

ESPACIO PARA TUS RESPUESTAS DEL PASO 5:
*/
-- paises_ref:
-- a) iso2 CHAR(2), iso3 CHAR(3), nombre VARCHAR(40), capital VARCHAR(20)
-- b) el nombre 'República Bolivariana de Venezuela' tiene 34/40 caracteres a 6 del limite.
-- c) si hubiese elegido VARCHAR(20) 34/20 excede 14 caracteres y tira error.
-- envios_log:
-- a) codigo_envio CHAR(8), destino VARCHAR(25), estado VARCHAR(12), observacion TEXT
-- b) el destino 'Santiago de Chile' tiene 17/25 a 8 del limite.
-- c) si hubiese elegido VARCHAR(15) 17/15, excede 2 y tira error
-- empleados_rrhh:
-- a) id_empleado INTEGER, sigla_area CHAR(3), nombre VARCHAR(25), apellido VARCHAR(30), cargo VARCHAR(40), biografia TEXT
-- b) el nombre 'Juan Sebastián Alejandro' 24/25 a 1 del limite
-- c) si hubiese elegido VARCHAR(20) tendria 24/20, excede 4 y tiraria error
-- productos_inventario:
-- a) sku CHAR(6), descripcion VARCHAR(30), unidad CHAR(3), nota TEXT
-- b) descripcion tiene 'Tornillo hexagonal acero inox.' 30/30 al limite.
-- c) si hubiese elegido VARCHAR(25) tendria 30/25, excede 5 y tiraria error.

/*
PREGUNTAS DE COMPRENSIÓN

1) La columna iso2 de paises_ref contiene siempre dos letras y la columna capital
   contiene nombres de largo muy distinto. ¿Por qué CHAR sirve para una y no para
   la otra?

2) En productos_inventario, la descripción 'Tornillo hexagonal acero inox.' llena
   exactamente el límite de su columna. ¿Qué ocurriría con un producto cuya
   descripción tuviera un carácter más? ¿Y si la columna fuera TEXT?

3) En envios_log, la observación del envío ENV00007 es mucho más larga que las
   demás y la del envío ENV00003 está vacía. ¿Por qué es razonable que
   observacion sea TEXT y no VARCHAR(30)?
*/
-- Escribe tus respuestas aquí:
-- 1) CHAR sirve para iso2 porque se sabe que siempre seran 2 caracteres pero capital es variable en este caso sirve mas un VARCHAR
-- 2) Si tuviese 1 caracter mas tiraria error por estar fuera de rango de los 30 declarados en VARCHAR(30), seria mejor pre establecer un margen decente quizas podria ser VARCHAR(50) dependiendo del negocio. si colocamos TEXT no hay limite de caracteres
-- 3) Una observacion puede ser bastanet descriptiva y no podriamos encapsularlo en un VARCHAR, este tipo de columnas se recomienda TEXT que no tiene limite de caracteres




