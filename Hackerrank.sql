SELECT *
FROM City
WHERE population > 100000 AND countrycode ='USA';

SELECT city, state
FROM Station;

SELECT CONCAT(Name, '(',LEFT(Occupation, 1), ')')
FROM occupations
ORDER BY name;

SELECT CONCAT('There are a total of',' ', COUNT(Occupation), ' ', LOWER(occupation),'s.')
FROM occupations
GROUP BY occupation
ORDER BY COUNT(Occupation), occupation;

-- displaying the city with longest and shortest character in their name
(SELECT city, length(City) as len
FROM Station
WHERE length(City) = (select min(length(City)) from Station)
ORDER BY city
LIMIT 1
)
UNION
( SELECT city, length(City) as len
FROM Station
WHERE length(City) = (select max(length(City)) from Station)
ORDER BY city
LIMIT 1
);

-- city starting with vowels
SELECT DISTINCT city
FROM station
WHERE City NOT LIKE 'A%' OR City NOT LIKE 'E%' OR City NOT LIKE 'I%' OR City NOT LIKE 'O%' OR City NOT LIKE 'U%';
-- City starting with consonants
SELECT DISTINCT city
FROM station
WHERE City NOT LIKE 'A%' AND City NOT LIKE 'E%' AND City NOT LIKE 'I%' AND City NOT LIKE 'O%' AND City NOT LIKE 'U%';

-- vowel ends and starts the word
SELECT DISTINCT CITY 
FROM STATION 
WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%') AND (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u') order by city;

-- Doesnt start and end with vowels
SELECT DISTINCT city
FROM station
WHERE 
    LOWER(LEFT(city, 1)) NOT IN ('a', 'i', 'u', 'e', 'o') AND
    RIGHT(city, 1) NOT IN ('a', 'i', 'u', 'e', 'o');

select case when A >= B+C or B >= C+A or C >= A+B then 'Not A Triangle' 
		when A=C AND A=B AND B=C then 'Equilateral' 
        when A=B OR A=C OR B=C then 'Isosceles' 
        else 'Scalene' end 
	from TRIANGLES;
    
SELECT ROUND(MAX(lat_n), 4)
FROM station
WHERE lat_n < 137.2345;

-- Removing 0 in salary to calculate average
select CEIL(avg(salary) - avg(replace(salary, 0, '')))
from employees;

-- finding the number of employees earning the max salary
SELECT months * salary AS MAX_EARNING, COUNT(*)
FROM employee
WHERE months * salary = (SELECT MAX(months * salary) FROM employee)
group by 1;

SELECT ROUND(SUM(LAT_N), 2), ROUND(SUM(LONG_W), 2)
FROM station;

SELECT ROUND(SUM(lat_n), 4)
FROM station
-- WHERE Lat_n > 38.7880 AND Lat_n < 137.2345
WHERE Lat_n BETWEEN 38.7880 AND 137.2345;

-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to  decimal places.
SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n = (SELECT MAX(LAT_N)
FROM station
WHERE lat_n < 137.2345);

-- Query the smallest Northern Latitude (LAT_N) from STATION that is greater than  38.7780. Round your answer to  decimal places.
 SELECT ROUND(MIN(LAT_N), 4)
 FROM STATION
 WHERE LAT_N > 38.7780;
 
-- Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.
SELECT ROUND(LONG_W, 4)
FROM station
WHERE LAT_N =
		(SELECT MIN(LAT_N)
		FROM station
		WHERE LAT_N > 38.7780);
        
-- Query the Manhattan Distance between points  and  and round it to a scale of  decimal places. 
-- manhattan_distance = p1 at (x1, y1) and p2 at (x2, y2), it is |x1 - x2| + |y1 - y2|.      
SELECT Round((max(lat_n) - min(lat_n)), 4) +  Round((max(long_w) - min(long_w)), 4)
FROM station;

-- Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.
-- Euclidean_distance =p1 at (x1, y1) and p2 at (x2, y2),
-- √((x1 - x2)² + (y1 - y2)²).

SELECT ROUND(SQRT(POWER((max(lat_n) - min(lat_n)), 2) +  POWER(max(long_w) - min(long_w), 2)), 4)
FROM station;

SELECT SUM(ct.population)
FROM city as ct
JOIN country as cr
ON ct.countrycode = cr.code
WHERE cr.continent = 'Asia';

SELECT ct.name
FROM city as ct
JOIN country as cr
ON ct.countrycode = cr.code
WHERE cr.continent = 'Africa';

SELECT cr.continent, FLOOR(AVG(ct.POPULATION))
FROM city as ct
JOIN country as cr
ON ct.countrycode = cr.code
GROUP BY cr.continent;

-- A median is defined as a number separating the higher half of a data set from the lower half. 
-- Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.

WITH CTE AS (SELECT lat_n
        FROM station
        ORDER BY lat_n 
        LIMIT 250)
SELECT ROUND(lat_n, 4)
FROM CTE
ORDER BY lat_n DESC
LIMIT 1;















