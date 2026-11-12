# Curso Completo de PostgreSQL

Curso completo de **0 a administrador de bases de datos** con **PostgreSQL**, usando **DBeaver** como visualizador y editor SQL.

**172 clases · 16 módulos · 1 proyecto final**

---

## Progreso del curso

`10 / 172 clases` · **5 % completado**

`▰▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱▱`

| Módulo | Tema                             | Avance | Estado |
| :----- | :------------------------------- | -----: | :----: |
| 01     | Fundamentos y Entorno            |  3 / 3 |   🟩   |
| 02     | Tipos de Datos                   |  6 / 6 |   🟩   |
| 03     | Crear y Modificar Estructuras    | 1 / 11 |   🟨   |
| 04     | Manipular Datos                  |  0 / 9 |   ⬜   |
| 05     | Consultas Básicas                | 0 / 14 |   ⬜   |
| 06     | Expresiones y Conversión         |  0 / 5 |   ⬜   |
| 07     | Agregaciones                     | 0 / 13 |   ⬜   |
| 08     | Joins y Operaciones de Conjuntos | 0 / 11 |   ⬜   |
| 09     | Funciones                        | 0 / 18 |   ⬜   |
| 10     | Subconsultas y CTEs              |  0 / 9 |   ⬜   |
| 11     | Window Functions                 | 0 / 12 |   ⬜   |
| 12     | Diseño de Bases de Datos         | 0 / 11 |   ⬜   |
| 13     | Índices y Rendimiento            |  0 / 8 |   ⬜   |
| 14     | Transacciones                    |  0 / 5 |   ⬜   |
| 15     | Avanzado                         | 0 / 21 |   ⬜   |
| 16     | Administración y Ecosistema      | 0 / 11 |   ⬜   |
| PF     | Proyecto Final                   |  0 / 5 |   ⬜   |

> Marca la casilla al terminar cada clase y actualiza los contadores de arriba.

---

## Temario

### Módulo 01 · Fundamentos y Entorno

- [x] **001** — Datos, bases de datos relacionales y SQL: tablas, filas, columnas y PostgreSQL
- [x] **002** — Entorno: instalación de PostgreSQL y DBeaver, conexión, interfaz y esquema
- [x] **003** — Editor SQL en DBeaver: comentarios, ejecución y primer `SELECT * FROM`

### Módulo 02 · Tipos de Datos

- [x] **004** — Números enteros: `SMALLINT`, `INTEGER`, `BIGINT`
- [x] **005** — Números decimales: `NUMERIC`, `REAL`, `DOUBLE PRECISION`
- [x] **006** — Texto: `CHAR`, `VARCHAR`, `TEXT`
- [x] **007** — `BOOLEAN`
- [x] **008** — Fechas y horas: `DATE`, `TIME`, `TIMESTAMP`, `TIMESTAMPTZ`
- [x] **009** — `NULL`: qué es y cómo se comporta

### Módulo 03 · Crear y Modificar Estructuras

- [x] **010** — `CREATE TABLE`
- [ ] **011** — `NOT NULL` y `DEFAULT`
- [ ] **012** — `PRIMARY KEY`
- [ ] **013** — `SERIAL` e `IDENTITY`
- [ ] **014** — `UNIQUE`
- [ ] **015** — `CHECK`
- [ ] **016** — `FOREIGN KEY`
- [ ] **017** — `ALTER TABLE`: agregar, renombrar y eliminar columnas
- [ ] **018** — `ALTER TABLE`: cambiar tipos y constraints
- [ ] **019** — `DROP TABLE` y `TRUNCATE`
- [ ] **020** — Esquemas: organizar tablas y `search_path`

### Módulo 04 · Manipular Datos

- [ ] **021** — `INSERT`: una fila
- [ ] **022** — `INSERT`: varias filas
- [ ] **023** — `UPDATE`
- [ ] **024** — `DELETE`
- [ ] **025** — `RETURNING`
- [ ] **026** — `ON CONFLICT` (upsert)
- [ ] **027** — Importar un CSV con el asistente de DBeaver
- [ ] **028** — Exportar datos desde DBeaver
- [ ] **029** — `COPY`

### Módulo 05 · Consultas Básicas

- [ ] **030** — `SELECT`: elegir columnas específicas
- [ ] **031** — Alias con `AS`
- [ ] **032** — Operadores aritméticos y columnas calculadas
- [ ] **033** — `WHERE` con operadores de comparación
- [ ] **034** — `AND`, `OR` y `NOT`
- [ ] **035** — `IN` y `NOT IN`
- [ ] **036** — `BETWEEN`
- [ ] **037** — `LIKE` e `ILIKE`
- [ ] **038** — `IS NULL` e `IS NOT NULL`
- [ ] **039** — `ORDER BY`
- [ ] **040** — `LIMIT` y `OFFSET`
- [ ] **041** — `DISTINCT`
- [ ] **042** — `DISTINCT ON`
- [ ] **043** — Expresiones regulares: `~` y `~*`

### Módulo 06 · Expresiones y Conversión

- [ ] **044** — `CASE WHEN`
- [ ] **045** — `COALESCE`
- [ ] **046** — `NULLIF`
- [ ] **047** — `CAST`
- [ ] **048** — El operador `::`

### Módulo 07 · Agregaciones

- [ ] **049** — `COUNT`
- [ ] **050** — `SUM` y `AVG`
- [ ] **051** — `MIN` y `MAX`
- [ ] **052** — `GROUP BY` con una columna
- [ ] **053** — `GROUP BY` con varias columnas
- [ ] **054** — `HAVING`
- [ ] **055** — Orden de ejecución de una consulta
- [ ] **056** — `FILTER`
- [ ] **057** — `STRING_AGG`
- [ ] **058** — `ARRAY_AGG`
- [ ] **059** — `GROUPING SETS`
- [ ] **060** — `ROLLUP`
- [ ] **061** — `CUBE`

### Módulo 08 · Joins y Operaciones de Conjuntos

- [ ] **062** — Relaciones entre tablas: por qué existen los `JOIN`
- [ ] **063** — `INNER JOIN`
- [ ] **064** — `LEFT JOIN`
- [ ] **065** — `RIGHT JOIN`
- [ ] **066** — `FULL JOIN`
- [ ] **067** — `CROSS JOIN`
- [ ] **068** — `SELF JOIN`
- [ ] **069** — `JOIN` de más de dos tablas
- [ ] **070** — `UNION` y `UNION ALL`
- [ ] **071** — `INTERSECT`
- [ ] **072** — `EXCEPT`

### Módulo 09 · Funciones

- [ ] **073** — Concatenar texto: `||` y `CONCAT`
- [ ] **074** — `UPPER`, `LOWER`, `INITCAP`
- [ ] **075** — `LENGTH` y `TRIM`
- [ ] **076** — `SUBSTRING` y `POSITION`
- [ ] **077** — `LPAD` y `RPAD`
- [ ] **078** — `REPLACE` y `SPLIT_PART`
- [ ] **079** — `REGEXP_REPLACE`
- [ ] **080** — `FORMAT`
- [ ] **081** — `ROUND`, `CEIL`, `FLOOR`
- [ ] **082** — `MOD`, `ABS`, `POWER`
- [ ] **083** — `CURRENT_DATE` y `NOW`
- [ ] **084** — `INTERVAL`
- [ ] **085** — `AGE`
- [ ] **086** — `EXTRACT`
- [ ] **087** — `DATE_TRUNC`
- [ ] **088** — `TO_CHAR`
- [ ] **089** — `TO_DATE` y `TO_TIMESTAMP`
- [ ] **090** — `GENERATE_SERIES`

### Módulo 10 · Subconsultas y CTEs

- [ ] **091** — Subconsulta en `WHERE`
- [ ] **092** — Subconsulta en `FROM`
- [ ] **093** — Subconsulta en `SELECT`
- [ ] **094** — `EXISTS` y `NOT EXISTS`
- [ ] **095** — `ANY` y `ALL`
- [ ] **096** — CTE con `WITH`
- [ ] **097** — CTEs encadenadas
- [ ] **098** — CTE recursivo
- [ ] **099** — `LATERAL JOIN`

### Módulo 11 · Window Functions

- [ ] **100** — Qué es una función de ventana: `OVER()`
- [ ] **101** — `PARTITION BY`
- [ ] **102** — `ORDER BY` dentro de `OVER`
- [ ] **103** — `ROW_NUMBER`
- [ ] **104** — `RANK` y `DENSE_RANK`
- [ ] **105** — `NTILE`
- [ ] **106** — `LAG` y `LEAD`
- [ ] **107** — `FIRST_VALUE` y `LAST_VALUE`
- [ ] **108** — Agregaciones como funciones de ventana
- [ ] **109** — Acumulados y promedios móviles
- [ ] **110** — Frames: `ROWS` y `RANGE`
- [ ] **111** — Top N por grupo

### Módulo 12 · Diseño de Bases de Datos

- [ ] **112** — Modelado: entidades y relaciones
- [ ] **113** — Diagrama ER en DBeaver
- [ ] **114** — Normalización: primera forma normal (1FN)
- [ ] **115** — Segunda forma normal (2FN)
- [ ] **116** — Tercera forma normal (3FN)
- [ ] **117** — Relaciones 1:N
- [ ] **118** — Relaciones N:M y tablas puente
- [ ] **119** — `ON DELETE` y `ON UPDATE`
- [ ] **120** — Vistas
- [ ] **121** — Vistas materializadas
- [ ] **122** — Secuencias

### Módulo 13 · Índices y Rendimiento

- [ ] **123** — Qué es un índice
- [ ] **124** — Índices B-tree
- [ ] **125** — Índices únicos y compuestos
- [ ] **126** — Índices parciales y de expresión
- [ ] **127** — Índices Hash, GIN, GiST y BRIN
- [ ] **128** — `EXPLAIN`
- [ ] **129** — `EXPLAIN ANALYZE`
- [ ] **130** — `VACUUM` y `ANALYZE`

### Módulo 14 · Transacciones

- [ ] **131** — Qué es una transacción
- [ ] **132** — `BEGIN`, `COMMIT` y `ROLLBACK`
- [ ] **133** — `SAVEPOINT`
- [ ] **134** — Niveles de aislamiento
- [ ] **135** — MVCC y bloqueos

### Módulo 15 · Avanzado

- [ ] **136** — JSON y JSONB: qué son y cómo guardarlos
- [ ] **137** — JSONB: operadores `->` y `->>`
- [ ] **138** — JSONB: `@>` y `jsonb_path`
- [ ] **139** — JSONB: modificar documentos
- [ ] **140** — `ARRAY`
- [ ] **141** — `ENUM`
- [ ] **142** — `UUID`
- [ ] **143** — Rangos
- [ ] **144** — Tipos compuestos y dominios
- [ ] **145** — Funciones SQL
- [ ] **146** — PL/pgSQL: estructura y variables
- [ ] **147** — PL/pgSQL: `IF` y `LOOP`
- [ ] **148** — Procedimientos y `CALL`
- [ ] **149** — `DO $$` y manejo de errores
- [ ] **150** — Triggers I: concepto y función trigger
- [ ] **151** — Triggers II: `BEFORE` y `AFTER`
- [ ] **152** — Búsqueda de texto: `tsvector` y `tsquery`
- [ ] **153** — Búsqueda difusa con `pg_trgm`
- [ ] **154** — Particionamiento por rango
- [ ] **155** — Particionamiento por lista y hash
- [ ] **156** — Foreign data wrappers (`postgres_fdw`)

### Módulo 16 · Administración y Ecosistema

- [ ] **157** — Roles y usuarios
- [ ] **158** — `GRANT` y `REVOKE`
- [ ] **159** — Row-level security
- [ ] **160** — Backup con DBeaver (`pg_dump`)
- [ ] **161** — Restore
- [ ] **162** — Monitoreo con `pg_stat_statements`
- [ ] **163** — Replicación: concepto
- [ ] **164** — Extensiones: PostGIS y TimescaleDB
- [ ] **165** — Conexión con Python: `psycopg2`
- [ ] **166** — SQLAlchemy
- [ ] **167** — pandas con `read_sql`

### Proyecto Final

- [ ] **168** — Diseño del modelo
- [ ] **169** — Carga de datos
- [ ] **170** — Consultas analíticas
- [ ] **171** — Optimización con índices
- [ ] **172** — Presentación del proyecto
