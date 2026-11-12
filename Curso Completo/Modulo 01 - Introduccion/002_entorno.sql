-- ===== CLASE 002: ENTORNO - INSTALACIÓN DE POSTGRESQL Y DBEAVER, CONEXIÓN, INTERFAZ Y ESQUEMA =====

/*
OBJETIVO
Dejar funcionando tu entorno de trabajo: PostgreSQL instalado, DBeaver conectado
a él, y entender dónde vive cada cosa (servidor, base de datos, esquema, tabla).

CONCEPTO
PostgreSQL es el servidor que guarda y procesa los datos. DBeaver es el programa
cliente con el que escribes SQL y ves los resultados. Para que se comuniquen
necesitas una conexión (host, puerto, base de datos, usuario y contraseña).
Dentro de una base de datos, los esquemas funcionan como carpetas que agrupan tablas.

PARA QUÉ SIRVE
1) Tener un entorno local seguro donde practicar sin riesgo de dañar datos reales.
2) Conectarte a bases de datos de una empresa (servidor remoto) con los mismos
   pasos que usarás en un trabajo de análisis de datos.
3) Organizar tablas por área (ventas, rrhh, logística) usando esquemas, para que
   un proyecto analítico no mezcle todo en un solo lugar.

SINTAXIS GENERAL
Parámetros de conexión (se llenan en el formulario de DBeaver, no se escriben en SQL):

   Host:      localhost
   Puerto:    5432
   Base:      postgres
   Usuario:   postgres
   Contraseña: la que definiste al instalar

Forma de nombrar una tabla en SQL:

   SELECT * FROM esquema.tabla;

   - SELECT *   : pide todas las columnas.
   - FROM       : indica de qué tabla se leen los datos.
   - esquema.   : carpeta donde está la tabla (opcional si el esquema está en search_path).
   - tabla      : nombre de la tabla.

-------------------------------------------------------------------------------
INSTALACIÓN Y CONEXIÓN (pasos en orden)
-------------------------------------------------------------------------------
A) Instalar PostgreSQL
   1. Descarga el instalador desde postgresql.org (sección Download, tu sistema operativo).
   2. Ejecútalo y deja marcados PostgreSQL Server y Command Line Tools.
   3. Define la contraseña del usuario "postgres" y anótala: no se puede ver después.
   4. Deja el puerto por defecto 5432 y finaliza la instalación.

B) Instalar DBeaver
   1. Descarga DBeaver Community desde dbeaver.io.
   2. Instálalo con las opciones por defecto y ábrelo.

C) Crear la conexión
   1. Menú Database > New Database Connection (o el icono de enchufe con un +).
   2. Elige PostgreSQL y pulsa Next.
   3. Completa Host, Port, Database, Username y Password (valores de arriba).
   4. Pulsa Test Connection. Si DBeaver pide descargar el driver, acepta.
   5. Si dice "Connected", pulsa Finish.

D) Interfaz de DBeaver
   - Database Navigator (panel izquierdo): árbol de conexiones > bases de datos >
     esquemas > tablas.
   - Editor SQL (centro): donde escribes. Se abre con Ctrl + ] sobre la conexión.
   - Panel de resultados (abajo): muestra las filas devueltas por la consulta.
   - Pestañas de una tabla: Properties (columnas), Data (filas) y Diagram.

Jerarquía completa:

   Servidor PostgreSQL
     └─ Base de datos (postgres)
          └─ Esquema (public, practica, ...)
               └─ Tabla (paises, empleados, ...)

-------------------------------------------------------------------------------
EL ESQUEMA: EJEMPLOS PROGRESIVOS
-------------------------------------------------------------------------------
Todo servidor trae un esquema llamado "public". Además, PostgreSQL usa una lista
llamada search_path: cuando escribes una tabla sin esquema, busca en los esquemas
de esa lista, en orden. Por defecto la lista contiene "public".

Datos de ejemplo de la teoría (ilustrativos, para razonar los resultados):

   Esquema public, tabla ciudades:
   +-----------+--------------+-----------+
   | id_ciudad | nombre       | pais      |
   +-----------+--------------+-----------+
   |         1 | Lima         | Perú      |
   |         2 | Trujillo     | Perú      |
   |         3 | Buenos Aires | Argentina |
   +-----------+--------------+-----------+

   Esquema ventas, tabla clientes:
   +------------+-----------+--------------+
   | id_cliente | nombre    | ciudad       |
   +------------+-----------+--------------+
   |        101 | Marta     | Lima         |
   |        102 | Joaquín   | Buenos Aires |
   +------------+-----------+--------------+

Ejemplo 1: nombre completo (esquema + tabla). Siempre funciona.

   SELECT * FROM public.ciudades;

   Resultado: las 3 filas de ciudades (Lima, Trujillo, Buenos Aires).

Ejemplo 2: sin esquema. Funciona porque "public" está en el search_path.

   SELECT * FROM ciudades;

   Resultado: las mismas 3 filas.

Ejemplo 3: tabla de otro esquema, indicando el esquema.

   SELECT * FROM ventas.clientes;

   Resultado: 2 filas (Marta, Joaquín).

Ejemplo 4: la misma tabla sin esquema, con "ventas" fuera del search_path.

   SELECT * FROM clientes;

   Resultado: error, no devuelve filas.
   ERROR: relation "clientes" does not exist
   PostgreSQL no encontró "clientes" en public, que es lo único que busca.

ERRORES Y BUENAS PRÁCTICAS
- Error: "Connection to localhost:5432 refused". Causa: el servicio de PostgreSQL
  no está iniciado o el puerto del formulario no coincide con el instalado.
- Error: "FATAL: password authentication failed for user postgres". Causa: la
  contraseña escrita no es la definida durante la instalación.
- Error: relation "xxx" does not exist. Causa: la tabla está en otro esquema fuera
  del search_path, o estás conectado a otra base de datos.
- Buena práctica: guarda la contraseña del usuario postgres en un gestor de
  contraseñas y usa Test Connection antes de pulsar Finish.
- Buena práctica: practica en un esquema propio (como "practica") en lugar de
  llenar "public" de tablas de prueba.
*/
