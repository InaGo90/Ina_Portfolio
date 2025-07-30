# Evaluación Final Módulo 2 - SQL

Este repositorio contiene mi solución al ejercicio de evaluación final del Módulo 2 de SQL, utilizando la base de datos Sakila.

## Cómo Ejecutar

1.  Asegúrate de tener un SGBD (como MySQL) instalado.
2.  Importa la base de datos Sakila (incluida en el repositorio).
3.  Ejecuta el archivo SQL.

## Descripción

El ejercicio planteó una serie de consultas SQL de dificultad creciente, abarcando:

* Queries básicas.
* Funciones.
* Joins.
* Subconsultas (simples y correlacionadas)

## Solución Implementada

El archivo `Evaluación Final Módulo 2 - Ines Garcia Oubiña.sql` contiene todas las consultas SQL.

**Aspectos clave de la solución:**

* **Claridad y Eficiencia:** Las queries están escritas de forma clara y una indentación que facilita su lectura.
* **Uso de Funciones y Operadores:** Se manejan distintas y operadores SQL para filtrar, agrupar y manipular datos.
* **Subconsultas y Joins:** Se utilizan subconsultas y Joins según se solicita en los enunciados.
* **Ejercicios BONUS:** Se implementan soluciones para los ejercicios BONUS, siendo estos los que tienen una lógica más complicada detrás.

**Ejemplos Relevantes:**

* **Consulta 14:** Se incluyeron dos soluciones para mostrar el uso de `LIKE` y `REGEXP` para la búsqueda de patrones.
* **Consulta 15:** Se comparó el uso de `LEFT JOIN` con `WHERE IS NULL` y `NOT EXISTS` para encontrar elementos ausentes en una tabla.
* **BONUS 24:** Se resolvió el ejercicio utilizando subconsultas como se pedía, pero también se proporcionó una solución alternativa más eficiente utilizando `JOIN`s, explicando el razonamiento detrás de la elección.
* **BONUS 25:** Se implementó la lógica para encontrar actores que han actuado juntos utilizando un `JOIN` de la tabla `film_actor` consigo misma, manejando la lógica de comparación de pares de actores.

## Autor

Ina G. Oubiña  -  (Promo52)

# bda-modulo-2-evaluacion-final-InaGo90
bda-modulo-2-evaluacion-final-InaGo90 created by GitHub Classroom
