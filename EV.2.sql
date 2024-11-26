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


