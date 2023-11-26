SELECT * FROM airbnb.rooms;
SELECT * FROM appstore.apps;
SELECT * FROM bookreview.authors;
SELECT * FROM bookreview.books;
SELECT * FROM bookreview.genders;
SELECT * FROM bookreview.languages;
SELECT * FROM bookreview.locations;
SELECT * FROM bookreview.occupations;
SELECT * FROM bookreview.publishers;
SELECT * FROM bookreview.ratings;
SELECT * FROM bookreview.users;
SELECT * FROM carsonline.cars;
SELECT * FROM carsonline.car_types;
SELECT * FROM carsonline.customers;
SELECT * FROM carsonline.fuel_types;
SELECT * FROM carsonline.genders;
SELECT * FROM carsonline.locations;
SELECT * FROM carsonline.sales;
SELECT * FROM carsonline.transmission_types;
SELECT * FROM hr.employees;
SELECT * FROM job_adverts.jobs;
SELECT * FROM netflix.movies;
SELECT * FROM netflix.series;
SELECT * FROM onlinecampus.courses;
SELECT * FROM playcenter.players;
SELECT * FROM police.cops;
SELECT * FROM police.ranks;
SELECT * FROM police.stations;
SELECT * FROM sakila.actor;
SELECT * FROM sakila.address;
SELECT * FROM sakila.category;
SELECT * FROM sakila.city;
SELECT * FROM sakila.country;
SELECT * FROM sakila.customer;
SELECT * FROM sakila.film;
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.language;
SELECT * FROM sakila.payment;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.staff;
SELECT * FROM sakila.store;
SELECT * FROM spotify.tracks;
SELECT * FROM students_survey.survey;
SELECT * FROM umart.orders;
SELECT * FROM world.city;
SELECT * FROM world.country;
SELECT * FROM world.countrylanguage;

USE sakila;
SELECT 42;
SELECT 100;

SELECT * 
FROM sakila.actor;

SELECT first_name, sum(case when first_name = 'ed' then 1 else 5 end)
FROM sakila.actor
group by 1
order by 1; 
-- 3 first_name starts with Ed

SELECT * 
FROM sakila.actor
WHERE first_name = 'ed';

SELECT 'Hello world';

SELECT 42, 'Hello World';

USE sakila;

SELECT actor_id, first_name,  last_update
FROM actor;

-- extracting just the date from last_update
SELECT actor_id, first_name,  date(last_update) AS Date_last_updated
FROM actor;

-- extracting just the time from last_update
SELECT actor_id, first_name,  time(last_update) AS time_last_updated
FROM actor;

USE world;   

SELECT *
FROM country;

-- update the independence year of some countries (To remove safe mode from editor go to preferences in mySQL workbench tab)
UPDATE world.country
SET IndepYear = 1948
WHERE Name = 'Aruba';

UPDATE world.country
SET IndepYear = 1967
WHERE Name = 'Anguilla';

UPDATE world.country
SET IndepYear = 1967
WHERE Name = 'American Samoa';


SELECT *
FROM country;

-- find the oldest and youngest independent country

SELECT Name, Indepyear AS Youngest_country
FROM country
where indepyear IN (SELECT MAX(Indepyear) FROM country); 
                    
SELECT Name, Indepyear AS oldest_country
FROM country
where indepyear IN (SELECT  MIN(Indepyear) FROM country); 

-- google search says 1949 and china's date has a - so further research has to be done 
                    
                    
SELECT Name, Indepyear, 2023 - Indepyear AS countries_age, 
		population, GNP, GNP/population * 1000 AS GDP, round(GNP/population * 1000, 2) as GDP_Rounded
FROM country;

SELECT CONCAT(Name, ' ',indepyear) AS country_year , CONCAT(Headofstate, ' is the Head of State of ',  Name) AS Country_Head_of_State, CONCAT(Name, ' ',  Headofstate) AS leader, Name, Headofstate, Indepyear
FROM country;

USE sakila; 

SELECT *
FROM customer;

SELECT date(create_date) AS date, date(create_date) + 1 AS ADD_1_DAY
FROM customer;

USE playcenter;

SELECT * 
FROM players;

-- MYSQL 
SELECT player_id, concat(first_name, ' ', last_name) AS full_name,  amount_spent_usd, ROUND(amount_spent_usd * 0.8, 2) AS 'amount_spent_euro'
FROM players;
-- MSSQL 
SELECT player_id, amount_spent_usd, amount_spent_usd * 0.8 AS 'amount_spent_euro'
FROM players;
-- POSTGRES 
SELECT player_id, amount_spent_usd, amount_spent_usd * 0.8 AS "amount_spent_euro"
FROM players;

-- MYSQL 
SELECT player_id, last_name, first_name, amount_spent_usd, 
	   installed_games, ROUND(amount_spent_usd / installed_games, 2) AS 'average_amount_paid'
FROM players;
-- MSSQL 
SELECT player_id, last_name, first_name, amount_spent_usd, 
	   installed_games, amount_spent_usd / installed_games AS 'average_amount_paid'
FROM players;
-- POSTGRES 
SELECT player_id, last_name, first_name, amount_spent_usd, 
	   installed_games, amount_spent_usd / installed_games AS "average_amount_paid"
FROM players;

-- MYSQL 
SELECT player_id, email_address, installed_games, uninstalled_games,
       ROUND(uninstalled_games / installed_games, 2) AS 'installation_ratio'
FROM  players;
-- MSSQL 
SELECT player_id, email_address, installed_games, uninstalled_games,
       uninstalled_games / installed_games AS 'installation_ratio'
FROM  players;
-- POSTGRES 
SELECT player_id, email_address, installed_games, uninstalled_games,
       uninstalled_games / installed_games AS "installation_ratio"
FROM  players;

-- MYSQL 
SELECT player_id, CONCAT(first_name, ' ', last_name) AS 'full_name'
FROM players;
-- MSSQL 
SELECT player_id, first_name + ' ' + last_name AS 'full_name'
FROM players;
-- POSTGRES 
SELECT player_id, first_name || ' ' || last_name AS "full_name"
FROM players;

-- MYSQL 
SELECT player_id, email_address, 
       CONCAT(street_address, ', ', city, ', ', country) AS 'full_address',
       total_playing_minutes, total_playing_minutes  / 60 AS 'total_playing_hours'
FROM   players;
-- MSSQL 
SELECT player_id, email_address, 
       street_address + ', ' + city + ', ', country  AS 'full_address',
       total_playing_minutes / 60 AS 'total_playing_hours'
FROM   players;
-- POSTGRES 
SELECT player_id, email_address, 
       country || ' ' || city || ' ' || street_address AS "full_address",
       total_playing_minutes / 60 AS "total_playing_hours"
FROM   players;

-- MYSQL 
SELECT CONCAT(first_name, ' ' ,last_name, '  preferred language is: ', preferred_language) AS 'player preferred_language'
FROM players;
-- MSSQL 
SELECT first_name + ' ' + last_name + '  preferred language is :'+ preferred_language AS 'player preferred_language'
FROM players;
-- POSTGRES 
SELECT first_name || ' ' || last_name || '  preferred language is :' || preferred_language AS "player preferred_language"
FROM players;

USE sakila;

SELECT DISTINCT last_name
FROM actor;

SELECT DISTINCT first_name
FROM actor;

SELECT DISTINCT first_name, last_name
FROM actor;

USE playcenter;

SELECT *
FROM players;

-- Applies to MySQL, MSSQL & POSTGRES 
SELECT DISTINCT preferred_language 
FROM players;

-- Applies to MySQL, MSSQL & POSTGRES 
SELECT DISTINCT gender 
FROM players;

-- Applies to MySQL, MSSQL & POSTGRES
SELECT DISTINCT age_group 
FROM players;

-- Applies to MySQL, MSSQL & POSTGRES
SELECT DISTINCT gender, age_group 
FROM players
ORDER BY gender;

USE onlinecampus;

-- Write a query to display all of the information inside courses table

-- Applies to MYSQL, MSSQL & POSTGRES
SELECT * 
FROM courses;

-- Write a query to display for each course - 
-- the course_id, price_usd, num_students, and content_duration_minutes
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT course_id, price_usd, num_students, content_duration_minutes
FROM courses;

-- Write a query to display the :
-- a. course_title
-- b. num_students
-- c. positive_reviews + negative_reviews (name this calculation: `total_reviews` for example)
-- d. A new column representing the ratio between the total_reviews & num_students: (positive_reviews + negative_reviews) / num_students

SELECT *
FROM courses;

SELECT course_subject, count(*)
FROM courses
GROUP BY 1
ORDER BY 2 DESC;

-- MYSQL 
SELECT course_title, 
       num_students, 
       positive_reviews + negative_reviews as 'total_reviews', 
      ROUND( (positive_reviews + negative_reviews) / num_students,2) AS 'reviews_ratio', 
      ROUND( (positive_reviews + negative_reviews) / num_students*100,2) AS 'reviews_percentage_ratio'
FROM courses
ORDER BY reviews_percentage_ratio DESC; 
-- MSSQL 
SELECT course_title, 
       num_students, 
       positive_reviews + negative_reviews as 'total_reviews', 
       (positive_reviews + negative_reviews) / num_students AS 'reviews_ratio'
FROM courses; 
-- POSTGRES 
SELECT course_title, 
       num_students, 
       positive_reviews + negative_reviews as "total_reviews", 
       (positive_reviews + negative_reviews) / num_students AS "reviews_ratio"
FROM courses;

-- Write a query to display the course_id, course_title, num_lessons, content_duration_minutes, and a new column representing the average duration for each lecture (content_duration_minutes / num_lessons)
SELECT course_id, course_title, num_lessons, content_duration_minutes, 
		ROUND(content_duration_minutes / num_lessons, 2) As average_lecture_duration
FROM courses
ORDER BY 5 DESC;
-- Write a query to display the

-- a. course_id
-- b. course_title
-- c. num_students
-- d. price_usd (the column represents price in USD)
-- e. Total course revenues in USD (num_students * price_usd)
SELECT course_id, course_title, num_students, price_usd, num_students * price_usd AS 'course_revenues' 
FROM courses;
-- MYSQL 
SELECT course_id, 
       course_title, 
       num_lessons, 
       content_duration_minutes, 
       content_duration_minutes / num_lessons AS 'average_lecture_duration'
FROM courses;
-- MSSQL 
SELECT course_id, 
       course_title, 
       num_lessons, 
       content_duration_minutes, 
       content_duration_minutes / num_lessons AS 'average_lecture_duration'
FROM courses;
-- POSTGRES 
SELECT course_id, 
       course_title, 
       num_lessons, 
       content_duration_minutes, 
       content_duration_minutes / num_lessons AS "average_lecture_duration"
FROM courses;


-- Write a query to display the course_id, and course_subject concatenated with course_title
SELECT course_id, CONCAT(course_subject, "- ", course_title) AS 'course_details'
FROM courses;
-- MYSQL 
SELECT course_id, CONCAT(course_subject, ' - ', course_title ) AS 'course_details'
FROM courses;
-- MSSQL 
SELECT course_id, course_subject + ' - '+ course_title AS 'course_details'
FROM courses;  
-- POSTGRES 
SELECT course_id, course_subject || ' - ' || course_title AS "course_details"
FROM courses; 

-- Write a query to display the course_id, price_usd, content_duration_minutes,
-- and a new column representing the content duration in hours (content_duration_minutes / 60)
SELECT  course_id, price_usd, content_duration_minutes, ROUND(content_duration_minutes / 60) AS content_duration_hour
FROM courses;
-- MYSQL 
SELECT course_id, 
       price_usd, 
       content_duration_minutes, 
       ROUND(content_duration_minutes / 60, 2) AS 'content_duration_hours'
FROM courses;
-- MSSQL 
SELECT course_id, 
       price_usd, 
       content_duration_minutes, 
       content_duration_minutes / 60 AS 'content_duration_hours'
FROM courses;
-- POSTGRES 
SELECT course_id, 
       price_usd, 
       content_duration_minutes, 
       content_duration_minutes / 60 AS "content_duration_hours"
FROM courses;

-- Write a query to display the distinct values in course_subject column
SELECT  DISTINCT course_subject
FROM courses;
SELECT DISTINCT course_subject AS 'unique_list_of_subjects' FROM courses;
-- MSSQL 
SELECT DISTINCT course_subject AS 'unique_list_of_subjects' FROM courses;
-- POSTGRES 
SELECT DISTINCT course_subject AS "unique_list_of_subjects" FROM courses;

-- Write a query to display the unique values in course_level column
SELECT DISTINCT course_level
FROM courses;
-- MYSQL 
SELECT DISTINCT course_level AS 'unique_list_of_levels' FROM courses;
-- MSSQL 
SELECT DISTINCT course_level AS 'unique_list_of_levels' FROM courses;
-- POSTGRES 
SELECT DISTINCT course_level AS "unique_list_of_levels" FROM courses;

-- Write a query to display the distinct combination of values in course_subject and course_level columns
SELECT DISTINCT course_subject, course_level
FROM courses;
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT DISTINCT course_subject, course_level
FROM courses;

-- WHERE operator 
USE world;

SELECT *
FROM country
WHERE surfacearea > 7000000;

SELECT *
FROM country
WHERE year(current_date()) - indepyear < 70;

SELECT *
FROM country
WHERE year(current_date()) - indepyear > 70;


SELECT *
FROM country
WHERE name > 'y';

SELECT *
FROM country
WHERE name > 'yf';

USE Sakila;

SELECT *
FROM rental;

-- DATE() retrieves just the date
SELECT rental_id, DATE(rental_date) AS rent_date, rental_date, inventory_id 
FROM rental;

-- TIME() retrieves just the time
SELECT rental_id, TIME(rental_date) AS rent_time, rental_date, inventory_id 
FROM rental;

-- Alter table to add column and update new column
SELECT *
FROM rental
WHERE DATE(rental_date) = '2005-05-26';

ALTER TABLE rental
ADD COLUMN Return_Datepart date 
AFTER customer_id;

UPDATE rental
SET Return_Datepart = DATE(Return_date)
WHERE rental_id > 0;

ALTER TABLE rental
ADD COLUMN Return_Time time 
AFTER return_date;

UPDATE rental
SET Return_Time = TIME(Return_date)
WHERE rental_id > 0;

SELECT *
FROM rental
WHERE Return_datepart = '2005-05-26';

USE umart;

SELECT *
FROM orders;

-- Write a query to display the row_id, discount, unit_price and 
-- customer_id for all orders made by customer_id 3
-- Applies to MYSQL, MSSQL & POSTGRES 
SELECT row_id, discount, unit_price, customer_id
FROM orders
WHERE Customer_id = 3;

-- Write a query to display the order_id, shipping_cost, and customer_name for all orders made by 'Skyler Youster'
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_id, shipping_cost, customer_name
FROM orders
WHERE customer_name = 'Skyler YOuster';

-- Write a query to display the order_id, order_date, customer_region and customer_country for all orders made before '2012/01/01'
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_id, order_date, customer_region, customer_country
FROM orders
WHERE order_date < '2012-01-01';

-- Write a query to display the customer_segment, customer_id, and customer_name for all customers belong to the 'Corporate' customer_segment
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT DISTINCT customer_segment, customer_id, customer_name
FROM orders
WHERE customer_segment = 'Corporate';

USE sakila;

SELECT *
FROM rental
WHERE customer_id = 318 or customer_id = 281;

SELECT *
FROM rental
WHERE customer_id IN (318, 281);

SELECT *
FROM city
WHERE city IN ('London', 'Dallas');

SELECT *
FROM rental
WHERE return_datepart IN ('2005-06-18', '2005-07-06');

SELECT *
FROM rental
WHERE return_datepart NOT IN ('2005-06-18', '2005-07-06');

SELECT *
FROM rental
WHERE return_datepart BETWEEN '2005-06-18' AND '2005-07-06';

USE umart;

SELECT *
FROM orders;

-- Write a query to display the order_priority, discount, customer_name, 
-- and customer_region for all orders made in the 'Central' or 'West' regions
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_priority, discount, customer_name, customer_region
FROM orders
WHERE customer_region IN ('central', 'west');

-- Write a query to display the order_id, ship_mode, customer_segment, 
-- and product_id for all orders not made by a 'Small Business' or 'Corporate' customer_segment
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_id, ship_mode, customer_segment, product_id
FROM orders
WHERE customer_segment NOT IN ('Small Business', 'Corporate');

-- between operator
-- Write a query to display the order_id, ship_mode, customer_segment, and unit_price for all orders with unit_price in the range of 10-20
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_id, ship_mode, customer_segment, unit_price
FROM orders
WHERE unit_price BETWEEN 10 AND 20;

-- Write a query to display the order_id, discount, unit_price, amount_of_products, 
-- profit and discount for all orders with profit in the range of 100-200
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_id, discount, unit_price, amount_of_products, profit, discount
FROM orders
WHERE profit NOT BETWEEN 100 AND 200;

-- Write a query to display the order_id, discount, unit_price, amount_of_products, 
-- profit and discount for all orders not within profit in the range of 100-200

SELECT order_id, discount, unit_price, amount_of_products, profit, discount
FROM orders
WHERE profit NOT BETWEEN 100 AND 200;

-- like operator
USE World;

SELECT *
FROM Country
WHERE name LIKE 'United Kingdom';

SELECT *
FROM Country
WHERE name LIKE 'United %';

SELECT *
FROM Country
WHERE name LIKE '%m';

SELECT *
FROM Country
WHERE name LIKE '%the%';

SELECT *
FROM Country
WHERE name LIKE '% the %';

SELECT *
FROM Country
WHERE name LIKE '_r%';

SELECT *
FROM Country
WHERE name LIKE '__w%';

SELECT *
FROM Country
WHERE lifeexpectancy LIKE '%.0';

SELECT *
FROM Country
WHERE name LIKE '_% %';

SELECT *
FROM Country
WHERE name NOT LIKE '_% %';

-- Select all records where the first letter of the
-- City is an "a" or a "c" or an "s"

SELECT * 
FROM Country
WHERE Name LIKE "[acs]%";


-- Select all records where the first letter of the
-- City is between "a" to "f"

SELECT * 
FROM Country
WHERE Continent LIKE "[a-f]%";

-- Select all records where the first letter of the City is NOT an "a" or a "c" or an "f"

SELECT * 
FROM Country
WHERE Name LIKE '[!acf]%';


USE Umart;

SELECT *
FROM orders;

-- Write a query to display the customer_id and customer_name for all customers with customer_name starts with an 'E'
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT customer_id, customer_name 
FROM orders
WHERE customer_name LIKE 'E%';

-- Write a query to display the customer_id and customer_name for all customers with customer_name ends with an 'e'
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT customer_id, customer_name 
FROM orders
WHERE customer_name LIKE '%E';

-- Write a query to display the customer_id and customer_name for all customers 
-- with first_name ends with an 'a' and last_name ends with an 'e'
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT customer_id, customer_name 
FROM orders
WHERE customer_name LIKE '%a %E';

-- Write a query to display the customer_id and customer_name for all customers 
-- with customer_name that contains an 'e' (somewhere)
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT customer_id, customer_name 
FROM orders
WHERE customer_name LIKE '%E%';

-- Write a query to display the customer_id and customer_name for all customers with 
-- customer_name starts with an 'E' or 'A'
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT customer_id, customer_name 
FROM orders
WHERE customer_name LIKE 'A%' OR customer_name LIKE 'E%';

-- Write a query to display the customer_id and customer_name for all customers with customer_name ends with an 'e' or 'i'
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT customer_id, customer_name 
FROM orders
WHERE customer_name  LIKE '%E' OR customer_name LIKE '%I';

-- NULL operator
USE World;

SELECT * 
FROM Country
WHERE indepyear IS NULL;

SELECT * 
FROM Country
WHERE indepyear IS NOT NULL;

SELECT name, lead(name) over() as next_name, lag(name) over() as prior_name   
FROM Country;


USE Umart;

-- Write a query to display the customer_id, customer_country, and customer_region for all customers with no region
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT customer_id, customer_country, customer_region
FROM orders
WHERE customer_region IS NULL;


-- AND OR Operator
USE SAKILA;

SELECT film_id, title, rental_duration, rental_rate, length, rating, special_features
FROM Film
WHERE Length BETWEEN 60 AND 90 AND Rating = 'G';

SELECT film_id, title, rental_duration, rental_rate, length, rating, special_features
FROM Film
WHERE Length BETWEEN 60 AND 90 OR Rating = 'G';

SELECT film_id, title, rental_duration, rental_rate, length, rating, special_features
FROM Film
WHERE Length BETWEEN 60 AND 90 OR rental_duration = 3 AND Rating = 'G'; 

-- Each record must satisfy either the first condition or the next 2 conditions to be retrieved
-- AND is first assessed before the OR operator

SELECT film_id, title, rental_duration, rental_rate, length, rating, special_features
FROM Film
WHERE (Length BETWEEN 60 AND 90 OR rental_duration = 3) AND Rating = 'G'; 

USE Umart;

-- Write a query to display the order_priority, discount, shipping_cost, ship_mode and discount for all orders with 'High' order_priority and 'Regular Air' ship_mode
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_priority, discount, shipping_cost, ship_mode, discount
FROM orders
WHERE  order_priority = 'High' AND ship_mode = 'Regular Air';

-- Write a query to display the order_priority, discount, shipping_cost, ship_mode and discount for all orders with 'High' order_priority or 'Regular Air' ship_mode
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_priority, discount, shipping_cost, ship_mode, discount
FROM orders
WHERE  order_priority = 'High' OR ship_mode = 'Regular Air';

-- Write a query to display the order_id, customer_id, customer_region, customer_country, and customer_segment for orders made by:
-- a. customers belong to the 'Small Business' or 'Corporate' customer_segment and:
-- b. customers not living in the ‘North’ or ‘South’ regions
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_id, customer_id, customer_region, customer_country, customer_segment
FROM orders
WHERE customer_segment IN  ('Small Business', 'Corporate') 
		AND customer_region NOT IN ('North', 'South');

-- Write a query to display the order_id, discount, unit_price, profit 
-- and discount for all orders with profit in the range of 100-200 and 
-- discount not in the range of 0.1-0.5
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT order_id, discount, unit_price, profit, discount
FROM orders
WHERE  profit BETWEEN 100 AND 200 AND discount NOT BETWEEN 0.1 AND 0.5;

-- MODULUS & integer division
select 20/5;
select 20/3;
select 200/4;
select 20%3; -- find remainder value
select 20 mod 3; -- find remainder value
select 20 mod 7 ; -- find remainder value

USE Sakila;

-- only retrieve films that their remainder from dividing with 2 is 1 ie odd numbers
SELECT film_id, title, rental_duration, rental_rate, length, rating, special_features
FROM Film
WHERE rental_duration %2 = 1; 

-- only retrieve films that their remainder from dividing with 2 is 0 ie even numbers
SELECT film_id, title, rental_duration, rental_rate, length, rating, special_features
FROM Film
WHERE rental_duration %2 = 0; 

 -- number of times 3 and 4 fits into 20
 select 20 div 3; 
 select 20 div 4; 
 

USE World;

-- Show countries founded on 12th, 15th and 18th century
SELECT name, continent, indepyear
FROM country
WHERE indepyear BETWEEN 1100 AND 1199
	OR indepyear BETWEEN 1400 AND 1499
    OR indepyear BETWEEN 1700 AND 1799; 
    
SELECT name, continent, indepyear, indepyear DIV 100
FROM country
WHERE indepyear DIV 100 IN (11, 14, 17); 

USE umart;

SELECT * 
FROM orders;

-- Write a query to display the order_id, discount, unit_price, and profit.
-- a. Restrict the results to display only orders with profit > 100
-- b. Sort the output by discount in a descending order
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT  order_id, discount, unit_price, profit
FROM orders
WHERE profit > 100
ORDER BY discount DESC;

-- Write a query to display the order_id, discount, unit_price, and profit.
-- a. Restrict the results to display only orders with profit > 100
-- b. Sort the output by discount in a descending order, and then by profit in an ascending order
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT  order_id, discount, unit_price, profit
FROM orders
WHERE profit > 100
ORDER BY discount DESC, profit ASC;


-- Write a query to display the row_id, order_priority, unit_price, shipping_cost and customer_name
-- a. Sort the output by shipping_cost
-- b. Limit your output to the first 5 rows
SELECT row_id, order_priority, unit_price, shipping_cost, customer_name
FROM orders
ORDER BY shipping_cost
LIMIT 5;

-- MSSQL 
SELECT TOP 5 row_id, order_priority, unit_price, shipping_cost, customer_name
FROM orders
ORDER BY shipping_cost;

-- POSTGRES 
SELECT row_id, order_priority, unit_price, shipping_cost, customer_name
FROM orders
ORDER BY shipping_cost
LIMIT 5;

-- Write a query to display the row_id, order_priority, unit_price, shipping_cost and profit
-- a. Sort the output by profit (ascending)
-- b. Limit your output to the first 3 rows
SELECT row_id, order_priority, unit_price, shipping_cost, profit
FROM orders
ORDER BY profit
LIMIT 3;

-- MSSQL 
SELECT TOP 3 row_id, order_priority, unit_price, shipping_cost, profit
FROM orders
ORDER BY profit;
-- POSTGRES 
SELECT row_id, order_priority, unit_price, shipping_cost, profit
FROM orders
ORDER BY profit
LIMIT 3;


USE Netflix;

-- [movies] Write a query to display the title, rating, country, release_year, and director, for all movies directed by Michael Bay.
-- Sort the output by release_year (ascending)
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, rating, country, release_year, director
FROM Movies
WHERE director = 'Michael Bay'
ORDER BY release_year;


-- [movies] Write a query to display the title, country, duration_in_minutes, and date_added, for all movies that were added before March 2011. 
-- Sort the output by duration_in_minutes (ascending)
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, country, duration_in_minutes, date(date_added) AS date
FROM Movies
WHERE DATE(date_added) < '2011-03-01'
ORDER BY duration_in_minutes;

-- [movies] Write a query to display the title, country, duration_in_minutes, and release_year, for all movies that were released between 2014 and 2016.
-- Sort the output by duration_in_minutes (descending)
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, country, duration_in_minutes, release_year
FROM Movies
WHERE release_year BETWEEN 2014 AND 2016
ORDER BY duration_in_minutes DESC;

-- [movies] Write a query to display the title, director, country, and duration_in_minutes,
-- for all movies with duration between 3-4 hours. Sort the output by duration_in_minutes (descending)
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, director, country, duration_in_minutes
FROM Movies
WHERE duration_in_minutes BETWEEN 180 AND 240
ORDER BY duration_in_minutes DESC;

SELECT title, director, country, duration_in_minutes
FROM Movies
WHERE duration_in_minutes/60 BETWEEN 3 AND 4
ORDER BY duration_in_minutes DESC;

-- [series] Write a query to display the title, director, rating, num_of_seasons for all series with 10 to 14 seasons.
-- Sort the output by num_of_seasons (descending)
-- Applies to MYSQL, MSSQL & POSTGRES 
SELECT title, director, rating, num_of_seasons
FROM Series
WHERE num_of_seasons BETWEEN 10 AND 14
ORDER BY num_of_seasons DESC;

-- [series] Write a query to display the title, director, rating, num_of_seasons for all series
-- a. containing value in the director column (diretor not equals null)
-- b. and having num_of_seasons > 7
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, director, rating, num_of_seasons
FROM Series
WHERE director IS NOT NULL AND num_of_seasons > 7
ORDER BY num_of_seasons;

-- [movies] Write a query to display the title, director, cast, country and rating, for all movies having Ryan Reynolds in their cast
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, director, cast, country, rating
FROM Movies
WHERE cast LIKE '%Ryan Reynolds%';
					 
-- [movies] Write a query to display the title, director, cast, country and rating, for all movies having Ryan Reynolds and Nicolas Cage in their cast
-- Applies to MYSQL, MSSQL & POSTGRES 
SELECT title, director, cast, country, rating
FROM Movies
WHERE cast LIKE '%Ryan Reynolds%' AND cast LIKE '%Nicolas Cage%';

-- [movies] Write a query to display the title, director, cast, country, duration_in_minutes, and rating
-- a. for all movies having PG (Parental Guidance) in their rating
-- b. and movie duration is greater than 3 hours
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, director, cast, country, duration_in_minutes, rating
FROM Movies
WHERE rating LIKE '%PG%' AND duration_in_minutes > 180;

-- [series] Write a query to display title, director, cast, country, and release_year for all series released in 2014, 2016, or 2018. 
-- Sort the output by title (ascending)
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT title, director, cast, country, release_year
FROM Series
WHERE release_year IN (2014, 2016, 2018)
ORDER BY title;

-- SCALAR Functions 
SELECT 'Paradise Falls';
SELECT upper('Paradise Falls');
SELECT lower('Paradise Falls');
-- American National Standards Institute ANSI

USE sakila;

SELECT title, upper(title), lower(title), ucase(title)
FROM Film;

-- STRING FUNCTION
SELECT LEFT('Hello', 3);-- show 3 from left letters
SELECT RIGHT('Hello', 3);-- show 3 from right letters
SELECT LENGTH('Hello');-- check how many letters
SELECT REPLACE('Hello World', 'l', '*'); -- replace l with *
SELECT REPLACE('Hello World', 'll', '*'); -- replace ll with *
SELECT REPLACE('Hello World', 'll', ''); -- replace ll with nothing, its case sensitive
SELECT REPLACE('67k', 'k', '000'); -- replace k with 000
SELECT REVERSE('Hello World'); -- reverse the letter order
SELECT SUBSTRING('Hello World', 2, 5);
SELECT POSITION('o' IN 'Hello World');
SELECT CONCAT(SUBSTRING('John', 1, 3), SUBSTRING('Doe', 1, 2), '@gmail.com');
SELECT CONCAT(LEFT('John', 3), LEFT('Doe', 2), '@gmail.com');
SELECT UPPER(CONCAT(SUBSTRING('John', 1, 3), SUBSTRING('Doe', 1, 2), '@gmail.com'));


USE HR;
-- Display the id, first name in lowercase and last name in uppercase, 
-- for all employees whose employee number is in the range between 80 and 150.
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT id, LOWER(first_name) as First_Name, UPPER(last_name) as Last_Name
FROM employees
WHERE id BETWEEN 80 AND 150
ORDER BY id;

-- For each employee, display the:
-- a. first name
-- b. last name
-- c. email address - The email address will be composed of the first letter of first name, 
-- concatenated with the three first letters of last name, concatenated with @gmail.com.
SELECT first_name, last_name, CONCAT(LEFT(first_name, 1), LEFT(last_name, 3),  '@gmail.com') AS email_address
FROM employees;

SELECT first_name, last_name, LOWER(CONCAT(SUBSTRING(first_name, 1, 1), SUBSTRING(last_name, 1, 3),  '@gmail.com')) AS email_address
FROM employees;
-- MSSQL
SELECT first_name , last_name , 
    SUBSTRING(first_name , 1 , 1) + SUBSTRING(last_name , 1 , 3) + '@gmail.com' AS 'Email'
FROM employees;
-- POSTGRES
SELECT first_name , last_name , 
    SUBSTRING(first_name , 1 , 1) || SUBSTRING(last_name , 1 , 3) || '@gmail.com' AS "Email"
FROM employees;

-- Repeat the last query, only this time present the values of Email in lowercase
SELECT first_name, last_name, LOWER(CONCAT(LEFT(first_name, 1), LEFT(last_name, 3),  '@gmail.com')) AS email_address
FROM employees;

SELECT first_name, last_name, CONCAT(SUBSTRING(first_name, 1, 1), SUBSTRING(last_name, 1, 3),  '@gmail.com') AS email_address
FROM employees;
-- MSSQL
SELECT first_name , last_name , 
    LOWER(SUBSTRING(first_name , 1 , 1) + SUBSTRING(last_name , 1 , 3) + '@gmail.com') AS 'Email'
FROM employees;
-- POSTGRES
SELECT first_name , last_name , 
    LOWER(SUBSTRING(first_name , 1 , 1) || SUBSTRING(last_name , 1 , 3) || '@gmail.com') AS "Email"
FROM employees;

-- Write a query to display the id, first_name, last_name and phone_number.
-- In each phone_number replace all dashes ('-') with dots ('.')
SELECT id, first_name, last_name, REPLACE(phone_number, '-', '.') as Phone_Number
FROM employees;
-- MSSQL
SELECT id, first_name, last_name, REPLACE(phone_number, '-', '.') AS 'new_phone_number'
FROM employees;
-- POSTGRESQL
SELECT id, first_name, last_name,REPLACE(phone_number, '-', '.') AS "new_phone_number"
FROM employees;

-- Write a query to display the id, first_name, last_name, job_title, department_id
-- for employees with length of job_title greater than 35 characters
SELECT id, first_name, last_name, job_title, department_id
FROM employees
WHERE LENGTH(job_title) > 35;
-- MSSQL
SELECT id, first_name, last_name, job_title, department_id
FROM employees
WHERE LEN(job_title) > 35;
-- POSTGRES
SELECT id, first_name, last_name, job_title, department_id
FROM employees
WHERE LENGTH(job_title) > 35;

-- Numeric Functions
-- numbers below 5 are rounded down and above 5 is rounded up 
SELECT ROUND(7.458), ROUND(7.685);
SELECT CEIL(7.458), FLOOR(7.558);
SELECT PI();
SELECT ABS(-7.458), ABS(100);
SELECT POW(7, 3), POWER(7, 3), SQRT(25);


-- For each employee, display :
-- a. first_name
-- b. salary
-- c. salary after a raise of 12% (salary * 1.12)
-- d. salary after a raise of 12%, expressed as a whole number (ROUND)
-- e. salary after a raise of 12%, rounded down to the nearest whole number

SELECT first_name, salary, salary * 1.12 as salary_raise, ROUND(salary * 1.12) AS Whole_number, FLOOR(salary * 1.12) AS rounded_down
FROM employees;
-- MSSQL
SELECT first_name , 
       salary , 
       salary * 1.12 AS 'new_salary', 
       ROUND(salary * 1.12 , 0) AS 'new_salary_round', 
       FLOOR(salary * 1.12)  AS 'new_salary_floor'
FROM employees;
-- POSTGRES
SELECT first_name , 
       salary , 
       salary * 1.12 AS "new_salary", 
       ROUND(salary * 1.12, 2) AS "new_salary_round", 
       FLOOR(salary * 1.12)  AS "new_salary_floor"
FROM employees;

-- DATETIME Function
SELECT current_timestamp(); -- todays date and time
SELECT current_date(); -- todays date
SELECT curdate();
SELECT current_time();-- present time
SELECT curtime();

-- to add or subtract from a date
SELECT date_add(curdate(), INTERVAL 2 DAY); -- Adding 2 days to todays date
SELECT date_add(curdate(), INTERVAL -2 DAY); -- Deducting 2 days to todays date
SELECT date_sub(curdate(), INTERVAL 2 DAY); -- deducting 2 days to todays date
SELECT date_add(curdate(), INTERVAL 2 year); -- Adding 2 years to todays date
SELECT date_add(curdate(), INTERVAL 2 MONTH); -- Adding 2 months to todays date
SELECT date_add(curdate(), INTERVAL 2 HOUR); -- Adding 2 Hours to todays date
SELECT curdate() - INTERVAL 2 year + INTERVAL 1 MONTH;-- Deducting 2 years and adding 1 month to todays date

-- Calculating differences

-- Calculating the time difference in year from mentioned date to today ie how many years has gone by
SELECT TIMESTAMPDIFF(YEAR, '1908-03-20', CURRENT_TIMESTAMP);                                              
-- Calculating the time difference in year from mentioned date to today ie how many weeks has gone by
SELECT TIMESTAMPDIFF(WEEK, '1908-03-20', CURRENT_TIMESTAMP);                                  
-- Calculating the time difference in year from mentioned date to today ie how many days has gone by
SELECT TIMESTAMPDIFF(DAY, '1908-03-20', CURRENT_TIMESTAMP); 
-- Calculating the time difference in year from mentioned date to today ie how many hours has gone by
SELECT TIMESTAMPDIFF(HOUR, '1908-03-20', CURRENT_TIMESTAMP);  
-- Calculating the time difference in year from mentioned date to today ie how many minutes has gone by
SELECT TIMESTAMPDIFF(MINUTE, '1908-03-20', CURRENT_TIMESTAMP); 

-- Extracting 
SELECT EXTRACT(MINUTE FROM curdate());
SELECT EXTRACT(DAY FROM curdate());
SELECT DATE(curdate());
SELECT YEAR(curdate());
SELECT DAY(curdate());
SELECT MONTH(curdate());
SELECT MICROSECOND(curdate());
SELECT MONTHNAME(CURDATE());
SELECT DAYNAME(CURDATE());


-- Write a query to display:

-- a. first_name
-- b.hire_date 
-- c. hire_date plus 10 days
-- d. hire_date plus 1 month
-- e. Difference in days between current date and hire_date
SELECT first_name, hire_date, DATE_ADD(hire_date, INTERVAL 10 DAY) AS ten_day_difference, 
		DATE_ADD(hire_date, INTERVAL 1 MONTH) AS one_month_difference, 
		timestampdiff(DAY, hire_date, curdate()) AS Current_day_differece
FROM employees;

SELECT first_name, hire_date, hire_date + INTERVAL 10 DAY AS ten_day_difference, 
		hire_date + INTERVAL 1 MONTH AS one_month_difference, 
		timestampdiff(DAY, hire_date, curdate()) AS Current_day_differece
FROM employees;

-- MSSQL
SELECT first_name , 
       hire_date , 
       DATEADD(DAY, 10, hire_date) AS 'hire_date_plus_10_days', 
       DATEADD(MONTH, 1, hire_date) AS 'hire_date_plus_1_month' , 
       DATEDIFF(DAY, hire_date, GETDATE()) AS 'day_difference_from_today'
FROM employees;
-- POSTGRES
SELECT first_name , 
       hire_date , 
       hire_date + INTERVAL '10 DAY' AS "hire_date_plus_10_days", 
       hire_date + INTERVAL '1 MONTH' AS "hire_date_plus_1_month" , 
       DATE_PART('day', CURRENT_DATE - hire_date) AS "day_difference_from_today"
FROM employees;

USE HR;

-- Write a query to display the first_name, last_name, birth_date, and age for each employee
SELECT first_name, last_name, birth_date, timestampdiff(YEAR, birth_date, curdate()) AS Employees_Age,
		YEAR(curdate()) - YEAR(birth_date)  AS Employees_Age
FROM employees;


-- MSSQL
SELECT first_name , 
         last_name , 
       birth_date, 
       DATEDIFF(YEAR, birth_date, GETDATE()) AS 'Age'
FROM employees;
-- POSTGRES
SELECT first_name , 
         last_name , 
       birth_date, 
         DATE_PART('year', CURRENT_DATE) - DATE_PART('year', birth_date) AS "Age"
FROM employees;

-- Write a query to display the first_name, last_name, and birth_date for employees who were born on the same day and month as today.
-- For example: if today is 2021-02-15, we are looking for all employees born on February 15th, regardless the year
-- Note - depends on the current date, this query may or may not return any results.
SELECT first_name, last_name, birth_date
FROM employees
WHERE MONTH(birth_date) = MONTH(curdate()) AND DAY(birth_date) = DAY(curdate());

-- MSSQL
SELECT first_name, last_name, birth_date
FROM   employees 
WHERE  DAY(birth_date) =   DAY(GETDATE())
AND    MONTH(birth_date) = MONTH(GETDATE());
-- POSTGRES
SELECT first_name, last_name, birth_date
FROM   employees 
WHERE  DATE_PART('month', birth_date) =   DATE_PART('month', CURRENT_DATE)
AND    DATE_PART('day', birth_date) =   DATE_PART('day', CURRENT_DATE);

-- IFNULL FUNCTION, this returns the second data if the first value is null
SELECT IFNULL(NULL, 'HELOO');
SELECT IFNULL(0, 'HELOO');
SELECT IFNULL(' ', 'HELOO');

USE World;

SELECT name, lifeexpectancy, ROUND(IFNULL(Lifeexpectancy, 120), 1) AS Alternative
FROM country;

USE HR;

-- Write a query to display the id, first_name, marital_status, and salary for employees with no marital_status or salary

SELECT id, first_name, marital_status, salary
FROM employees
WHERE marital_status IS NULL OR salary IS NULL;

-- Repeat your last query, only this time:

-- a. replace all marital_status NULL values with 'Unknown Status'

-- b. replace all salary NULL values with 0
SELECT id, first_name, marital_status, salary, IFNULL(marital_status, 'Unknown Status') AS Alternative_marital_status, IFNULL(salary, 0) AS Alternative_salary
FROM employees
WHERE marital_status IS NULL OR salary IS NULL;
-- MSSQL
SELECT id, 
         first_name, 
       ISNULL(marital_status, 'Unknown Status') AS 'marital_status', 
       ISNULL(salary, 0) AS 'salary'
FROM employees
WHERE marital_status IS NULL OR salary IS NULL;
-- POSTGRES
SELECT id, 
         first_name, 
       COALESCE(marital_status, 'Unknown Status') AS "marital_status", 
       COALESCE(salary, 0) AS "salary"
FROM employees
WHERE marital_status IS NULL OR salary IS NULL;

-- CASE STATEMENT
-- Write a query to display first_name, last_name, salary, and a new column (name it 'sal_grades') containing values based on the following logic:

-- a. For salaries between 0 and 500 -> Grade A
-- b. For salaries between 5001 and 15000 -> Grade B
-- c. For salaries between 15001 and 20000 -> Grade C
-- d. Else -> Grade D


-- POSTGRES, MYSQL and MSSQL 
SELECT first_name, last_name, salary,
	CASE WHEN salary BETWEEN 15001 AND 20000 THEN 'Grade C'
		 WHEN salary BETWEEN 5001 AND 15000 THEN 'Grade B'
         WHEN salary BETWEEN 0 and 500 THEN 'Grade A'
         ELSE 'Grade D'
         END AS sal_grades
FROM employees
ORDER BY 4, 3;

-- Write a query to display first_name, last_name, birth_date, age, and a new column (name it 'age_grades') containing values based on the following logic:

-- a. For ages between 0 and 20 -> 0-20
-- b. For age between 21 and 40 -> 21-40
-- c. For age between 41 and 60 -> 41-60
-- d. Else -> 60+

SELECT first_name, last_name, birth_date, TIMESTAMPDIFF(YEAR, birth_date, curdate()) AS age,
	CASE WHEN TIMESTAMPDIFF(YEAR, birth_date, curdate()) BETWEEN 41 AND 60 THEN '41-60'
		 WHEN TIMESTAMPDIFF(YEAR, birth_date, curdate()) BETWEEN 21 AND 40 THEN '21-40'
         WHEN TIMESTAMPDIFF(YEAR, birth_date, curdate()) BETWEEN 0 AND 20 THEN '0-20'
         ELSE '60+'
         END As Age_grades
FROM employees;

-- MSSQL
SELECT first_name , 
         last_name , 
       birth_date, 
       DATEDIFF(YEAR, birth_date, GETDATE())  AS 'age',
       CASE WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 0 AND 20 THEN '0-20'
            WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 21 AND 40 THEN '21-40'
            WHEN DATEDIFF(YEAR, birth_date, GETDATE()) BETWEEN 41 AND 60 THEN '41-60'
            ELSE '+60'
            END AS 'age_grades'
FROM employees;
-- POSTGRES
SELECT first_name , 
         last_name , 
       birth_date, 
       DATE_PART('year', CURRENT_DATE) - DATE_PART('year', birth_date)  AS "age",
       CASE WHEN DATE_PART('year', CURRENT_DATE) - DATE_PART('year', birth_date) BETWEEN 0 AND 20 THEN '0-20'
            WHEN DATE_PART('year', CURRENT_DATE) - DATE_PART('year', birth_date) BETWEEN 21 AND 40 THEN '21-40'
            WHEN DATE_PART('year', CURRENT_DATE) - DATE_PART('year', birth_date) BETWEEN 41 AND 60 THEN '41-60'
            ELSE '+60'
            END AS "age_grades"
FROM employees;

-- [String Functions]
USE job_adverts;
-- a. Write a query to display the job_id, job_title, salary_estimate_min, salary_estimate_max
SELECT job_id, job_title, salary_estimate_min, salary_estimate_max
FROM jobs;
-- b. Repeat your last query, only this time display only the job adverts where salary_estimate_max is less than 105,000
SELECT job_id, job_title, REPLACE(salary_estimate_min, 'K', '000') AS Estimated_Minimum, REPLACE(salary_estimate_max, 'K', '000') AS Estimated_Maximum
FROM jobs
WHERE REPLACE(salary_estimate_max, 'K', '000') < 105000;

-- Display  ompany_name, company_rank, company_size_min, company_size_max where company_size is between 60 and 120
SELECT DISTINCT company_name, company_rank, company_size_min, company_size_max, 
		REPLACE(company_size_min, ' Employees', '') AS edited_min, REPLACE(company_size_max, ' Employees', '') AS edited_max
FROM jobs
WHERE REPLACE(company_size_min, ' Employees', '') > 60 AND 
      REPLACE(company_size_max, ' Employees', '') < 120;
      
-- MSSQL
SELECT DISTINCT company_name, company_rank, company_size_min, company_size_max
FROM jobs
WHERE REPLACE(company_size_min, ' Employees', '') > 60 AND 
      REPLACE(company_size_max, ' Employees', '') < 120;
-- POSTGRES
SELECT DISTINCT company_name, company_rank, company_size_min, company_size_max
FROM jobs
WHERE CAST(REPLACE(company_size_min, ' Employees', '') AS INT) > 60 AND 
      CAST(REPLACE(company_size_max, ' Employees', '') AS INT) < 120;

-- [String Functions]

-- Write a query to display the company_name, company_rank, company_size_min, and company_size_max
-- for companies with more than 60 employees and less than 120 employees
SELECT company_name, company_rank, REPLACE(company_size_min, 'Employees', ' ') AS Minimum_size, REPLACE(company_size_max, 'Employees', ' ')  AS Maximum_size
FROM jobs
WHERE REPLACE(company_size_min, 'Employees', ' ') > 60 AND REPLACE(company_size_max, 'Employees', ' ')  < 120;

-- MSSQL
SELECT DISTINCT company_name, company_rank, company_size_min, company_size_max
FROM jobs
WHERE REPLACE(company_size_min, ' Employees', '') > 60 AND 
      REPLACE(company_size_max, ' Employees', '') < 120;
-- POSTGRES
SELECT DISTINCT company_name, company_rank, company_size_min, company_size_max
FROM jobs
WHERE CAST(REPLACE(company_size_min, ' Employees', '') AS INT) > 60 AND 
      CAST(REPLACE(company_size_max, ' Employees', '') AS INT) < 120;
      
-- [String Functions]

-- Write a query to display the :

-- a. job_id
-- b. job_title in uppercase
-- c. company_name in lowercase
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT job_id, job_title, LOWER(Company_name)
FROM jobs;

-- [String Functions]

-- Write a query to display the:

-- a. job_id, company_name, headquarters_of_company
-- b. first letter of company_name
-- c. first letter of headquarters_of_company

SELECT job_id, company_name, headquarters_of_company, SUBSTRING(company_name, 1, 1) AS Name_First_letter, SUBSTRING(headquarters_of_company, 1, 1) AS HQ_First_letter
FROM jobs;

SELECT job_id, company_name, headquarters_of_company, LEFT(company_name, 1) AS Name_First_letter, LEFT(headquarters_of_company, 1) AS HQ_First_letter
FROM jobs;

-- [String Functions]

-- Write a query to display the :

-- a. job_id
-- b. company_name
-- c. headquarters_of_company
-- d. company_code - a new column containing a concatenation of: the first letter of company_name and the first letter of headquarters_of_company
-- For example : for Google located in Austin, the company_code would be: GA
SELECT job_id, company_name, headquarters_of_company, CONCAT(SUBSTRING(company_name, 1, 1), SUBSTRING(headquarters_of_company, 1, 1)) AS Company_Code
FROM jobs;

-- [String Functions]

-- Repeat your last query, only this time display the company_code in lowercase
SELECT job_id, company_name, headquarters_of_company, LOWER(CONCAT(SUBSTRING(company_name, 1, 1), SUBSTRING(headquarters_of_company, 1, 1))) AS Company_Code
FROM jobs;

-- Write a query to display the :

-- a. job_id
-- b. job_title in uppercase
-- c. company_name in lowercase
-- Applies to MYSQL, MSSQL & POSTGRES
SELECT job_id, UPPER(job_title) AS 'upper_jobtitle', LOWER(company_name) AS 'lower_companyname'
FROM jobs;

-- [String Functions]

-- Write a query to display the job titles with length greater than 29
SELECT distinct job_title, LENGTH(Job_title)
FROM jobs
WHERE LENGTH(Job_title) > 29;
-- MSSQL
SELECT DISTINCT job_title
FROM jobs
WHERE LEN(job_title) > 29;
-- POSTGRES
SELECT DISTINCT job_title
FROM jobs
WHERE LENGTH(job_title) > 29;
-- [Numeric Functions]

-- Write a query to display the:

-- a. company_name
-- b. company_rank
-- c. company_market_value
-- d. company_market_value rounded using ROUND function with precision of 2 digits
-- e. company_market_value rounded down using FLOOR
-- f. company_market_value rounded up using CEIL
SELECT company_name, company_rank, company_market_value, 
		ROUND(company_market_value, 2) AS Round_to_2, FLOOR(company_market_value) AS Round_down, 
        CEIL(company_market_value) AS Round_up
FROM jobs;
-- MSSQL
SELECT company_name, company_rank, company_market_value,
       ROUND(company_market_value, 2) AS 'round_mv',
       FLOOR(company_market_value) AS 'floor_mv',
       CEILING(company_market_value) AS 'ceil_mv'
FROM   jobs;
-- POSTGRES
SELECT company_name, company_rank, company_market_value,
       ROUND(company_market_value, 2) AS "round_mv",
       FLOOR(company_market_value) AS "floor_mv",
       CEILING(company_market_value) AS "ceil_mv"
FROM   jobs;


-- [Date Functions]

-- Write a query to display the job_id, job_title, published_date, and removed_date for all jobs that were published on 2016
SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE YEAR(published_date) = 2016;
-- MSSQL
SELECT job_id, job_title, published_date, removed_date 
FROM jobs
WHERE YEAR(published_date) = 2016;
-- POSTGRES
SELECT job_id, job_title, published_date, removed_date 
FROM jobs
WHERE DATE_PART('year', published_date) = 2016;

-- [Date Functions]
-- Which job adverts were posted during January 2017 ? Display columns you consider relevant
SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE DATE(published_date) BETWEEN '2017-01-01' AND '2017-01-31' AND job_title IS NOT NULL;

SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE YEAR(published_date) = 2017 AND MONTH(published_date) = 01 AND job_title IS NOT NULL;
-- MSSQL
SELECT job_id, job_title, published_date, removed_date 
FROM jobs
WHERE YEAR(published_date) = 2017 AND MONTH(published_date) = 1;
-- POSTGRES
SELECT job_id, job_title, published_date, removed_date 
FROM jobs
WHERE DATE_PART('year', published_date) = 2017 AND DATE_PART('month', published_date) = 1;

-- [Date Functions]

-- Which job adverts were removed after a single day ?
SELECT job_id, job_title, published_date, removed_date, TIMESTAMPDIFF(DAY, published_date, removed_date) as removal_day
FROM jobs
WHERE  TIMESTAMPDIFF(DAY, published_date, removed_date) = 1;

-- MYSQL OPTION 1
SELECT job_id, job_title, published_date, removed_date, DATEDIFF(removed_date, published_date) 
FROM jobs
WHERE DATEDIFF(removed_date, published_date) = 1;

-- MSSQL
SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE DATEDIFF(DAY, published_date, removed_date) = 1;
-- POSTGRES
SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE DATE_PART('day', removed_date - published_date) = 1;

-- [Date Functions]
-- Which job adverts were posted on the same day and month as the current date ?
-- For example, if today is February 11th 2021, which jobs were published on February 11th (regardless the year) ?
SELECT job_id, job_title, published_date
FROM jobs
WHERE MONTH(published_date) = MONTH(curdate()) AND DAY(published_date) = DAY(curdate());
-- MSSQL
SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE DAY(published_date) = DAY(GETDATE())
AND   MONTH(published_date) = MONTH(GETDATE());
-- POSTGRES
SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE DATE_PART('day', published_date) = DATE_PART('day',CURRENT_DATE)
AND   DATE_PART('month', published_date) = DATE_PART('month',CURRENT_DATE);

-- [Date Functions]

-- In a few job adverts, the value of published_date is greater than the removed_date,  those rows represent invalid data.
-- Find those rows 
-- same for postgres and mssql
SELECT job_id, job_title, published_date, removed_date
FROM jobs
WHERE published_date > removed_date;

-- [NULL Related Functions]
-- List the job adverts where at least one of the following conditions is met:
-- a. The row does not contain a value in removed_date
-- b. The row does not contain a value in company_name
-- c. The row does not contain a value in headquarters_of_company
-- Applies to MYSQL, MSSQL & POSTGRES

SELECT job_title, removed_date, company_name, headquarters_of_company
FROM jobs
WHERE removed_date IS NULL OR company_name IS NULL OR headquarters_of_company IS NULL;

-- [NULL Related Functions]
-- Take your previous report and instead of the NULL values:
-- a. Display the current date instead of NULL values in removed_date
-- b. Display the company_state instead of NULL values in headquarters_of_company
-- c. Display 'Not Available' instead of NULL values in company_name
SELECT job_title, IFNULL(removed_date, CURDATE()) AS date_alt, IFNULL(company_name, 'Not Available') AS Name_Alt, 
		IFNULL(headquarters_of_company, state_of_company) AS HQ_Alt
FROM jobs
WHERE removed_date IS NULL OR company_name IS NULL OR headquarters_of_company IS NULL;

-- MSSQL
SELECT job_id, job_title, 
       ISNULL(removed_date, GETDATE()) AS 'removed_date',
       ISNULL(headquarters_of_company, state_of_company) AS 'headquarters_of_company',
       ISNULL(company_name, 'Not Available') AS 'company_name'
FROM jobs 
WHERE removed_date IS NULL OR 
      company_name IS NULL OR 
      headquarters_of_company IS NULL;
      
-- POSTGRES
SELECT job_id, job_title, 
       COALESCE(removed_date, CURRENT_DATE) AS "removed_date",
       COALESCE(headquarters_of_company, state_of_company) AS "headquarters_of_company",
       COALESCE(company_name, 'Not Available') AS "company_name"
FROM jobs 
WHERE removed_date IS NULL OR 
      company_name IS NULL OR 
      headquarters_of_company IS NULL;

-- [Case Statement]

-- Write a query to display the company_name, company_market_value, and a new column : company_market_value_rank, based on the following logic:

-- a. For companies with market_value in the range of 0-300 provide the rank : 'low range'
-- b. For companies with market_value in the range of 301-600 provide the rank : 'mid range'
-- c. For companies with market_value in the range of 601-900 provide the rank : 'high range'
-- d. For any other range provide the rank : 'other range'

SELECT company_name, company_market_value, 
		CASE WHEN company_market_value BETWEEN  0 AND 300 THEN 'low range'
			WHEN company_market_value BETWEEN  301 AND 600 THEN 'mid range'
			WHEN company_market_value BETWEEN  601 AND 900 THEN 'high range'
			ELSE 'other range'
            END AS company_market_value_rank
FROM jobs;
-- MSSQL
SELECT DISTINCT company_name, company_market_value, 
            CASE WHEN company_market_value BETWEEN 0 AND 300 THEN   'low range'
                   WHEN company_market_value BETWEEN 301 AND 600 THEN 'mid range'
             WHEN company_market_value BETWEEN 601 AND 900 THEN 'high range'
                   ELSE 'other range'
            END AS 'company_market_value_rank'
FROM   jobs;
-- POSTGRES
SELECT DISTINCT company_name, company_market_value, 
            CASE WHEN company_market_value BETWEEN 0 AND 300 THEN   'low range'
                   WHEN company_market_value BETWEEN 301 AND 600 THEN 'mid range'
             WHEN company_market_value BETWEEN 601 AND 900 THEN 'high range'
                   ELSE 'other range'
            END AS "company_market_value_rank"
FROM   jobs;
-- [Case Statement]

-- Write a query to display the job_title, company_name, company_size_min, company_size_max, and a new column - company_size, based on the following logic:
-- a. For companies with up to 60 employees, provide the value: ‘Small Company’
-- b. For companies with up to 120 employees, provide the value: ‘Medium Company’
-- c. For companies with up to 180 employees, provide the value: ‘ Large Company’
-- d. For any other range 'Unknown'

SELECT job_title, company_name, company_size_min, company_size_max,
		CASE WHEN REPLACE(company_size_max, 'Employees', ' ') BETWEEN  0 AND 60 THEN 'Small Company'
			WHEN REPLACE(company_size_max, 'Employees', ' ') BETWEEN  61 AND 120 THEN 'Medium Company'
			WHEN REPLACE(company_size_max, 'Employees', ' ') BETWEEN  121 AND 180 THEN 'Large Company'
			ELSE 'Unknown'
            END AS company_size
FROM jobs;
-- MSSQL
SELECT job_title, company_name, company_size_min, company_size_max, 
         CASE WHEN REPLACE(company_size_max, ' Employees', '') <= 60 THEN 'Small Company'
                  WHEN REPLACE(company_size_max, ' Employees', '') <=  120 THEN 'Medium Company'
            WHEN REPLACE(company_size_max, ' Employees', '') <=  180 THEN 'Large Company'
            ELSE 'Unknown'
            END AS 'company_size'
FROM   jobs;
-- POSTGRES
SELECT job_title, company_name, company_size_min, company_size_max, 
         CASE WHEN CAST(REPLACE(company_size_max, ' Employees', '') AS INT) <= 60 THEN 'Small Company'
                  WHEN CAST(REPLACE(company_size_max, ' Employees', '') AS INT) <=  120 THEN 'Medium Company'
            WHEN CAST(REPLACE(company_size_max, ' Employees', '') AS INT) <=  180 THEN 'Large Company'
            ELSE 'Unknown'
            END AS "company_size"
FROM   jobs;

-- Grouping and Aggregate Function
-- min, max, avg, sum, count, distinct count count(distinct)

USE World;

SELECT *
FROM country;

SELECT COUNT(*), COUNT(GNPOLD) 
FROM country; 
-- null values are not counted, only filled in data are counted

-- To include the null values IN Aggregate function																	   
SELECT  COUNT(IFNULL(GNPOLD, 0)), AVG(IFNULL(GNPOLD, 0)), SUM(IFNULL(GNPOLD, 0)) 
FROM country;

USE airbnb;

SELECT *
FROM rooms;

-- Display the average room price (across the entire table)
-- Applies to MSSQL and POSTGRES

SELECT AVG(price) AS average_room_price, ROUND(AVG(price), 2) AS average_room_price_rounded
FROM rooms;

-- Display the highest number of reviews
-- Applies to MSSQL and POSTGRES
SELECT MAX(number_of_reviews) AS Highest_Review
FROM rooms;

SELECT number_of_reviews AS Highest_Review
FROM rooms
ORDER BY number_of_reviews DESC
LIMIT 1;

-- Display the lowest reviews_per_month
-- Applies to MSSQL and POSTGRES
SELECT MIN(reviews_per_month) AS Lowest_Review
FROM rooms;

SELECT reviews_per_month AS Lowest_Review
FROM rooms
WHERE reviews_per_month IS NOT NULL
ORDER BY reviews_per_month
LIMIT 1;

-- Display the number of (not null) values in reviews_per_month
-- Applies to MSSQL and POSTGRES
SELECT COUNT(reviews_per_month) AS Monthly_Review_Count
FROM rooms;

SELECT COUNT(*) AS All_Count
FROM rooms;

-- List the distinct values in neighbourhood_group (no group function is required, just a simple DISTINCT)
-- Applies to MSSQL and POSTGRES
SELECT DISTINCT neighbourhood_group AS unique_neighbourhood_group
FROM rooms;

-- Display the number of unique values in neighbourhood_group
-- Applies to MSSQL and POSTGRES
SELECT COUNT(DISTINCT neighbourhood_group) AS unique_neighbourhood_group_count
FROM rooms;


-- What is the average room price for each neighbourhood_group? Sort the output by the average price (descending)
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood_group, ROUND(AVG(Price), 2) AS average_price
FROM rooms
GROUP BY neighbourhood_group
ORDER BY AVG(Price) DESC;

-- Display the amount of rooms for each price_range
-- Applies to MSSQL and POSTGRES
SELECT price_range, COUNT(*) AS number_of_rooms
FROM rooms
GROUP BY price_range
ORDER BY 2;

-- What is the highest reviews_per_month in each room_type?
-- Applies to MSSQL and POSTGRES
SELECT room_type, MAX(reviews_per_month) AS Max_monthly_review
FROM rooms
GROUP BY room_type;

-- What is the average price for each number_of_reviews_range
-- Applies to MSSQL and POSTGRES
SELECT number_of_reviews_range, ROUND(AVG(Price), 2) AS average_price
FROM rooms
GROUP BY number_of_reviews_range;

SELECT number_of_reviews_range, CONCAT('$', ROUND(AVG(Price), 2)) AS average_price
FROM rooms
GROUP BY number_of_reviews_range;

-- How many rooms can you find in each neighbourhood ? Sort the output by the number of rooms (descending)
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood, COUNT(*) AS Number_of_Rooms
FROM rooms
GROUP BY neighbourhood
ORDER  BY Number_of_Rooms DESC;

-- How many rooms can you find in each neighbourhood_group and neighbourhood ?
-- Sort the output by neighbourhood_group (ascending)
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood, neighbourhood_group, COUNT(*) AS Number_of_Group
FROM rooms
GROUP BY neighbourhood, neighbourhood_group
ORDER  BY neighbourhood_group;

-- Restrict your last query to display only results from Manhattan and Queens
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood, neighbourhood_group, COUNT(neighbourhood_group) AS Number_of_Rooms
FROM rooms
WHERE neighbourhood_group IN ('Manhattan', 'Queens')
GROUP BY neighbourhood, neighbourhood_group
ORDER  BY neighbourhood_group;

-- What is the average number_of_reviews for each neighbourhood_group in Brooklyn ?
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood, AVG(number_of_reviews) AS 'avg_number_of_reviews'
FROM rooms 
WHERE neighbourhood_group = 'Brooklyn'
GROUP BY neighbourhood;

-- What is the average number_of_reviews for each neighbourhood in Brooklyn ?
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood, AVG(number_of_reviews) AS Average_Brooklyn_Review
FROM rooms
WHERE Neighbourhood LIKE '%Brooklyn%'
GROUP BY neighbourhood;

SELECT * 
FROM ROOMS
WHERE neighbourhood_group LIKE '%Brooklyn%';

USE airbnb;

-- List the hosts having more than 100 rooms
-- Applies to MSSQL and POSTGRES
SELECT host_name, COUNT(*) AS number_of_rooms
FROM rooms
GROUP BY host_name
HAVING COUNT(*) > 100;

-- count not equal to 100
SELECT host_name, COUNT(*) AS number_of_rooms
FROM rooms
GROUP BY host_name
HAVING COUNT(*) != 100;

-- List the neighbourhood having average price more than 150
-- Applies to MSSQL and POSTGRES
SELECT Neighbourhood, ROUND(AVG(price), 2) AS average_price
FROM rooms
GROUP BY Neighbourhood
HAVING  AVG(price) > 150
ORDER BY 2 DESC;

-- Further restrict your last query, to retrieve only the neighbourhoods in the Bronx
-- Applies to MSSQL and POSTGRES
SELECT Neighbourhood, ROUND(AVG(price), 2) AS average_price
FROM rooms
WHERE neighbourhood_group = 'Bronx'
GROUP BY Neighbourhood
HAVING  AVG(price) > 150;

select *
from rooms;

-- Display the average number_of_reviews for each neighbourhood_group and room_type. Sort your output by neighbourhood_group (ascending)
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood_group, room_type, AVG(number_of_reviews) AS average_review
FROM rooms
GROUP BY neighbourhood_group, room_type
ORDER BY neighbourhood_group;

-- Restrict your last query to display only rows with average number_of_reviews greater than 20
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood_group, room_type, AVG(number_of_reviews) AS average_review
FROM rooms
GROUP BY neighbourhood_group, room_type
HAVING AVG(number_of_reviews)  > 20
ORDER BY neighbourhood_group;

-- Further restrict your query to display only information related to private rooms
-- Applies to MSSQL and POSTGRES
SELECT neighbourhood_group, room_type, AVG(number_of_reviews) AS average_review
FROM rooms
WHERE room_type = 'private room'
GROUP BY neighbourhood_group, room_type
HAVING AVG(number_of_reviews)  > 20
ORDER BY neighbourhood_group;

USE spotify;

-- List the number of tracks made by each artist. Sort the output by the number of tracks (Descending)
-- Applies to MSSQL and POSTGRES
SELECT artist, COUNT(*) AS number_of_tracks
FROM tracks
GROUP BY artist
ORDER BY COUNT(*) DESC;

-- Display the average duration of tracks by genre. Sort the output by the average duration (Descending)
-- Applies to MSSQL and POSTGRES
SELECT genre, AVG(duration) AS average_track_duration
FROM tracks
GROUP BY genre
ORDER BY AVG(duration) DESC;

-- Display the minimum, maximum, and average danceability of tracks made by Queen and The Beatles
-- Applies to MSSQL and POSTGRES
SELECT artist, MIN(danceability) AS Minimum, MAX(danceability) AS maximum, AVG(danceability) AS average
FROM tracks
WHERE artist IN ('Queen', 'The Beatles')
GROUP BY artist;

-- Pop music consists of different genres, for example: Art Pop, Dance Pop, and Candy Pop are all Pop music genres.
-- How many pop music genres are listed in this dataset ?
-- Applies to MSSQL and POSTGRES
SELECT COUNT(DISTINCT genre)
FROM tracks
WHERE genre LIKE '%pop%';


-- Display the number of tracks, highest popularity, and lowest popularity each rock music artist has achieved.
-- Sort the output by the number of tracks (descending)
-- Applies to MSSQL and POSTGRES
SELECT artist, COUNT(*) AS number_of_tracks, MAX(popularity) AS highest_popularity, MIN(popularity) AS lowest_popularity
FROM tracks
WHERE genre LIKE '%rock%'
GROUP BY artist
ORDER BY COUNT(*) DESC;


-- Tracks by genre
-- a. List the number of tracks by each genre, for tracks released during 2005-2010.
-- b. Further restrict your result to display only genres with more than 10 tracks
-- Applies to MSSQL and POSTGRES
SELECT genre, COUNT(*) AS number_of_tracks
FROM tracks
WHERE release_year BETWEEN 2005 AND 2010
GROUP BY genre
HAVING COUNT(*) > 10;

-- List the number of tracks released by Coldplay each year. Sort the output by release_year (ascending)
-- Applies to MSSQL and POSTGRES
SELECT artist, release_year, COUNT(*) as number_of_tracks
FROM tracks
WHERE artist = 'Coldplay'
GROUP BY artist, release_year
ORDER BY release_year;

-- Join
USE police;

SELECT *
FROM cops;

SELECT *
FROM ranks;

SELECT *
FROM stations;

SELECT *
FROM cops as c
JOIN stations as s
ON c.station_id = s.station_id;

SELECT *
FROM cops as c
JOIN stations as s
USING (station_id);


-- [users and genders]
USE Bookreview;
-- a. Write a query to display the first_name, last_name, email, birthdate, and gender for all users
-- b. Restrict your query to display only users who were born on 2002
-- c. Write a query to display the number of users who were born each year. Sort the output by year (ascending)
-- d. Repeat your last query, only this time display only years with more than 54 users (who were born on that year)
SELECT u.first_name, u.last_name, u.email, u.birthdate, g.gender
FROM users AS u
JOIN genders AS g
ON u.gender_id = g.gender_id
WHERE YEAR(birthdate) = 2002;

SELECT YEAR(u.birthdate), COUNT(*) AS number_of_users
FROM users AS u
JOIN genders AS g
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
ORDER BY YEAR(u.birthdate);

SELECT YEAR(u.birthdate), COUNT(*) AS number_of_users
FROM users AS u
JOIN genders AS g
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
HAVING COUNT(*) > 54
ORDER BY YEAR(u.birthdate);

--  a. Write a query to display the first_name, last_name, email, birthdate, and gender for all users
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT u.first_name, u.last_name, u.email, u.birthdate, g.gender
FROM   users u 
JOIN genders g 
ON u.gender_id = g.gender_id;

-- b. Restrict your query to display only users who were born on 2002
-- MYSQL
SELECT u.first_name, u.last_name, u.email, u.birthdate, g.gender
FROM   users u 
JOIN genders g 
ON u.gender_id = g.gender_id
WHERE YEAR(u.birthdate) = 2002;
-- MSSQL
SELECT u.first_name, u.last_name, u.email, u.birthdate, g.gender
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
WHERE YEAR(u.birthdate) = 2002;
-- POSTGRES
SELECT u.first_name, u.last_name, u.email, u.birthdate, g.gender
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
WHERE DATE_PART('year', u.birthdate) = 2002;

-- c. Write a query to display the number of users who were born each year. Sort the output by year (ascending)
-- MYSQL
SELECT YEAR(u.birthdate) AS 'year_of_birth', COUNT(*) AS 'num_of_users'
FROM   users u 
JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
ORDER BY YEAR(u.birthdate);
-- MSSQL
SELECT YEAR(u.birthdate) AS 'year_of_birth', COUNT(*) AS 'num_of_users'
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
ORDER BY YEAR(u.birthdate);
-- POSTGRES
SELECT DATE_PART('year', u.birthdate) AS "year_of_birth", COUNT(*) AS "num_of_users"
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY DATE_PART('year', u.birthdate)
ORDER BY DATE_PART('year', u.birthdate);

-- d. Repeat your last query, only this time display only years with more than 54 users (who were born on that year)
-- MYSQL
SELECT YEAR(u.birthdate) AS 'year_of_birth', COUNT(*) AS 'num_of_users'
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
HAVING COUNT(*) > 54
ORDER BY YEAR(u.birthdate);
-- MSSQL
SELECT YEAR(u.birthdate) AS 'year_of_birth', COUNT(*) AS 'num_of_users'
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY YEAR(u.birthdate)
HAVING COUNT(*) > 54
ORDER BY YEAR(u.birthdate);
-- POSTGRES
SELECT DATE_PART('year', u.birthdate) AS "year_of_birth", COUNT(*) AS "num_of_users"
FROM   users u JOIN genders g 
ON u.gender_id = g.gender_id
GROUP BY DATE_PART('year', u.birthdate)
HAVING COUNT(*) > 54
ORDER BY DATE_PART('year', u.birthdate);

-- [users and locations]

-- a. Write a query to display the first_name, last_name, email, birthdate, country and city for all users
-- b. Restrict your query to display only users living in the UK
-- c. Write a query to break down the number of users living in each country and city. Sort the output by the number of users (descending)
-- d. Restrict your query to count only users above the age 30
-- e. Restrict your query to count only users above the age 30 and users living in the UK
SELECT u.first_name, u.last_name, u.email, u.birthdate, l.country, l.city
FROM users AS u
JOIN locations AS l
ON u.location_id = l.location_id
WHERE l.country = 'United Kingdom';

SELECT l.country, L.city, COUNT(*) AS number_of_users
FROM users AS u
JOIN locations AS l
ON u.location_id = l.location_id
WHERE timestampdiff(year, birthdate, curdate()) > 30 
GROUP BY l.country, l.city
ORDER BY l.country, number_of_users DESC;

SELECT l.country, L.city, COUNT(*) AS number_of_users
FROM users AS u
JOIN locations AS l
ON u.location_id = l.location_id
WHERE timestampdiff(year, birthdate, curdate()) > 30 AND l.country = 'United Kingdom'
GROUP BY l.country, l.city
ORDER BY l.country, number_of_users DESC;

-- a. Write a query to display the first_name, last_name, email, birthdate, country and city for all users
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT u.first_name, u.last_name, u.email, u.birthdate, l.country, l.city
FROM users u 
JOIN locations l 
ON u.location_id = l.location_id;

-- b. Restrict your query to display only users living in the UK
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT u.first_name, u.last_name, u.email, u.birthdate, l.country, l.city
FROM users u 
JOIN locations l 
ON u.location_id = l.location_id
WHERE country = 'United Kingdom';

-- c. Write a query to break down the number of users living in each country and city. Sort the output by the number of users (descending)
-- MYSQL
SELECT l.country, l.city, COUNT(*) AS 'number_of_users'
FROM users u JOIN locations l 
ON u.location_id = l.location_id
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;
-- MSSQL
SELECT l.country, l.city, COUNT(*) AS 'number_of_users'
FROM users u JOIN locations l 
ON u.location_id = l.location_id
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;
-- POSTGRES
SELECT l.country, l.city, COUNT(*) AS "number_of_users"
FROM users u JOIN locations l 
ON u.location_id = l.location_id
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;

-- d. Restrict your query to count only users above the age 30
-- MYSQL
SELECT l.country, l.city, COUNT(*) AS 'number_of_users'
FROM users u JOIN locations l 
ON u.location_id = l.location_id
WHERE YEAR(CURDATE()) - YEAR(birthdate) > 30
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;

SELECT l.country, l.city, COUNT(*) AS 'number_of_users'
FROM users u JOIN locations l 
ON u.location_id = l.location_id
WHERE timestampdiff(year, birthdate, curdate())  > 30
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;

-- MSSQL
SELECT l.country, l.city, COUNT(*) AS 'number_of_users'
FROM users u JOIN locations l 
ON u.location_id = l.location_id
WHERE YEAR(GETDATE()) - YEAR(birthdate) > 30
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;
-- POSTGRES
SELECT l.country, l.city, COUNT(*) AS "number_of_users"
FROM users u JOIN locations l 
ON u.location_id = l.location_id
WHERE DATE_PART('year', CURRENT_DATE) - DATE_PART('year', birthdate) > 30
GROUP BY l.country, l.city
ORDER BY COUNT(*) DESC;

-- [users and occupations]

-- a. Write a query to display the first_name, last_name, email, age, and occupation_name for all users
-- b. Write a query to display the average age for each occupation
-- c. Restrict your query to display only occupations with average age greater than 40
SELECT u.first_name, u.last_name, u.email, timestampdiff(year, u.birthdate, curdate()) AS age, o.occupation_name
FROM users AS u 
JOIN occupations AS o
ON u.occupation_id = o.occupation_id;

SELECT o.occupation_name, ROUND(AVG(timestampdiff(year, u.birthdate, curdate())), 2) AS Average_age 
FROM users AS u 
JOIN occupations AS o
ON u.occupation_id = o.occupation_id
GROUP BY o.occupation_name
HAVING AVG(timestampdiff(year, u.birthdate, curdate())) > 40;

-- a. Write a query to display the first_name, last_name, email, age, and occupation_name for all users
-- MYSQL
SELECT u.first_name, u.last_name, u.email, TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE()) AS 'age', o.occupation_name
FROM users u 
JOIN occupations o 
ON u.occupation_id = o.occupation_id;
-- MSSQL
SELECT u.first_name, u.last_name, u.email, DATEDIFF(YEAR, u.birthdate, GETDATE()) AS 'age', o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id;
-- POSTGRES
SELECT u.first_name, u.last_name, u.email, 
       DATE_PART('year', CURRENT_DATE) - DATE_PART('year', u.birthdate) AS "age", 
     o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id;

-- b. Write a query to display the average age for each occupation
-- MYSQL
SELECT o.occupation_name, AVG(TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE())) AS 'avg_age'
FROM users u 
JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name;
-- MSSQL
SELECT AVG(DATEDIFF(YEAR, u.birthdate, GETDATE())) AS 'avg_age', o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name;
-- POSTGRES
SELECT AVG(DATE_PART('year', CURRENT_DATE) - DATE_PART('year', u.birthdate)) AS "avg_age", o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name;

-- c. Restrict your query to display only occupations with average age greater than 40
-- MYSQL
SELECT AVG(TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE())) AS 'avg_age', o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name
HAVING AVG(TIMESTAMPDIFF(YEAR, u.birthdate, CURDATE())) > 40;
-- MSSQL
SELECT AVG(DATEDIFF(YEAR, u.birthdate, GETDATE())) AS 'avg_age', o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name
HAVING AVG(DATEDIFF(YEAR, u.birthdate, GETDATE())) > 40;
-- POSTGRES
SELECT AVG(DATE_PART('year', CURRENT_DATE) - DATE_PART('year', u.birthdate)) AS "avg_age", o.occupation_name
FROM users u JOIN occupations o 
ON u.occupation_id = o.occupation_id 
GROUP BY o.occupation_name
HAVING AVG(DATE_PART('year', CURRENT_DATE) - DATE_PART('year', u.birthdate)) > 40;

-- [books and authors]

-- Write a query to display the average num_pages for each author. Sort the output by the average number of pages (descending)
SELECT a.authors, floor(AVG(num_pages)) AS average_num_pages 
FROM books AS b
JOIN authors AS a
ON b.author_id = a.author_id
GROUP BY authors
ORDER BY average_num_pages DESC;
-- MYSQL
SELECT authors, AVG(num_pages) AS 'average_num_pages'
FROM books b 
JOIN authors a 
ON b.author_id = a.author_id
GROUP BY authors
ORDER BY AVG(num_pages) DESC;
-- MSSQL
SELECT authors, AVG(num_pages) AS 'average_num_pages'
FROM books b JOIN authors a 
ON b.author_id = a.author_id
GROUP BY authors
ORDER BY AVG(num_pages) DESC;
-- POSTGRES
SELECT authors, AVG(num_pages) AS "average_num_pages"
FROM books b JOIN authors a 
ON b.author_id = a.author_id
GROUP BY authors
ORDER BY AVG(num_pages) DESC;
-- [books and languages]

-- Write a query to display the number of books for each language, Sort the output by the number of books (descending)
SELECT l.language_name, COUNT(*) AS number_of_books
FROM books AS b
JOIN languages AS l
ON b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(*) DESC;

-- MYSQL
SELECT language_name, COUNT(*) AS 'num_of_book'
FROM books b 
JOIN languages l 
ON   b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(*) DESC;
-- MSSQL
SELECT language_name, COUNT(*) AS 'num_of_book'
FROM books b JOIN languages l 
ON   b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(*) DESC;
-- POSTGRES
SELECT language_name, COUNT(*) AS "num_of_book"
FROM books b JOIN languages l 
ON   b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(*) DESC;
-- [books and languages]

-- Write a query to display the number of unique publishers by each language, Sort the output by the number of unique publishers (descending)
SELECT language_name, COUNT(DISTINCT Publisher_id)
FROM books AS b
JOIN languages AS l
ON b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(DISTINCT Publisher_id) DESC;

-- MYSQL
SELECT l.language_name, COUNT(DISTINCT publisher_id) AS 'num_of_publishers'
FROM books b JOIN languages l
ON   b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(DISTINCT publisher_id) DESC;
-- MSSQL
SELECT l.language_name, COUNT(DISTINCT publisher_id) AS 'num_of_publishers'
FROM books b JOIN languages l
ON   b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(DISTINCT publisher_id) DESC;
-- POSTGRES
SELECT l.language_name, COUNT(DISTINCT publisher_id) AS "num_of_publishers"
FROM books b JOIN languages l
ON   b.language_code = l.language_code
GROUP BY l.language_name
ORDER BY COUNT(DISTINCT publisher_id) DESC;

-- [users, occupations and locations]

-- a. Write a query to display the first_name, last_name, email, birthdate, occupation_name, country and city for all users
-- b. Write a query to breakdown the number of users for each country and occupation
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT u.first_name, u.last_name, u.email, u.birthdate, o.occupation_name, l.country, l.city
FROM users AS u 
JOIN occupations AS o
ON   u.occupation_id = o.occupation_id
JOIN locations as l
ON l.location_id = u.location_id;
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT l.country, o.occupation_name, COUNT(*) AS number_of_users
FROM users AS u 
JOIN occupations AS o
ON   u.occupation_id = o.occupation_id
JOIN locations as l
ON l.location_id = u.location_id
GROUP BY l.country, o.occupation_name;

-- [ratings, books and users]

-- a. Write a query to display the rating_id, rating_date, rating, book title, and user's full name for each rating
-- b. Restrict your query to display ratings related to the 'Harry Potter' book-series
-- c. How many unique users have rated titles related to the 'Harry Potter' book-series?
SELECT r.rating_id, r.rating_date, r.rating, b.title, CONCAT(u.first_name, " ", u.last_name) AS full_name
FROM books AS b
JOIN ratings  AS r
ON   b.book_id = r.book_id
JOIN users as u
ON u.user_id = r.user_id
WHERE b.title LIKE '%Harry Potter%';

SELECT COUNT(DISTINCT u.user_id) AS unique_user_count
FROM books AS b
JOIN ratings  AS r
ON   b.book_id = r.book_id
JOIN users as u
ON u.user_id = r.user_id
WHERE b.title LIKE '%Harry Potter%';
-- MSSQL
SELECT r.rating_id, r.rating_date, r.rating,
       b.title, 
       u.first_name + ' ' + u.last_name AS 'full_name'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
          JOIN users u
ON u.user_id = r.user_id;
-- POSTGRES
SELECT r.rating_id, r.rating_date, r.rating,
       b.title, 
       u.first_name || ' ' || u.last_name AS "full_name"
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
          JOIN users u
ON u.user_id = r.user_id;

-- b. Restrict your query to display ratings related to the 'Harry Potter' book-series 
-- MYSQL
SELECT r.rating_id, r.rating_date, r.rating,
       b.title, 
       CONCAT(u.first_name, ' ', u.last_name) AS 'full_name'
FROM ratings r 
JOIN books b 
	ON r.book_id = b.book_id 
JOIN users u
	ON  u.user_id = r.user_id
WHERE b.title LIKE '%harry potter%';
-- MSSQL
SELECT r.rating_id, r.rating_date, r.rating,
       b.title, 
       u.first_name + ' ' + u.last_name AS 'full_name'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
WHERE b.title LIKE '%harry potter%';
-- POSTGRES
SELECT r.rating_id, r.rating_date, r.rating,
       b.title, 
       u.first_name || ' ' || u.last_name AS "full_name"
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
WHERE b.title LIKE '%Harry Potter%';

-- c. How many unique users have rated titles related to the 'Harry Potter' books-series?
-- MYSQL
SELECT COUNT(DISTINCT u.user_id) AS 'number_of_users'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
JOIN users u
ON  u.user_id = r.user_id
WHERE b.title LIKE '%harry potter%';
-- MSSQL
SELECT COUNT(DISTINCT u.user_id) AS 'number_of_users'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
WHERE b.title LIKE '%harry potter%';
-- POSTGRES
SELECT COUNT(DISTINCT u.user_id) AS "number_of_users"
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
JOIN users u
ON  u.user_id = r.user_id
WHERE b.title LIKE '%harry potter%';

-- [ratings, books, users and locations]

-- How many unique users have rated titles related to the 'Harry Potter' book-series. Break down your result by each country
-- MYSQL
SELECT  l.country, COUNT(DISTINCT u.user_id) AS 'number_of_users'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
				JOIN locations l
ON  u.location_id = l.location_id
WHERE b.title LIKE '%harry potter%'
GROUP BY l.country;
-- MSSQL
SELECT  l.country, COUNT(DISTINCT u.user_id) AS 'number_of_users'
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
        JOIN locations l
ON  u.location_id = l.location_id
WHERE b.title LIKE '%harry potter%'
GROUP BY l.country;
-- POSTGRES
SELECT  l.country, COUNT(DISTINCT u.user_id) AS "number_of_users"
FROM ratings r JOIN books b 
ON r.book_id = b.book_id 
                JOIN users u
ON  u.user_id = r.user_id
        JOIN locations l
ON  u.location_id = l.location_id
WHERE b.title LIKE '%harry potter%'
GROUP BY l.country;

-- [books and publishers]

-- a. Write a query to display the book title, num_pages and publisher name for all books, including those with no publisher details
-- b. Restrict your query to display only books with no publisher details
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT  b.title, b.num_pages, p.publisher_name 
FROM  books b 
LEFT JOIN publishers p       
ON p.publisher_id = b.publisher_id
WHERE p.publisher_name IS NULL;
-- [books and authors]

-- a. Write a query to display the book title, num_pages, publication_date, and authors for all books, including those with no author details
-- b. Restrict your query to display only books with no author details
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT  b.title, b.num_pages, b.publication_date, a.authors
FROM books AS b  
LEFT JOIN authors AS a                     
ON a.author_id = b.author_id
WHERE a.authors IS NULL;

-- [books and ratings]

-- How many books have never been rated
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT COUNT(*)
FROM books AS b 
LEFT JOIN  ratings AS r 
ON r.book_id = b.book_id
WHERE r.rating IS NULL;

-- Self join is used to retrieve heirachical data within a table eg finding superior and managers of staffs etc
USE HR;
-- Write a query to display the employee last name, and his/hers direct manager
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT staff.last_name AS employee_last_name,  manager.Last_name AS managers_last_name
FROM employees AS staff
JOIN employees AS manager
ON staff.manager_id = manager.id;


-- Rewrite your query to include all employees, including those with no manager
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT staff.last_name AS employee_last_name,  manager.Last_name AS managers_last_name
FROM employees AS staff
LEFT JOIN employees AS manager
ON staff.manager_id = manager.id;

USE carsonline;

-- [cars and car_types]

-- a. Write a query to display the car_id, price, car_make, car_model, and car_year for each car
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT c.car_id, c.price, t.car_make, t.car_model, t.car_year 
FROM cars AS c
JOIN car_types AS t
ON c.car_type_id = t.car_type_id
ORDER BY t.car_year;

-- b. restrict your query to display only cars made by bmw on 2019
SELECT c.car_id, c.price, t.car_make, t.car_model, t.car_year 
FROM cars AS c
JOIN car_types AS t
ON c.car_type_id = t.car_type_id
WHERE  t.car_make = 'BMW' AND t.car_year = 2019;

-- c. Display the average price for each car model during this year
SELECT t.car_model, CONCAT('$', ROUND(AVG(c.price),2)) AS average_price
FROM cars AS c
JOIN car_types AS t
ON c.car_type_id = t.car_type_id
WHERE  t.car_make = 'BMW' AND t.car_year = 2019
GROUP BY t.car_model;

-- [cars and fuel_types]

-- a. Write a query to display the car_id, price and fuel_type_name for each car
SELECT c.car_id, c.price, ft.fuel_type_name
FROM cars AS c
JOIN fuel_types AS ft
ON c.fuel_type_id = ft.fuel_type_id;

-- b. Display the number of cars by each fuel_type_name. Sort the output by the number of cars (descending)
SELECT ft.fuel_type_name, COUNT(*) AS number_of_cars
FROM cars AS c
JOIN fuel_types AS ft
ON c.fuel_type_id = ft.fuel_type_id
GROUP BY fuel_type_name
ORDER BY number_of_cars DESC;

-- [cars and transmission_types]

-- a. Write a query to display the car_id, price and transmission_name for each car
SELECT c.car_id, c.price, t.transmission_name
FROM cars AS c
JOIN transmission_types AS t
ON c.transmission_type_id = t.transmission_type_id;       

-- b. Display the average price for each transmission_name. Sort the output by the average price (descending)
SELECT t.transmission_name, AVG(c.price) AS average_price
FROM cars AS c
JOIN transmission_types AS t
ON c.transmission_type_id = t.transmission_type_id
GROUP BY t.transmission_name
ORDER BY average_price DESC;  

-- [cars, car_types and fuel_types]

-- Write a query to display the unique number of hybrid cars for each car_make. Sort the output by the number of cars (Descending)
SELECT t.car_make, Fuel_type_name, COUNT(DISTINCT t.car_model) AS hybrid_users
FROM cars AS c
JOIN fuel_types AS ft
ON c.fuel_type_id = ft.fuel_type_id
JOIN car_types AS t
ON c.car_type_id = t.car_type_id
WHERE fuel_type_name = 'Hybrid'
GROUP BY t.car_make
ORDER BY hybrid_users DESC;


-- [cars, car_types and transmission_types]

-- Write a query to display the number of manual-gearbox cars, by each car_year and car_make. Sort the output by the year (ascending)
SELECT ct.car_year, ct.car_make, COUNT(*) AS manual_users
FROM cars AS c
JOIN transmission_types AS t
ON c.transmission_type_id = t.transmission_type_id
JOIN car_types AS ct
ON c.car_type_id = ct.car_type_id
WHERE t.transmission_name = 'manual'
GROUP BY ct.car_year, ct.car_make
ORDER BY ct.car_year;

-- [customers and genders]

-- a. Write a query to display the customer_id, first_name, last_name, birth_date, and gender
SELECT  c.customer_id, c.first_name, c.last_name, c.birth_date, g.gender
FROM customers AS c
JOIN genders AS g
ON c.gender_code = g.gender_code;
-- b. Display the number of customers by each gender
SELECT  g.gender, COUNT(*) AS number_of_users
FROM customers AS c
JOIN genders AS g
ON c.gender_code = g.gender_code
GROUP BY g.gender;
-- c. Display the number of customers by each gender and age. Sort the output by the number of customers (descending)
SELECT  g.gender, timestampdiff(YEAR, birth_date, curdate()) as Age, COUNT(*) AS customer_count
FROM customers AS c
JOIN genders AS g
ON c.gender_code = g.gender_code
GROUP BY 1, 2
ORDER BY 3 DESC;
-- d. Restrict your query to for customers above the age 59
SELECT  g.gender, timestampdiff(YEAR, birth_date, curdate()) as Age, COUNT(*) AS customer_count
FROM customers AS c
JOIN genders AS g
ON c.gender_code = g.gender_code
WHERE timestampdiff(YEAR, birth_date, curdate()) > 59
GROUP BY 1, 2
ORDER BY 3 DESC;

-- [customers and locations]

-- a. Write a query to display the number of customers living in Australia.
SELECT COUNT(*) AS australia_customer
FROM customers AS c
JOIN locations AS l
ON c.location_code = l.location_code
WHERE l.country = 'Australia';
-- b. Write another query to display the number of customers with updated phone_number living in Australia (customers who has value in phone_number)
SELECT COUNT(phone_number) AS updated_phone_numbers
FROM customers AS c
JOIN locations AS l
ON c.location_code = l.location_code
WHERE l.country = 'Australia';

-- c. Write another query to display the number of australian customers with NULL value in their phone_number, 
-- break down the result for each city, sort it by the count (descending).
SELECT l.city, COUNT(*) AS not_updated
FROM customers AS c
JOIN locations AS l
ON c.location_code = l.location_code
WHERE l.country = 'Australia' AND phone_number IS NULL
GROUP BY l.city
ORDER BY not_updated DESC;

-- [sales and customers]

-- Write a query to display the customer_id and full name of customers who bought more than 5 cars
SELECT s.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name, COUNT(*) AS number_bought
FROM customers AS c
JOIN sales AS s
ON c.customer_id = s.customer_id
GROUP BY  s.customer_id, CONCAT(c.first_name, ' ', c.last_name)
HAVING COUNT(*) > 5;
-- MSSQL
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS 'full_name', COUNT(*) AS 'number_of_cars'
FROM sales s JOIN customers c 
ON s.customer_id = c.customer_id
GROUP BY c.customer_id, CONCAT(c.first_name, ' ', c.last_name)
HAVING COUNT(*) > 5;
-- POSTGRES
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS "full_name", COUNT(*) AS "number_of_cars"
FROM sales s JOIN customers c 
ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name || ' ' || c.last_name
HAVING COUNT(*) > 5;
-- [sales and cars]

-- Not every car on the cars table has been sold. Write a query to display the percent of sold cars.
-- MYSQL
SELECT COUNT(s.customer_id) / COUNT(*) * 100 AS 'percent_of_sold_cars'
FROM sales s 
RIGHT OUTER JOIN cars c 
ON s.car_id = c.car_id;
-- MSSQL
SELECT COUNT(s.customer_id) / CAST(COUNT(*) AS DECIMAL) * 100 AS 'percent_of_sold_cars'
FROM sales s RIGHT OUTER JOIN cars c 
ON s.car_id = c.car_id;
-- POSTGRES
SELECT COUNT(s.customer_id) / CAST(COUNT(*) AS DECIMAL) * 100 AS "percent_of_sold_cars"
FROM sales s RIGHT OUTER JOIN cars c 
ON s.car_id = c.car_id;


-- [sales, cars and car_types]

-- On 2019 (of purchase date), What was the average price of sold cars made by Audi?
SELECT AVG(c.price) AS average_2019Audi_price
FROM sales AS s 
JOIN cars AS c
ON c.car_id = s.car_id
JOIN car_types AS ct
ON c.car_type_id = ct.car_type_id
WHERE YEAR(s.purchase_date) = 2019 AND ct.car_make = 'audi';


-- single subquery
USE students_survey;

-- Write a query to display the student_id, full_name and university_id for all students who go to the same university as student_id 6043
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT student_id, full_name, university_id
FROM survey	
WHERE university_id = (SELECT university_id
			FROM survey
		WHERE student_id = 6043);

-- Write a query to display the survey_id and survey_date for all surveys that were taken on the same date as survey_id 532
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT survey_id, survey_date
FROM survey	
WHERE survey_date = (SELECT survey_date
			FROM survey
			WHERE survey_id = 532);

-- Write a query to display the student_id, full_name and height for all students who are taller than Josephina Athow (full_name)
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT student_id, full_name, height_cm
FROM survey	
WHERE height_cm > (SELECT height_cm
				FROM survey
				WHERE full_name = 'Josephina Athow');

-- Write a query to display the student_id, full_name and age for all students younger than the student who filled survey number 10
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT student_id, full_name, age
FROM survey	
WHERE age < (SELECT age
				FROM survey
				WHERE survey_id = 10);
                
-- Write a query to display the student_id, full_name, and father_job, 
-- for all students whose father works in the same job as (the father of) Christina Rediers (full_name)
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT student_id, full_name, father_job
FROM survey	
WHERE father_job = (SELECT father_job
				FROM survey
				WHERE full_name = 'Christina Rediers');

-- Write a query to display the student_id, full_name, father_job, and mother_job for all students whose:

-- a. Father works in the same job as (the father of) Christina Rediers and

-- b. Mother works in the same job as (the mother of) Christina Rediers and
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT student_id, full_name, father_job, mother_job
FROM survey	
WHERE father_job = (SELECT father_job
				FROM survey
				WHERE full_name = 'Christina Rediers') 
	AND mother_job =(SELECT mother_job
				FROM survey
				WHERE full_name = 'Christina Rediers');
                
                select * from survey;

-- Write a query to display the student_id, full_name and age for all students older than the average
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT student_id, full_name, age
FROM survey	
WHERE age > (SELECT AVG(age)
				FROM survey);

-- Write a query to display the student_id, full_name, age and height for all students older than the average, and taller than the average
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT student_id, full_name, age, height_cm
FROM survey	
WHERE height_cm > (SELECT AVG(height_cm)
				FROM survey)
		AND age > (SELECT AVG(age)
				FROM survey);
                
USE appstore;               
  
-- Write a query to display the app_id, app_name, category and reviews for apps with more reviews than app_id 64
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT app_id, app_name, category, reviews
FROM apps
WHERE reviews > (SELECT reviews
	FROM apps
	WHERE app_id = 64);

-- Write a query to display the app_name, category, size_in_mb, and rating, for apps in the same category as Redhold (app_name)
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT app_name, category, size_in_mb, rating
FROM apps
WHERE category = (SELECT category
	FROM apps
	WHERE app_name = 'Redhold');
-- Write a query to display the app_name, category, app_version, and last_updated, for apps which were last_updated before app_id 29
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT app_name, category, app_version, last_updated
FROM apps
WHERE last_updated < (SELECT last_updated
	FROM apps
	WHERE app_id = 29);
-- Write a query to display the app_name, category, app_version, and rating, for apps with rating higher than the average
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT app_name, category, app_version, rating
FROM apps
WHERE rating > (SELECT AVG(rating)
	FROM apps);
-- Write a query to display the categories having apps in the same size_in_mb as apps in the education category
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT DISTINCT category
FROM apps 
WHERE size_in_mb IN (SELECT size_in_mb FROM apps WHERE category = 'Education')
		AND category != 'Education';

-- Minimum and Maximum Ratings
-- a. What is the min rating of apps in the Education category ? (subqueries are not needed to answer this one)
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT MIN(rating) 
FROM apps 
WHERE category = 'Education';

-- b. What is the max rating of apps in the Education category ? (subqueries are not needed to answer this one)
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT MAX(rating) 
FROM apps 
WHERE category = 'Education';

-- c. Write a query to display the app_name and rating for apps with rating in the range of Education min and max values
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT app_name, rating 
FROM apps 
WHERE rating >= (SELECT MIN(rating) FROM apps WHERE category = 'Education')
AND   rating <= (SELECT MAX(rating) FROM apps WHERE category = 'Education');
-- or 
-- Applies to MYSQL, MSSQL and POSTGRES
SELECT app_name, rating 
FROM apps 
WHERE rating BETWEEN (SELECT MIN(rating) FROM apps WHERE category = 'Education')
	     AND     (SELECT MAX(rating) FROM apps WHERE category = 'Education');

-- Write a query to display the app_id, app_name, rating and reviews for app with rating higher than app_id 131 and (number of) reviews higher than app_id 28
 
-- Applies to MYSQL, MSSQL and POSTGRES

SELECT app_id, app_name, rating and reviews 
FROM apps
WHERE rating > (SELECT rating FROM apps WHERE app_id = 131)
AND   reviews > (SELECT reviews FROM apps WHERE app_id = 28);
