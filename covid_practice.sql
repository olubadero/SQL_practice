SELECT *
FROM `COVID DEATHS`.death;
	  
-- Data Row count
SELECT count(*)  FROM `COVID DEATHS`.death;

-- duplicates
SELECT *, COUNT(*)
FROM `COVID DEATHS`.death
GROUP BY iso_code, continent, location, date, population, total_cases, new_cases, new_cases_smoothed, 
total_deaths, new_deaths, new_deaths_smoothed, total_cases_per_million, new_cases_per_million, new_cases_smoothed_per_million, 
total_deaths_per_million, new_deaths_per_million, new_deaths_smoothed_per_million, new_cases_smoothed_per_million, reproduction_rate, 
icu_patients, icu_patients_per_million, hosp_patients, hosp_patients_per_million,
weekly_hosp_admissions, weekly_hosp_admissions_per_million, weekly_icu_admissions, weekly_icu_admissions_per_million
HAVING COUNT(*) > 1;
-- There are no duplicates

-- Continent covered
SELECT distinct(continent)
FROM `COVID DEATHS`.death;

-- countries and population
SELECT distinct(continent), location, population
FROM `COVID DEATHS`.death
ORDER BY Continent;


SELECT continent, sum(new_deaths), MAX(total_deaths) AS highestdeathrate
FROM `COVID DEATHS`.death
GROUP BY continent
ORDER BY highest_death_rate DESC;

Select *
FROM `COVID DEATHS`.death
where location = 'Oceania';


-- count of Country covered
SELECT count(distinct(location))
FROM `COVID DEATHS`.death;
-- 210 but google says there are 193 countries in the world

-- total deaths in 2020 and 2021
select continent, location as Country, max(total_deaths) as Max_death_2020
FROM `COVID DEATHS`.death
where date between '2020-01-01' and '2020-12-31'
group by continent, location
order by 3 desc;

select continent, location as Country, max(total_deaths) as Max_death_2021
FROM `COVID DEATHS`.death
where date between '2021-01-01' and '2021-12-31'
group by continent, location
order by 3 desc;

-- max total cases per country
SELECT continent, location, max(total_cases)
FROM `COVID DEATHS`.death
group by continent, location
order by max(total_cases) desc;


-- disable safe mode to allow delete statement
SET SQL_SAFE_UPDATES = 0;

-- dropping country that are continents
DELETE FROM `COVID DEATHS`.death
WHERE location = 'World';

SELECT *
FROM `COVID DEATHS`.death
WHERE location = 'world';

DELETE FROM `COVID DEATHS`.death
WHERE location IN ('Europe', 'Asia', 'North America', 'European Union', 'South America', 'Africa');

DELETE FROM `COVID DEATHS`.death
WHERE location IN ('Oceania');

DELETE FROM `COVID DEATHS`.death
WHERE location IN ('International');

-- Data Row count
SELECT count(*)  FROM `COVID DEATHS`.death;

-- maximum total cases per country
SELECT continent, location, max(total_cases)
FROM `COVID DEATHS`.death
group by continent, location
order by max(total_cases) desc;

-- minimum total cases per country
SELECT continent, location, min(total_cases)
FROM `COVID DEATHS`.death
group by continent, location
order by min(total_cases) desc;

-- average total cases per country
SELECT continent, location, ROUND(avg(total_cases))
FROM `COVID DEATHS`.death
group by continent, location
order by avg(total_cases) desc;

-- maximum new cases per country
SELECT continent, location, max(new_cases)
FROM `COVID DEATHS`.death
group by continent, location
order by max(new_cases) desc;

-- minimum new cases per country
SELECT continent, location, min(new_cases)
FROM `COVID DEATHS`.death
group by continent, location
order by min(new_cases) desc;

-- average new cases per country
SELECT continent, location, avg(new_cases)
FROM `COVID DEATHS`.death
group by continent, location
order by avg(new_cases) desc;

-- max total deaths per country
SELECT continent, location, max(total_deaths)
FROM `COVID DEATHS`.death
GROUP BY continent, location
ORDER BY max(total_deaths) DESC;

-- min total deaths per country
SELECT continent, location, min(total_deaths)
FROM `COVID DEATHS`.death
GROUP BY continent, location
ORDER BY min(total_deaths) DESC;

-- average total deaths per country
SELECT continent, location, avg(total_deaths)
FROM `COVID DEATHS`.death
GROUP BY continent, location
ORDER BY avg(total_deaths) DESC;

-- total new deaths for 2020 & 2021 per country per day
SELECT continent, location, date, sum(new_deaths)
FROM `COVID DEATHS`.death 
WHERE date between '2020-01-01 00:00:00' and '2020-12-31 00:00:00'
GROUP BY continent, location, date
ORDER BY sum(new_deaths) DESC;

SELECT continent, location, date, sum(new_deaths)
FROM `COVID DEATHS`.death 
WHERE date between '2021-01-01 00:00:00' and '2021-12-31 00:00:00'
GROUP BY continent, location, date
ORDER BY sum(new_deaths) DESC;

-- 5th highest daily death
SELECT *
FROM(SELECT continent, location, date, sum(new_deaths),
	row_number() over(order by sum(new_deaths) desc) as rn
	FROM `COVID DEATHS`.death 
	WHERE date between '2021-01-01' and '2021-12-31'
	GROUP BY continent, location, date
	ORDER BY sum(new_deaths) DESC) as X
WHERE x.rn = 5;

SELECT *
FROM(SELECT continent, location, date, sum(new_deaths),
	rank() over(order by sum(new_deaths) desc) as rn
	FROM `COVID DEATHS`.death 
	WHERE date between '2021-01-01' and '2021-12-31'
	GROUP BY continent, location, date
	ORDER BY sum(new_deaths) DESC) as X
WHERE x.rn = 5;

-- monthly analysis
SELECT month(DATE) as Month, continent, max(total_deaths), max(total_cases)
FROM `COVID DEATHS`.death
GROUP BY 1, 2;

SELECT month(DATE) as Month, location, max(total_deaths), max(total_cases)
FROM `COVID DEATHS`.death
GROUP BY 1, 2;

SELECT year(DATE) as Year, continent, max(total_deaths), max(total_cases)
FROM `COVID DEATHS`.death
GROUP BY 1, 2;

SELECT year(DATE) as Year, continent, ROUND(avg(total_deaths)) as Average_Death, ROUND(avg(total_cases)) as Average_Cases
FROM `COVID DEATHS`.death
GROUP BY 1, 2;


SELECT *
FROM `COVID DEATHS`.death;

-- Death Percentage 
SELECT continent, location, ROUND(max(total_deaths)/max(total_cases) * 100, 2) as Death_Percentage
FROM `COVID DEATHS`.death
GROUP BY continent, location
ORDER BY 3 DESC;

SELECT continent, location, ROUND(sum(new_deaths)/sum(new_cases) * 100, 2) as Death_Percentage
FROM `COVID DEATHS`.death
GROUP BY continent, location
ORDER BY 3 DESC;

SELECT continent, location, year(date), Round(sum(new_deaths)/sum(new_cases) * 100, 2) as Death_Percentage
FROM `COVID DEATHS`.death
GROUP BY continent, location, year(date)
ORDER BY 4 DESC;


SELECT continent, location, ROUND(sum(new_deaths)/sum(new_cases) * 100, 2) as Death_Percentage
FROM `COVID DEATHS`.death
WHERE date between '2020-01-01' and '2020-12-31'
GROUP BY continent, location
ORDER BY 3 DESC;

SELECT continent, location, ROUND(sum(new_deaths)/sum(new_cases) * 100, 2) as Death_Percentage
FROM `COVID DEATHS`.death
WHERE date between '2021-01-01' and '2021-12-31'
GROUP BY continent, location
ORDER BY 3 DESC;

-- Percentage of those infected 
SELECT	continent, location, population, ROUND(sum(new_cases)/population * 100, 2) AS Infected_Population_Percentage
FROM `COVID DEATHS`.death
GROUP BY continent, location, population
ORDER BY 4 DESC;

-- Percentage of those that died
SELECT	continent, location, population, ROUND(sum(new_deaths)/population * 100, 2) AS Death_Population_Percentage
FROM `COVID DEATHS`.death
GROUP BY continent, location, population
ORDER BY 4 DESC;

SELECT	location, year(date), ROUND(sum(new_deaths)/population * 100, 2) AS Death_Population_Percentage
FROM `COVID DEATHS`.death
GROUP BY 1, 2, population
ORDER BY 2 AND 3;

SELECT	continent, location, population, sum(new_deaths)/population * 100 AS Death_Population_Percentage
FROM `COVID DEATHS`.death
WHERE date between '2021-01-01' and '2021-12-31'
GROUP BY continent, location, population
ORDER BY 4 DESC;

SELECT	continent, location, population, (sum(new_deaths)/population) * 100 AS Death_Population_Percentage
FROM `COVID DEATHS`.death
WHERE date between '2021-01-01' and '2021-12-31'
GROUP BY continent, location, population
ORDER BY 4 DESC;

-- ICU Patients percentage
SELECT	continent, location, population, (sum(icu_patients)/sum(new_cases)) * 100 AS ICU_Percentage
FROM `COVID DEATHS`.death
GROUP BY continent, location, population
ORDER BY 4 DESC;

-- Case and Death Rate by Continent 
SELECT continent, MAX(total_cases) as highest_case_rate, MAX(total_deaths) AS highest_death_rate
FROM `COVID DEATHS`.death
GROUP BY continent
ORDER BY 3 DESC;

-- Case and Death Rate by Country
SELECT location, MAX(total_cases) as highest_case_rate, MAX(total_deaths) AS highest_death_rate
FROM `COVID DEATHS`.death
GROUP BY location
ORDER BY 1;

-- Deleting continents
DELETE FROM `COVID DEATHS`.vaccination
WHERE location IN ('Europe', 'World', 'Oceania', 'International', 'Asia', 'North America', 'European Union', 'South America', 'Africa');

-- Total Tests per Country
SELECT continent, location, sum(new_tests) as Total_tests
FROM `COVID DEATHS`.vaccination
GROUP BY continent, location
ORDER BY 3 DESC;

-- Total Vaccination per County
SELECT continent, location, sum(new_vaccinations) as Total_Vaccinations
FROM `COVID DEATHS`.vaccination
GROUP BY continent, location
ORDER BY 3 DESC;

--  Max Vaccination
SELECT continent, location, max(new_vaccinations) as Max_Vaccinations
FROM `COVID DEATHS`.vaccination
GROUP BY continent, location
ORDER BY 3 DESC;

-- by days
SELECT continent, day(DATE), location, max(new_vaccinations) as Max_Vaccinations
FROM `COVID DEATHS`.vaccination
GROUP BY continent, location, date
ORDER BY 4 DESC;

-- Max Testing
SELECT continent, location, max(new_tests) as Max_Tests
FROM `COVID DEATHS`.vaccination
GROUP BY continent, location
ORDER BY 3 DESC;

SELECT continent, date, location, max(new_tests) as Max_Tests
FROM `COVID DEATHS`.vaccination
GROUP BY continent, location, date
ORDER BY 4 DESC;

-- Table Merge
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations, DEA.total_cases, DEA.total_deaths
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date;
    
-- vaccinated percentage
SELECT DEA.continent, DEA.location, (sum(VAC.new_vaccinations)/DEA.population) * 100 as vaccine_percentage 
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date
group by DEA.continent, DEA.location, DEA.population
ORDER BY vaccine_percentage DESC;
    
-- Average Vaccinations
SELECT DEA.continent, DEA.location, avg(VAC.new_vaccinations) as vaccine_average 
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date
group by DEA.continent, DEA.location
ORDER BY vaccine_average DESC;

-- common data between both tables
SELECT * FROM `COVID DEATHS`.vaccination
INTERSECT 
SELECT * FROM `COVID DEATHS`.death;
    
    
SELECT * FROM `COVID DEATHS`.vaccination;

SELECT * FROM `COVID DEATHS`.vaccination;
SELECT * FROM `COVID DEATHS`.vaccination;
SELECT * FROM `COVID DEATHS`.vaccination;
SELECT * FROM `COVID DEATHS`.death;
SELECT * FROM `COVID DEATHS`.death;
SELECT * FROM `COVID DEATHS`.death;