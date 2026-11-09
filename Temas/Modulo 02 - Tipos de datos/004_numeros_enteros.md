# 004 - Números enteros en PostgreSQL: SMALLINT, INTEGER y BIGINT

## Objetivo

Elegir entre `SMALLINT`, `INTEGER` y `BIGINT` según el rango de valores que necesita cada columna.

PostgreSQL ofrece tres tipos para guardar números enteros, es decir, sin parte decimal. Los tres son exactos, no redondean ni pierden precisión, y se diferencian solo en el espacio que ocupan y en el rango de valores que aceptan.

## Comparativa de tipos

| Tipo       | Bytes | Rango                                                  |
| ---------- | ----: | ------------------------------------------------------ |
| `SMALLINT` |     2 | -32.768 a 32.767                                       |
| `INTEGER`  |     4 | -2.147.483.648 a 2.147.483.647                         |
| `BIGINT`   |     8 | -9.223.372.036.854.775.808 a 9.223.372.036.854.775.807 |

## Para qué sirve cada uno

### SMALLINT

Rango corto. Ideal para:

- Edades.
- Cantidad de hijos.
- Piso de un edificio.
- Código de sucursal.

### INTEGER

Rango estándar. Ideal para:

- Identificadores.
- Stock.
- Salarios.
- Cantidad de empleados.

### BIGINT

Rango amplio. Ideal para:

- Contadores que crecen sin techo: visitas, clics, IDs de eventos.
- Montos en centavos de grandes volúmenes de datos.

## Sintaxis general

```sql
CREATE TABLE nombre_tabla (
    columna_chica   SMALLINT,   -- rango corto
    columna_media   INTEGER,    -- rango estándar
    columna_grande  BIGINT      -- rango amplio
);

INSERT INTO nombre_tabla VALUES (1, 100, 5000000000);

SELECT columna_media
FROM nombre_tabla;
```

Los tres tipos aceptan valores negativos, cero y `NULL`. `NULL` no es cero: `NULL` significa "no hay dato". Como ocupan menos bytes que `NUMERIC`, son más livianos de almacenar y de indexar.

## Ejemplo 1: los tres tipos en una misma tabla

```sql
CREATE TEMP TABLE ejemplo_enteros (
    id_muestra      SMALLINT,
    stock_actual    INTEGER,
    visitas_totales BIGINT
);

INSERT INTO ejemplo_enteros (id_muestra, stock_actual, visitas_totales)
VALUES
    (1, 250, 15000000000),
    (2, -3, 0),
    (3, NULL, 9876543210);

SELECT id_muestra,
       stock_actual,
       visitas_totales
FROM ejemplo_enteros;
```

Resultado:

| id_muestra | stock_actual | visitas_totales |
| ---------: | -----------: | --------------: |
|          1 |          250 |     15000000000 |
|          2 |           -3 |               0 |
|          3 |              |      9876543210 |

Se ven negativos, cero y un `NULL` representado como celda vacía. El valor `15000000000` no entraría en un `INTEGER`: por eso esa columna es `BIGINT`.

## Ejemplo 2: cuando el valor no entra en el rango

Cuando el valor no entra en el rango, PostgreSQL rechaza la fila:

```sql
INSERT INTO ejemplo_enteros (id_muestra) VALUES (40000);
```

```text
ERROR: el valor 40000 está fuera del rango del tipo smallint (SQLSTATE 22003)
```

40.000 supera el máximo de `SMALLINT`, que es 32.767. La solución es declarar la columna como `INTEGER` o `BIGINT`, no recortar el dato.

## Ejemplo 3: decimales en una columna entera

```sql
INSERT INTO ejemplo_enteros (id_muestra, stock_actual, visitas_totales)
VALUES (4, 10.7, 99.4);

SELECT id_muestra,
       stock_actual,
       visitas_totales
FROM ejemplo_enteros;
```

Resultado:

| id_muestra | stock_actual | visitas_totales |
| ---------: | -----------: | --------------: |
|          1 |          250 |     15000000000 |
|          2 |           -3 |               0 |
|          3 |              |      9876543210 |
|          4 |           11 |              99 |

PostgreSQL redondea al entero más cercano y no avisa: `10.7` se guarda como `11` y `99.4` como `99`. Es una conversión silenciosa que conviene tener presente.

## Errores comunes y buenas prácticas

### Errores

| Error                                                         | SQLSTATE | Causa                                                          |
| ------------------------------------------------------------- | -------- | -------------------------------------------------------------- |
| `el valor "40000" está fuera del rango del tipo smallint`     | `22003`  | El dato supera el máximo del tipo elegido.                     |
| `el valor "3000000000" está fuera del rango del tipo integer` | `22003`  | Pasa lo mismo un escalón más arriba; ahí corresponde `BIGINT`. |
| `no existe la columna "salario_neto"`                         | `42703`  | El nombre está mal escrito o no pertenece a esa tabla.         |

### Buenas prácticas

- Elegir el tipo más chico que cubra el rango con margen: ahorra espacio sin riesgos.
- Usar `BIGINT` para contadores acumulativos como visitas, clics o IDs de eventos que crecen sin techo.
- No recortar datos para que entren en un tipo más chico: cambiar el tipo de la columna.
- Recordar que insertar decimales en una columna entera produce un redondeo silencioso.

## Resumen rápido

| Necesito guardar                     | Tipo recomendado |
| ------------------------------------ | ---------------- |
| Edades, pisos, códigos cortos        | `SMALLINT`       |
| IDs, stock, salarios                 | `INTEGER`        |
| Visitas, clics, contadores sin techo | `BIGINT`         |

Regla de oro: usar el tipo más pequeño que cubra el rango con margen.
