# Clase 009: NULL, qué es y cómo se comporta

## Resumen

**NULL** no es cero, texto vacío ni `FALSE`: representa la ausencia de dato o un dato desconocido. Cualquier operación en la que participa devuelve `NULL`, y la lógica pasa de dos valores a tres: verdadero, falso y desconocido.

## Tabla de contenidos

- [Objetivo](#objetivo)
- [Concepto](#concepto)
- [Para qué sirve en análisis de datos](#para-qué-sirve-en-análisis-de-datos)
- [Sintaxis general](#sintaxis-general)
- [Comportamiento de NULL](#comportamiento-de-null)
  - [NULL no es igual a nada](#null-no-es-igual-a-nada)
  - [NULL contamina la aritmética y la concatenación](#null-contamina-la-aritmética-y-la-concatenación)
  - [Lógica de tres valores](#lógica-de-tres-valores)
  - [NULL dentro de una tabla](#null-dentro-de-una-tabla)
- [Errores frecuentes y buenas prácticas](#errores-frecuentes-y-buenas-prácticas)

## Objetivo

Entender qué es `NULL`, por qué no es un valor común y cómo afecta las comparaciones y los cálculos antes de aprender a filtrarlo (clase 038).

## Concepto

**NULL** no es cero, ni texto vacío, ni `FALSE`: es la ausencia de dato o un dato desconocido. Por eso cualquier operación en la que participa devuelve `NULL`, y la lógica deja de tener dos valores para tener tres: verdadero, falso y desconocido.

## Para qué sirve en análisis de datos

1. Representar campos opcionales: un bono que no se otorgó, una fecha de entrega que todavía no ocurrió, un teléfono que el cliente no dio.
2. Distinguir "no aplica" de "vale cero": una precipitación de `0.0` mm es un dato medido; `NULL` significa "no se midió".
3. Evitar conclusiones falsas: promedios, sumas y conteos tratan los `NULL` de forma especial y pueden cambiar el resultado de un reporte.

## Sintaxis general

- `NULL`: literal que representa el dato ausente.
- `columna = NULL`: comparación incorrecta; siempre devuelve `NULL`.
- `columna IS NULL`: forma correcta de preguntar si falta el dato (clase 038).
- `columna IS NOT NULL`: forma correcta de preguntar si el dato existe.
- `NULL` en un `INSERT`: deja la columna sin valor o aplica el `DEFAULT` (clase 011).

> En DBeaver, las celdas con `NULL` se muestran como `(null)` en color gris. Ese texto no es la cadena `'null'`: es la representación visual de la ausencia de dato.

## Comportamiento de NULL

### NULL no es igual a nada

`NULL` nunca es igual a nada, ni siquiera a otro `NULL`.

```sql
SELECT
    NULL = NULL AS r_igual,
    NULL <> NULL AS r_distinto,
    10 = NULL AS r_numero;
```

| r_igual  | r_distinto | r_numero |
| -------- | ---------- | -------- |
| `(null)` | `(null)`   | `(null)` |

La comparación no puede responder "verdadero" ni "falso": el dato falta, así que la respuesta es "desconocido", que se representa con `NULL`.

### NULL contamina la aritmética y la concatenación

`NULL` contamina la aritmética y la concatenación.

```sql
SELECT
    NULL + 5 AS suma,
    NULL * 0 AS producto,
    'Total: ' || NULL AS texto;
```

| suma     | producto | texto    |
| -------- | -------- | -------- |
| `(null)` | `(null)` | `(null)` |

Multiplicar `NULL` por `0` no da `0`: si el valor es desconocido, el resultado también lo es. Pegar texto a un `NULL` tampoco produce texto.

### Lógica de tres valores

La siguiente tabla muestra el resultado de combinar `TRUE`, `FALSE` y `NULL` con `AND`, `OR` y `NOT`.

| Expresión        | Resultado |
| ---------------- | --------- |
| `TRUE AND NULL`  | `NULL`    |
| `FALSE AND NULL` | `FALSE`   |
| `NULL AND NULL`  | `NULL`    |
| `TRUE OR NULL`   | `TRUE`    |
| `FALSE OR NULL`  | `NULL`    |
| `NULL OR NULL`   | `NULL`    |
| `NOT NULL`       | `NULL`    |

El `NULL` no contagia el resultado en `FALSE AND NULL` (es `FALSE`) ni en `TRUE OR NULL` (es `TRUE`), porque el resultado ya estaba determinado por el otro lado.

### NULL dentro de una tabla

Se observa la diferencia entre un dato ausente y un cero real.

```sql
SELECT *
FROM (VALUES
    (1, 'Ana',  2500.00),
    (2, 'Luis', NULL),
    (3, 'Eva',  0.00)
) AS empleados(id_empleado, nombre, comision);
```

| id_empleado | nombre | comision  |
| ----------- | ------ | --------- |
| `1`         | Ana    | `2500.00` |
| `2`         | Luis   | `(null)`  |
| `3`         | Eva    | `0.00`    |

Ana cobra comisión, Eva cobra comisión cero y de Luis no se sabe: son tres situaciones distintas. Más adelante verás que las funciones de agregación (clases 049 a 051) ignoran los `NULL` al calcular, y que una `PRIMARY KEY` no admite `NULL` (clase 012) mientras que `UNIQUE` sí admite varios (clase 014).

## Errores frecuentes y buenas prácticas

- Filtrar con `WHERE columna = NULL`: no da error, devuelve 0 filas, porque la comparación produce `NULL` y no `TRUE`; se corrige con `IS NULL` (clase 038).
- Asumir que `NULL` es `0`: un `AVG` ignora los `NULL` y el promedio calculado no representa a toda la plantilla; hay que decidir cómo tratarlos.
- Guardar `''` (cadena vacía) como "sin dato": el dato existe y no es `NULL`, así que filtros y cálculos lo tratarán de forma distinta a un `NULL` real.
- Documentar qué significa `NULL` en cada columna: "desconocido" no es lo mismo que "no aplica" y el reporte puede leerse de dos maneras.
- Declarar `NOT NULL` con `DEFAULT` desde el diseño (clases 011 y 015) cuando el dato es obligatorio, en lugar de confiar en que nadie lo deje vacío.
