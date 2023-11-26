SELECT count(*) FROM `COVID DEATHS`.vaccinations;
SELECT * FROM `COVID DEATHS`.vaccinations;
SELECT continent FROM `COVID DEATHS`.death;
SELECT * FROM `COVID DEATHS`.death;

-- Data that will be used
SELECT location, date, total_cases, new_cases, total_deaths, Population 
FROM `COVID DEATHS`.death
order by 1, 2;

-- Total cases vs Total Deaths
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS 'Death percentage'
FROM `COVID DEATHS`.death
order by 1, 2;

-- Shows likelihood of dying if you contract COVID in your Country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS 'Death percentage'
FROM `COVID DEATHS`.death
WHERE location REGEXP 'Nigeria'
order by 'Death Percentage' DESC;

-- Total Cases v Population
-- shows percentage of the population that has COVID
SELECT location, date, total_cases, population, (total_cases/population) * 100 AS 'population percentage'
FROM `COVID DEATHS`.death
WHERE location REGEXP 'Nigeria'
order by 'population Percentage' DESC;

-- used for tableau
SELECT location, population, date, MAX(total_cases) AS Highest_infection_count, Max((total_cases/population))* 100 AS 'population percentage'
FROM `COVID DEATHS`.death
group by location, population, date
order by 'population Percentage' DESC;

-- looking at countries with highest infection rates compared to population
-- used for tableau
SELECT location, MAX(total_cases) AS highestinfectionrate, population, MAX((total_cases/population)) * 100 AS 'highest population percentage'
FROM `COVID DEATHS`.death
GROUP BY location, population
ORDER BY 'highest population percentage' DESC;

-- Shows highest country death count per population
SELECT location, MAX(total_deaths) AS highestdeathrate, population
FROM `COVID DEATHS`.death
GROUP BY location, population
ORDER BY highestdeathrate DESC;

SELECT location, MAX(total_deaths) AS highestdeathrate
FROM `COVID DEATHS`.death
WHERE continent is NOT NULL
GROUP BY location
ORDER BY highestdeathrate DESC;

-- By Continent (used for tableau)
SELECT continent, MAX(total_deaths) AS highestdeathrate
FROM `COVID DEATHS`.death
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY highestdeathrate DESC;

-- Global numbers
SELECT date, sum(new_cases) AS Total_cases,sum(new_deaths) AS Total_deaths, (SUM(new_deaths)/SUM(new_cases)) * 100 as deathpercentage
FROM `COVID DEATHS`.death
WHERE continent is NOT NULL
GROUP BY date
ORDER BY 4 DESC;

SELECT location, date, sum(new_cases) AS Total_cases,sum(new_deaths) AS Total_deaths, (SUM(new_deaths)/SUM(new_cases)) * 100 as deathpercentage
FROM `COVID DEATHS`.death
WHERE continent is NOT NULL
GROUP BY date,location
ORDER BY 4 DESC;

-- used for tableau
SELECT sum(new_cases) AS Total_cases,sum(new_deaths) AS Total_deaths, (SUM(new_deaths)/SUM(new_cases)) * 100 as deathpercentage
FROM `COVID DEATHS`.death
WHERE continent is NOT NULL;

-- total death count
-- used for tableau
SELECT location, SUM(new_deaths) AS Total_death_count
FROM `COVID DEATHS`.death
WHERE  Location NOT IN ('world', 'European Union', 'International')
GROUP BY location
ORDER BY Total_death_count DESC;

-- joining vaccination and death table
SELECT *
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date;
    
-- total population vs vaccination
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date
WHERE DEA.continent is NOT NULL
ORDER BY 2, 3;

-- Rolling count
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations, SUM(VAC.new_vaccinations)
over(PARTITION BY DEA.LOCATION)
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date
WHERE DEA.continent is NOT NULL
ORDER BY 1, 2;

-- Rolling Count of vaccinated people
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations, SUM(VAC.new_vaccinations)
over(PARTITION BY DEA.LOCATION ORDER by DEA.location AND DEA.date) AS rollingpeoplevaccinated
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date
WHERE DEA.continent is NOT NULL
ORDER BY 1, 2;

-- USING  CTE
WITH PopvsVac (continent, location, date, population, new_vaccinations,rollingpeoplevaccinated)
as
(
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations, SUM(VAC.new_vaccinations)
over(PARTITION BY DEA.LOCATION ORDER by DEA.location AND DEA.date) AS rollingpeoplevaccinated
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date
WHERE DEA.continent is NOT NULL)
SELECT * FROM PopvsVac;

-- creating view to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated as
SELECT DEA.continent, DEA.location, DEA.date, DEA.population, VAC.new_vaccinations, SUM(VAC.new_vaccinations)
over(PARTITION BY DEA.LOCATION ORDER by DEA.location AND DEA.date) AS rollingpeoplevaccinated
FROM `COVID DEATHS`.death DEA
JOIN `COVID DEATHS`.vaccination VAC
	ON DEA.location = VAC.location
    AND DEA.date = VAC.date
WHERE DEA.continent is NOT NULL;



