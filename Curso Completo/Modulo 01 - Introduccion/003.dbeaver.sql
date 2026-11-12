-- ===== CLASE 003: EDITOR SQL EN DBEAVER: COMENTARIOS, EJECUCIÓN Y PRIMER SELECT * FROM =====

/*
OBJETIVO
Escribir, comentar y ejecutar consultas en el editor SQL de DBeaver, y leer
el contenido completo de una tabla con SELECT * FROM.

CONCEPTO
El editor SQL es la ventana donde escribes instrucciones y DBeaver las envía
a PostgreSQL. Cada instrucción termina en punto y coma (;). El resultado
aparece en el panel inferior, como una tabla de filas y columnas.
Los comentarios son texto que PostgreSQL ignora; sirven para explicar el código.

PARA QUÉ SIRVE (casos de uso en análisis de datos)
1. Revisar rápidamente cómo es una tabla nueva (columnas y filas) antes de analizarla.
2. Documentar una consulta con comentarios para que un colega entienda su propósito.
3. Ejecutar solo una consulta de un archivo largo para probar un cambio sin correr el resto.

SINTAXIS GENERAL
    SELECT *
    FROM nombre_tabla;

    SELECT   -> indica que vas a leer datos.
    *        -> significa "todas las columnas".
    FROM     -> indica de qué tabla se leen.
    nombre_tabla -> la tabla que quieres consultar.
    ;        -> marca el final de la instrucción.

COMENTARIOS
    -- comentario de una línea (todo lo que sigue hasta el fin de línea)
    /* comentario de
       varias líneas */                                                   /*
    Atajo en DBeaver: Ctrl + / comenta o descomenta las líneas seleccionadas.

EJECUCIÓN EN DBEAVER
    Ctrl + Enter  -> ejecuta SOLO la instrucción donde está el cursor.
    Alt + X       -> ejecuta TODO el script (cada instrucción abre su pestaña de resultado).
    Ctrl + ]      -> abre un script SQL nuevo.
    Ctrl + Shift + F -> da formato ordenado al texto seleccionado.
*/

/*
EJEMPLOS (se muestran sobre estas tablas de ejemplo, solo para la teoría)

libros
id_libro | titulo                 | autor          | anio
---------+------------------------+----------------+------
1        | Cien años de soledad   | García Márquez | 1967
2        | Rayuela                | Cortázar       | 1963
3        | La ciudad y los perros | Vargas Llosa   | 1963

editoriales
id_editorial | nombre       | pais
-------------+--------------+----------
1            | Alfaguara    | España
2            | Sudamericana | Argentina
*/

-- EJEMPLO 1: leer una tabla completa
SELECT *
FROM libros;

/* Resultado esperado: las 3 filas y las 4 columnas de libros, tal como
   se ven en la tabla de arriba. */

-- EJEMPLO 2: los comentarios no afectan la ejecución
-- Esta línea es un comentario y PostgreSQL la ignora.
SELECT *
FROM editoriales; -- también puedes comentar al final de una línea

/* Este es un comentario
   de varias líneas. */

/* Resultado esperado: las 2 filas y las 3 columnas de editoriales.
   Nada de lo comentado aparece en el resultado. */

-- EJEMPLO 3: dos instrucciones en un mismo script (se ejecutan con Alt + X)
SELECT *
FROM libros;

SELECT *
FROM editoriales;

/* Resultado esperado: DBeaver muestra dos pestañas de resultado, una con
   las 3 filas de libros y otra con las 2 filas de editoriales.
   Con Ctrl + Enter, en cambio, solo se ejecutaría la instrucción donde
   está el cursor y verías una única pestaña. */

/*
ERRORES Y BUENAS PRÁCTICAS
- Error: SELECT * libros;
  Mensaje típico: ERROR: syntax error at or near "libros".
  Causa: falta la palabra FROM antes del nombre de la tabla.
- Error: SELECT * FROM libro;
  Mensaje típico: ERROR: relation "libro" does not exist.
  Causa: el nombre está mal escrito, o la tabla está en un esquema que no está activo.
- Error: pulsar Ctrl + Enter esperando que corran todas las consultas del archivo.
  Mensaje típico: ninguno; solo se ejecuta la instrucción bajo el cursor.
  Causa: Ctrl + Enter ejecuta una instrucción; para todo el script se usa Alt + X.
- Buena práctica: termina siempre cada instrucción con punto y coma y deja una línea
  en blanco entre instrucciones.
- Buena práctica: escribe un comentario breve sobre qué hace cada consulta y
  usa Ctrl + Shift + F para mantener el código ordenado.
*/

