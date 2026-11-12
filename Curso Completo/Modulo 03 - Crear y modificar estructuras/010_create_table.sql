-- ===== CLASE 010: CREATE TABLE =====
--
-- Objetivo: crear una tabla nueva definiendo sus columnas y el tipo de dato de cada una.
--
-- Concepto: CREATE TABLE es una sentencia DDL (lenguaje de definición de datos) que
-- registra una tabla vacía dentro del esquema activo. Cada columna necesita un nombre
-- y un tipo; las restricciones (NOT NULL, PRIMARY KEY, CHECK...) llegan en las clases
-- 011 a 016. La tabla nace sin filas: los datos se cargan después con INSERT (clase 021).
--
-- Para qué sirve en análisis de datos:
--   * Modelar un dominio nuevo (clientes, pedidos, sensores) antes de poblarlo.
--   * Crear tablas de paso donde guardar resultados intermedios de un análisis.
--   * Armar tablas de práctica para validar tipos y estructuras antes de un diseño final.
--
-- Sintaxis general:
--   CREATE TABLE [IF NOT EXISTS] nombre_tabla (
--       columna1 TIPO,
--       columna2 TIPO,
--       ...
--   );
--   * IF NOT EXISTS: si la tabla ya existe, no hace nada en lugar de lanzar error.
--   * nombre_tabla: identificador. Sin comillas, PostgreSQL lo guarda en minúsculas.
--   * TIPO: obligatorio en cada columna (INTEGER, VARCHAR(50), DATE, BOOLEAN, NUMERIC...).
--   * La coma separa columnas; la última columna no lleva coma.
--
-- El nombre de la tabla y de las columnas conviene escribirlo en minúsculas, sin
-- acentos ni espacios. Si se usan comillas dobles, el nombre queda sensible a
-- mayúsculas y hay que citarlo siempre igual.
--
-- ------------------------------------------------------------------
-- Ejemplo 1: tabla mínima de cuatro columnas.
-- ------------------------------------------------------------------
CREATE TABLE libros (
    id_libro INTEGER,
    titulo VARCHAR(120),
    anio INTEGER,
    disponible BOOLEAN
);

SELECT * FROM libros;
-- Resultado: la tabla existe pero está vacía.
--  id_libro | titulo | anio | disponible
-- ----------+--------+------+------------
-- (0 filas)

-- ------------------------------------------------------------------
-- Ejemplo 2: elegir el tipo correcto para cada dato.
-- ------------------------------------------------------------------
CREATE TABLE sensores (
    id_sensor INTEGER,
    nombre TEXT,
    temperatura REAL,
    presion NUMERIC(6,2),
    activo BOOLEAN,
    ultima_lectura TIMESTAMP
);
-- NUMERIC(6,2) admite hasta 9999.99 con dos decimales exactos.
-- TIMESTAMP guarda fecha y hora en un solo campo, como en ultima_lectura.
-- TEXT no tiene límite práctico de longitud; VARCHAR(n) sí lo tiene.

SELECT * FROM sensores;
--  id_sensor | nombre | temperatura | presion | activo | ultima_lectura
-- -----------+--------+-------------+---------+--------+----------------
-- (0 filas)

-- ------------------------------------------------------------------
-- Ejemplo 3: IF NOT EXISTS evita el error al reejecutar el script.
-- ------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS turnos (
    id_turno INTEGER,
    empleado VARCHAR(60),
    fecha DATE,
    hora_inicio TIME,
    cubierto BOOLEAN
);
-- Al ejecutarlo por segunda vez aparece un aviso, no un error:
-- NOTICE: relation "turnos" already exists, skipping

-- Sin IF NOT EXISTS, la segunda ejecución falla:
-- ERROR: relation "turnos" already exists

-- ------------------------------------------------------------------
-- Ejemplo 4: comillas dobles y nombres con mayúsculas o espacios.
-- ------------------------------------------------------------------
CREATE TABLE "Pedidos" (
    "IdPedido" INTEGER,
    "Fecha Pedido" DATE,
    total NUMERIC(10,2)
);
-- La tabla se llamará exactamente "Pedidos" (con P mayúscula) y habrá que citarla
-- siempre: SELECT * FROM "Pedidos";
-- SELECT * FROM Pedidos;  -- ERROR: relation "pedidos" does not exist
-- En cambio "total" va sin comillas porque no las necesita.
--
-- Después de crear una tabla, refresca la conexión en DBeaver (F5) para verla
-- en el navegador de bases de datos, dentro de Esquemas > practica > Tablas.
--
-- Errores y buenas prácticas:
-- * Omitir el tipo de una columna: CREATE TABLE t (a); devuelve
--   ERROR: syntax error at or near ")". Toda columna necesita nombre y tipo.
-- * Repetir el nombre de una columna: ERROR: column "x" specified more than once.
-- * Reejecutar sin IF NOT EXISTS: ERROR: relation "tabla" already exists.
-- * Usa minúsculas, sin acentos ni espacios: evitas tener que citar cada nombre.
-- * Ajusta el tipo al dato: NUMERIC para dinero, DATE/TIMESTAMP para fechas,
--   VARCHAR(n) solo cuando la longitud máxima esté clara.


-- ===== BLOQUE EJERCICIOS =====

/* EJERCICIO 1
   Crea la tabla cocineros con las columnas:
   id_cocinero INTEGER, nombre VARCHAR(60), turno CHAR(1),
   experiencia SMALLINT, en_servicio BOOLEAN.
   Después ejecuta SELECT * FROM cocineros.
*/

CREATE TABLE cocineros (
	id_cocinero INTEGER,
	nombre VARCHAR(60),
	turno CHAR(1),
	experiencia SMALLINT,
	en_servicio BOOLEAN
);

SELECT * FROM cocineros;

/* EJERCICIO 2
   Crea la tabla reservas con las columnas:
   id_reserva INTEGER, fecha DATE, hora TIME, personas SMALLINT,
   notas TEXT, confirmada BOOLEAN.
   Usa IF NOT EXISTS y ejecuta la sentencia dos veces seguidas.
*/

CREATE TABLE IF NOT EXISTS reservas (
	id_reserva INTEGER,
	fecha DATE,
	hora TIME,
	personas SMALLINT,
   notas TEXT,
   confirmada BOOLEAN
);

SELECT * FROM reservas;

/* EJERCICIO 3
   Crea la tabla insumos con las columnas:
   id_insumo INTEGER, descripcion TEXT, cantidad NUMERIC(8,3),
   perecedero BOOLEAN, vence DATE, costo_promedio NUMERIC(10,2).
   Luego ejecuta SELECT * FROM insumos.
*/

CREATE TABLE insumos (
	id_insumo INTEGER,
	descripcion TEXT,
	cantidad NUMERIC(8,3),
	perecedero BOOLEAN,
	vence DATE,
	costo_promedio NUMERIC(10,2)
);

SELECT * FROM insumos;

/* EJERCICIO 4
   Crea la tabla eventos con las columnas:
   id_evento INTEGER, nombre TEXT, inicio TIMESTAMPTZ, fin TIMESTAMPTZ,
   aforo INTEGER, gratuito BOOLEAN, notas TEXT.
   Ejecuta SELECT * FROM eventos y observa el encabezado de columnas que devuelve.
*/

CREATE TABLE eventos (
	id_evento INTEGER,
	nombre TEXT,
	inicio TIMESTAMPTZ,
	fin TIMESTAMPTZ,
	aforo INTEGER,
	gratuito BOOLEAN,
	notas TEXT
);

SELECT * FROM eventos;

/* EJERCICIO 5
   Crea la tabla mediciones con las columnas:
   id_medicion INTEGER, estacion VARCHAR(20), temperatura NUMERIC(5,2),
   humedad REAL, viento_kmh SMALLINT, valida BOOLEAN, momento TIMESTAMP.
   En comentarios, justifica por qué elegiste cada tipo y qué rango de valores admite.
   Después ejecuta SELECT * FROM mediciones.
*/

CREATE TABLE mediciones (
	id_medicion INTEGER,			-- INTEGER se ocupa bien de ids, el rango es de mas y menos 2.1 mil millones
	estacion VARCHAR(20),			-- dentro de las 4 estaciones cabe bien un VRACHAR(20) el limite es 20 caracteres
	temperatura NUMERIC(5,2),		-- aqui podria cambiarlo por REAL, con 6 digitos significativos sobra
	humedad REAL,					-- 6 digitos significativos de REAL es suficiente para este tipo de informacion
	viento_kmh SMALLINT,			-- en termino de km/h sobra el rango de mas menos 32mil
	valida BOOLEAN,					-- aqui es correcto un BOOLEAN solo queremos saber si es valido, no y NULL
	momento TIMESTAMP				-- dependiendo del alcance podria ser tambein un TIMESTAMPTZ
);

SELECT * FROM mediciones;

/* EJERCICIO 6
   Crea la tabla productos con las columnas:
   id_producto INTEGER, nombre VARCHAR(60), descripcion TEXT,
   precio NUMERIC(8,2), fecha_alta DATE, descontinuado BOOLEAN.
   En comentarios, indica en qué columnas tendría sentido que un valor quede vacío
   y en cuáles no, sabiendo que en esta clase todavía no se usan restricciones.
   Después ejecuta SELECT * FROM productos.
*/

CREATE TABLE productos (
	id_producto INTEGER,		-- No puede tener NULL
	nombre VARCHAR(60),			-- No puede tener NULL
	descripcion TEXT,			-- Puede tener NULL
	precio NUMERIC(8,2),		-- Puede tener NULL
	fecha_alta DATE,			-- Puede tener NULL
	descontinuado BOOLEAN		-- Puede tener NULL
);

SELECT * FROM productos;

/* EJERCICIO 7
   Crea dos tablas:
   sedes (id_sede INTEGER, ciudad VARCHAR(40), pais CHAR(2), apertura DATE, activa BOOLEAN)
   aulas (id_aula INTEGER, id_sede INTEGER, nombre VARCHAR(30), capacidad SMALLINT, tiene_proyector BOOLEAN)
   No agregues FOREIGN KEY: se ve en la clase 016.
   Ejecuta SELECT * FROM sobre cada una y confirma en el navegador de bases de datos
   de DBeaver (refresca con F5) que ambas aparecen dentro del esquema practica.
*/

CREATE TABLE sedes (
	id_sede INTEGER,
	ciudad VARCHAR(40),
	pais CHAR(2),
	apertura DATE,
	activa BOOLEAN
);

SELECT * FROM sedes;

CREATE TABLE aulas (
	id_aula INTEGER,
	id_sede INTEGER,
	nombre VARCHAR(30),
	capacidad SMALLINT,
	tiene_proyector BOOLEAN
);

SELECT * FROM aulas;


/* EJERCICIO 8
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla a crear: proveedores (id_proveedor, nombre, contacto, telefono)
*/
CREATE TABLE proveedores (
    id_proveedor INTEGER,
    nombre VARCHAR(60),
    nombre TEXT,
    telefono CHAR(9)
);
-- RPTA: No funciona porque se esta declarando 2 campos con el mismo nombre "nombre" los campos tienen que ser de nombre unico

/* EJERCICIO 9
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla a crear: cobros (id_cobro, cliente, monto, fecha_cobro, cobrado)
*/
CREATE TABLE cobros (
    id_cobro INTEGER,
    cliente VARCHAR(60),
    monto REAL,
    fecha_cobro DATE,
    cobrado BOOLEAN
);
-- RPTA: Funciona, lo malo aqui es que a "monto" se le asigna tipo REAL, para dinero siempre usar NUMERIC(p,e)

/* EJERCICIO 10
   ¿Por qué no funciona? Explica el motivo y cómo corregirla.
   Tabla a crear: Pedidos Clientes (ID Cliente, Nombre Completo, Fecha Pedido, Total)
*/
CREATE TABLE "Pedidos Clientes" (
    "ID Cliente" INTEGER,
    "Nombre Completo" VARCHAR(80),
    "Fecha Pedido" DATE,
    Total NUMERIC(10,2)
);
-- RPTA: Funciona, lo malo aqui es que fuerzas el uso de mayusculas con "", por estya razon hay que tener mucho cuidado al llamar tabla, debe hacerse tambein con "", de lo ocntrario tira error.



