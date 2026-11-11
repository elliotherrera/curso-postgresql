-- ===== CLASE 001: BASES DE DATOS RELACIONALES Y SQL =====

/*
OBJETIVO
Entender qué es una base de datos relacional, cómo se organiza la información en tablas, filas y
columnas, y qué papel cumplen SQL y PostgreSQL.

CONCEPTO
Un dato es un valor registrado sobre algo (un nombre, un monto, una fecha). Una base de datos
relacional guarda esos datos en tablas, y las tablas se conectan entre sí mediante valores en común.
SQL es el lenguaje para pedirle cosas a esa base de datos, y PostgreSQL es el programa (motor) que
guarda los datos y ejecuta tus instrucciones SQL.

PARA QUÉ SIRVE (casos de uso en análisis de datos)
1. Ventas: consultar millones de pedidos y obtener totales por mes, producto o ciudad.
2. RRHH: cruzar empleados con áreas y salarios para comparar costos de personal.
3. Logística: seguir envíos y detectar entregas atrasadas a partir de registros de despacho.

SINTAXIS GENERAL (adelanto: se estudia a fondo en la clase 003)

    SELECT *          -- que hace: "SELECT" pide datos; "*" significa "todas las columnas"
    FROM nombre_tabla; -- que hace: "FROM" indica de qué tabla se leen los datos; ";" cierra la instrucción

  - SELECT: la acción de leer datos.
  - *: comodín que representa todas las columnas.
  - FROM: introduce el nombre de la tabla de origen.
  - ;: marca el final de la instrucción.

--------------------------------------------------------------------------------------------
1. LAS TABLAS, FILAS Y COLUMNAS
--------------------------------------------------------------------------------------------
Una tabla es una cuadrícula que describe un solo tipo de cosa (clientes, pedidos, productos).
- Cada COLUMNA es una característica de esa cosa y tiene un nombre y un tipo de dato fijo.
- Cada FILA es un registro: una instancia concreta (un cliente, un pedido).
- Cada CELDA (cruce de fila y columna) guarda un único valor.

Datos de ejemplo (solo ilustrativos, viven en estos comentarios):

  clientes
  +------------+---------------+--------+
  | id_cliente | nombre        | ciudad |
  +------------+---------------+--------+
  | 1          | Lucía Gómez   | Lima   |
  | 2          | Mario Ruiz    | Quito  |
  | 3          | Ana Torres    | Bogotá |
  +------------+---------------+--------+

  Tabla: clientes. Columnas: 3 (id_cliente, nombre, ciudad). Filas: 3.

Primera consulta de ejemplo (adelanto; se explica en la clase 003):

  SELECT *
  FROM clientes;

  Resultado esperado: las 3 filas y las 3 columnas tal como aparecen arriba.

La columna id_cliente cumple un rol especial: identifica cada fila de forma única. Se llama
clave primaria (se estudia en la clase 012). Gracias a ella nunca se confunde a dos clientes
que tengan el mismo nombre.

--------------------------------------------------------------------------------------------
2. LA PALABRA "RELACIONAL": TABLAS CONECTADAS
--------------------------------------------------------------------------------------------
En lugar de repetir los datos del cliente en cada pedido, se guarda al cliente una sola vez y
cada pedido apunta a él por su identificador:

  pedidos
  +-----------+------------+----------+-------+
  | id_pedido | id_cliente | producto | monto |
  +-----------+------------+----------+-------+
  | 101       | 1          | Teclado  | 45    |
  | 102       | 1          | Monitor  | 210   |
  | 103       | 3          | Mouse    | 18    |
  | 104       | 2          | Teclado  | 45    |
  +-----------+------------+----------+-------+

La columna id_cliente de pedidos coincide con id_cliente de clientes. Esa coincidencia es la
relación: el pedido 101 y el 102 son de Lucía Gómez (id 1), el 103 es de Ana Torres (id 3) y
el 104 es de Mario Ruiz (id 2).

  SELECT *
  FROM pedidos;

  Resultado esperado: las 4 filas y las 4 columnas de la tabla anterior. Los pedidos no muestran
  el nombre del cliente, solo su id; para ver ambos juntos se usan los JOIN (módulo 8).

Ventajas de separar en tablas: un dato se corrige en un solo lugar, se evitan contradicciones
y la base ocupa menos espacio.

--------------------------------------------------------------------------------------------
3. SQL Y POSTGRESQL: QUIÉN ES QUIÉN
--------------------------------------------------------------------------------------------
- SQL (Structured Query Language) es el idioma: un estándar para consultar y modificar datos.
- PostgreSQL es el sistema gestor de bases de datos (SGBD): software gratuito y de código abierto
  que almacena los datos en disco y ejecuta el SQL que recibe.
- DBeaver es la herramienta visual desde la que escribirás SQL y verás los resultados
  (se instala en la clase 002).
- Una base de datos contiene esquemas, un esquema contiene tablas, una tabla contiene filas.

ERRORES Y BUENAS PRÁCTICAS
- Error: escribir mal una palabra clave. Mensaje típico: ERROR: syntax error at or near "FORM".
  Causa: PostgreSQL no reconoce la palabra mal escrita y no puede interpretar la instrucción.
- Error: consultar una tabla que no existe o está en otro esquema. Mensaje típico:
  ERROR: relation "clientes" does not exist. Causa: el nombre está mal escrito o la tabla
  no se encuentra en el esquema activo.
- Buena práctica: darle a cada tabla un solo tema (clientes por un lado, pedidos por otro) y un
  identificador único por fila.
- Buena práctica: usar nombres de tablas y columnas claros, en minúscula y sin espacios
  (id_cliente, no "Id del Cliente").
*/