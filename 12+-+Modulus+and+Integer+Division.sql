-------------------
-- Modulus and Integer Division
-------------------
-- 1. Modulus - Retrieves the remainder of a division action.
-- SELECT 20 / 4;
-- SELECT 20 % 3;
-- SELECT 20 % 6;
-- SELECT 20 % 7;
-- SELECT 20 MOD 7;

-- 2. Uses of Modulus
-- SELECT
-- film_id, title, rental_duration, rental_rate, length, rating, special_features
-- FROM film
-- WHERE rental_duration %2 = 1;

-- 3. Integer Division
-- SELECT 20 DIV 4;
-- SELECT 20 DIV 3;
-- SELECT 20 DIV 6;
-- SELECT 20 DIV 7;

-- 4. Uses of Integer Division
-- USE world;
-- -- Show countries founded on the 12th, 15th and 18th centuary 
-- SELECT name, continent, indepyear 
-- FROM country
-- WHERE indepyear BETWEEN 1100 AND 1199
-- 	OR indepyear BETWEEN 1400 AND 1499
-- 	OR indepyear BETWEEN 1700 AND 1799;
-- WHERE indepyear DIV 100 IN (11, 14, 17);