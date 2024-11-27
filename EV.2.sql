-- EVALUACIÓN MÓDULO 2 
-- Alumna: Lola Martorell

USE sakila;

-- Ejercicio 1: Selecciona todos los nombres de las películas sin que aparezcan duplicados

SELECT 
DISTINCT(title)
FROM film;

-- Ejercicio 2: Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"

SELECT 
title, 
rating
FROM film 
WHERE rating = 'PG-13' ;

-- Ejercicio 3: Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción

SELECT 
title, 
description
FROM film
WHERE description LIKE '%amazing%';

-- Ejercicio 4: Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos

SELECT 
title,
length
FROM film
WHERE length > 120;

-- Ejercicio 5: Recupera los nombres de todos los actores

SELECT DISTINCT
first_name
FROM actor; 

-- Ejercicio 6: Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido

SELECT 
first_name AS Nombre,
last_name AS Apellido
FROM actor 
WHERE last_name = 'Gibson';

-- Ejercicio 7: Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20

SELECT 
first_name AS Nombre 
FROM actor
WHERE actor_id BETWEEN 10 AND 20; 


-- Ejercicio 8: Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación

SELECT 
title, 
rating
FROM film 
WHERE rating NOT IN ('R', 'PG-13');

-- Ejercicio 9: Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento

SELECT rating AS clasificación, 
COUNT(film_id) AS número_películas
FROM film 
GROUP BY
clasificación; 

-- Ejercicio 10: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas

SELECT 
customer.customer_id AS id_cliente,
customer.first_name AS nombre,
customer.last_name AS apellido, 
COUNT(rental.rental_id) AS peliculas_alquiladas
FROM customer 
LEFT JOIN rental 
ON customer.customer_id = rental.customer_id
GROUP BY 
customer.customer_id, customer.first_name, customer.last_name;

-- Ejercicio 11: Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres



-- Ejercicio 12: Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración

SELECT 
rating AS clasificación, 
AVG(length) AS promedio_duración_peliculas
FROM film 
GROUP BY 
clasificación;

-- Ejercicio 13: Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"

SELECT 
first_name AS nombre_actor,
last_name AS apellido_actor
FROM actor 
INNER JOIN film_actor 
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE 
UPPER(film.title) = 'Indian Love';

# En este caso usamos UPPER para garantizar una comparación exacta y sin distinción de mayúsculas y minúsculas.
# También podríamos usar LOWER para convertir todo a minúscula. 

-- Ejercicio 14: Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción

SELECT 
title,
description
FROM film
WHERE description LIKE '%dog%' 
OR description LIKE '%cat%'; 

-- Ejercicio 15: Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010

SELECT
title,
release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- Ejercicio 16:  Encuentra el título de todas las películas que son de la misma categoría que "Family"

SELECT 
film.title AS Título
FROM film 
WHERE film.film_id IN (
  SELECT film_category.film_id
  FROM film_category
  WHERE film_category.category_id = (
    SELECT category_id
    FROM category
    WHERE name = 'Family'
  )
);

-- 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film

SELECT title
FROM film
WHERE rating = 'R'
AND length > 120;


--- BONUS 

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas

SELECT 
first_name AS Nombre,
last_name AS Apellido
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY 
actor.actor_id,
Nombre,
Apellido
HAVING COUNT(film_actor.film_id) > 10;

-- Ejercicio 19: Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor

SELECT 
first_name AS Nombre, 
last_name AS Apellido 
FROM actor
LEFT JOIN film_actor 
ON actor.actor_id = film_actor.actor_id
WHERE film_actor.actor_id IS NULL;

# LEFT JOIN: Garantiza que todos los actores de la tabla actor sean incluidos en el resultado, incluso si no han aparecido en ninguna película
# WHERE NULL: Filtra los resultados para mostrar únicamente aquellos actores donde no se encontró una coincidencia en la tabla film_actor. Esto significa que el actor_id en film_actor es nulo para esos actores

-- Ejercicio 20: Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración

SELECT
category.name AS Categoria,
AVG(film.length) AS Promedio_Duracion
FROM category 
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film 
ON film_category.film_id = film.film_id
GROUP BY 
category.name
HAVING AVG(film.length) > 120;

-- Ejercicio 21: Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado

SELECT 
actor.first_name AS Nombre,
actor.last_name AS Apellido,
COUNT(film_actor.film_id) AS Cantidad_Peliculas
FROM actor 
INNER JOIN film_actor  
ON actor.actor_id = film_actor.actor_id
GROUP BY 
actor.actor_id, 
actor.first_name, 
actor.last_name
HAVING COUNT(film_actor.film_id) >= 5;

-- Ejercicio 22: Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes

SELECT 
film.title AS Titulo
FROM film 
INNER JOIN inventory 
ON film.film_id = inventory.film_id
WHERE inventory.inventory_id IN (
        SELECT 
		rental.inventory_id
        FROM rental 
        WHERE DATEDIFF(rental.return_date, rental.rental_date) > 5
    );
    
-- Ejercicio 23: Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores

SELECT 
first_name,
last_name
FROM actor
WHERE actor.actor_id NOT IN (
        SELECT DISTINCT film_actor.actor_id
        FROM film_actor 
        INNER JOIN 
		film_category
        ON film_actor.film_id = film_category.film_id
        INNER JOIN category 
        ON film_category.category_id = category.category_id
        WHERE category.name = 'Horror'
    );
    
-- Ejercicio 24: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film

SELECT 
film.title AS Titulo
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' 
AND film.length > 180;

-- Ejercicio 25: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos