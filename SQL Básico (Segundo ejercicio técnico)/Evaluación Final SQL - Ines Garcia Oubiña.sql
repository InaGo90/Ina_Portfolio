/* Ejercicio técnico del Módulo 2 de Inés García Oubiña, conocida como Ina en la promo52 */

-- Base de Datos Sakila:

USE SAKILA;

 /*1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/
 
 SELECT DISTINCT title
 FROM film;
 
 /*2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/ /*rating*/
 
 SELECT title as '<Parental guidance> TITLE'
	FROM film
	WHERE rating = 'PG-13';
 
 /*3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/
 
 SELECT title as 'Amazing films', description
	FROM film
	WHERE description like '%amazing%';

 /*4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/
 
 SELECT title as 'Lengthy films'
	FROM film
	WHERE length > 120;
 
 /*5. Encuentra los nombres de todos los actores, muestralos en una sola columna que se llame nombre_actor y contenga nombre y apellido.*/
 
 SELECT concat(first_name," ",last_name) as nombre_actor
 FROM actor;

 /*6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/
 
 SELECT first_name as 'FIRST NAME', last_name as 'LAST NAME'
	FROM actor
    WHERE last_name LIKE '%gibson%';
  
 /*7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/
 
 SELECT concat(first_name," ",last_name) as 'ACTOR NAME'
	FROM actor 
	WHERE actor_id BETWEEN 10 AND 20;
    
 /*8. Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".*/
 
 SELECT title as 'Film Title'
	FROM film
    WHERE rating NOT IN ('R','PG-13');
 
 /*9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.*/
 
 SELECT rating 'RATING' , count(rating) as 'TOTAL FILMS'
	FROM film
    GROUP BY rating;

 /*10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/
 
 SELECT c.customer_id as ID, concat(c.first_name," ",c.last_name) as "Customer", count(r.customer_id) as 'Total rents'
	 FROM customer c
	 INNER JOIN rental r
	 ON c.customer_id = r.customer_id
	 GROUP BY r.customer_id;
 
/*11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/

SELECT c.name, count(fc.category_id) as 'Rental Count'
	FROM rental r
	INNER JOIN inventory i
	ON i.inventory_id = r.inventory_id
	INNER JOIN film_category fc
	ON i.film_id = fc.film_id
	INNER JOIN category c
	ON fc.category_id = c.category_id
	GROUP BY c.name;

/*12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/

SELECT rating, round(avg(length),0) as 'Average duration' /*Lo redondeamos porque sale con 4 decimales y queda horrible*/
	FROM film
	GROUP BY rating;

SELECT rating, avg(length) as 'Average duration' /*Aquí está la media original, sin redondeos*/
FROM film
GROUP BY rating;

 /*13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/
 
SELECT concat(a.first_name," ",a.last_name) 'Cast member of "Indian Love"'
	FROM actor a
	INNER JOIN film_actor fa
	ON a.actor_id = fa.actor_id
	INNER JOIN film f
	ON fa.film_id = f.film_id
	WHERE f.title = 'Indian Love';

  /*14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/
  
SELECT title as 'TITLE WITH DOGS OR CATS'
	FROM film
	WHERE description LIKE ('%dog%') OR description LIKE ('%cat%');

/* Yo la haría de la primera forma, pero quizás esta sea más precisa con REGEXP*/

SELECT title as 'TITLE WITH DOGS OR CATS'
	FROM film
	WHERE description REGEXP 'dog|cat';

 /*15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/

SELECT a.actor_id, a.first_name, a.last_name
	FROM actor a 
	LEFT JOIN film_actor fa
	ON a.actor_id = fa.actor_id
	WHERE fa.actor_id IS NULL;

/* Compruebo tambien con subconsulta */

SELECT a.actor_id, a.first_name
	FROM actor a
	WHERE NOT EXISTS ( SELECT *
					FROM film_actor fa
					WHERE a.actor_id = fa.actor_id);

 /*16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
   
SELECT title AS 'Film between 2005/2010'
	FROM FILM
	WHERE release_year BETWEEN 2005 AND 2010;

/* Me aparecen todas las peliculas (500 filas), me parece que todas son del 2006, voy a comprobarlo*/

SELECT title 
	FROM FILM
	WHERE release_year = 2006;  /*Efectivamente todas las peliculas tienen registrado el 2006 como año de lanzamiento en la tabla */

 /*17. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/
 
 SELECT title as 'Family Films'
	FROM film f
	INNER JOIN film_category fc
	ON f.film_id = fc.film_id
	INNER JOIN category c
	ON fc.category_id = c.category_id
	WHERE name = 'Family';
 
 /*18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
 
 SELECT concat(a.first_name," ",a.last_name) 'Actor name', count(*) 'Total films'
	FROM actor a
    INNER JOIN film_actor fa
    ON a.actor_id = fa.actor_id
	GROUP BY fa.actor_id
    HAVING count(*) > 10;

 /*19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/
 
 SELECT title as 'R & Lengthy films'
	FROM film
	WHERE rating = 'R'
	AND length > 120;
 
 /*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/
 
 SELECT c.name as Category , avg(f.length) 'Average'
	 FROM category c
	 INNER JOIN film_category fc
	 ON c.category_id = fc.category_id
	 INNER JOIN film f
	 ON fc.film_id = f.film_id
	 GROUP BY c.name
	 HAVING avg(f.length) > 120;
      
 /*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/
 
  SELECT concat(a.first_name," ",a.last_name) 'Actor name', count(*) 'Total films'
	FROM actor a
    INNER JOIN film_actor fa
    ON a.actor_id = fa.actor_id
	GROUP BY fa.actor_id
    HAVING count(*) >= 5;

 /*22. Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días.
 Luego selecciona las películas correspondientes. 
 Pista: Usamos DATEDIFF para calcular la diferencia entre una fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final)*/
 
 SELECT DISTINCT f.title    -- Le tuve que añadir un distinct porque se me repetían muchas veces
	 FROM film f
		 INNER JOIN inventory i
		 ON f.film_id = i.film_id
		 WHERE EXISTS (SELECT *
			FROM rental r
			WHERE i.inventory_id = r.inventory_id AND datediff(return_date,rental_date) > 5);

 /*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
 Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/
 
SELECT a.actor_id, a.first_name, a.last_name
	FROM actor a
	WHERE a.actor_id NOT IN (
		SELECT DISTINCT fa.actor_id
		FROM film_actor fa
		INNER JOIN film_
		WHERE c.name = 'Horror');

 /*BONUS*/
 
 /*24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film con subconsultas.*/
 
         
SELECT title AS 'Comedy Lengthy films'
FROM film
WHERE film_id IN (
    SELECT f.film_id
		FROM film f
		INNER JOIN film_category fc ON f.film_id = fc.film_id
		INNER JOIN category c ON fc.category_id = c.category_id
		WHERE c.name = 'Comedy') AND film_id IN (SELECT film_id
													FROM film
													WHERE length > 180);
                                                    
-- El ejercicio la pide con Subconsultas y queda hecho, pero aporto también la comparación a usarlo con Join porque considero que en un caso real tiene muchisimo más sentido hacerlo así:

SELECT f.title
FROM film f
INNER JOIN film_category fc
ON f.film_id = fc.film_id
INNER JOIN category c
ON fc.category_id = c.category_id
WHERE f.length > 180 AND c.name = 'Comedy';
 
 /*25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. 
 Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un alias diferente.*/
select * from film_actor;
select * from actor; 

SELECT concat(a.first_name," ",a.last_name) AS actor1 ,  concat(a2.first_name," ",a2.last_name) actor2, COUNT(DISTINCT fa1.film_id) AS 'Total films together'
	FROM actor a
		INNER JOIN film_actor fa1 ON a.actor_id = fa1.actor_id
		INNER JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id > fa2.actor_id
		INNER JOIN actor a2 ON fa2.actor_id = a2.actor_id
		GROUP BY a.actor_id, a.first_name, a.last_name, a2.actor_id, a2.first_name, a2.last_name
		HAVING COUNT(DISTINCT fa1.film_id) >= 1;
