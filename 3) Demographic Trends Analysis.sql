USE world_bank_data;

-- RETRIEVE Population growth by country
SELECT country, date, population_growth
FROM demographic_indicators
ORDER BY country, date;

-- Top 10 Countries by Life Expectancy
SELECT country, life_expectancy
FROM demographic_indicators
WHERE date = (SELECT MAX(date) FROM demographic_indicators)
ORDER BY life_expectancy DESC
LIMIT 10;

-- Average Child Mortality rate by region
SELECT region, AVG(child_mortality_rate) AS avg_child_mortality
FROM demographic_indicators
JOIN locations ON demographic_indicators.location_id = locations.location_id
GROUP BY region
ORDER BY avg_child_mortality;

-- Population trend over time for Albania
SELECT date, population_total
FROM demographic_indicators
WHERE country = 'Albania'
ORDER BY date;

-- Countries with the highest urban population percentage
SELECT country, urban_population
FROM demographic_indicators
WHERE date = (SELECT MAX(date) FROM demographic_indicators)
ORDER BY urban_population DESC
LIMIT 10;

-- View 1: for population growth by country
CREATE VIEW PopulationGrowthByCountry AS
SELECT country, date, population_growth
FROM demographic_indicators
ORDER BY country, date;
-- Query this view
SELECT * FROM PopulationGrowthByCountry WHERE country = 'Brazil';

-- View 2: for average life expectancy by region
CREATE VIEW AvgLifeExpectancyByRegion AS
SELECT region, AVG(life_expectancy) AS avg_life_expectancy
FROM demographic_indicators
JOIN locations ON demographic_indicators.location_id = locations.location_id
GROUP BY region;
-- Query this view
SELECT * FROM AvgLifeExpectancyByRegion;

-- View 3: for child mortality by year for a specific country
CREATE VIEW ChildMortalityByCountry AS
SELECT country, YEAR(date) AS year, AVG(child_mortality_rate) AS avg_child_mortality
FROM demographic_indicators
GROUP BY country, year;
-- Query this view
SELECT * FROM ChildMortalityByCountry WHERE country = 'Chad'; 

-- Stored Procedure 1: to retrieve life expectancy trends for a country
DELIMITER //
CREATE PROCEDURE GetLifeExpectancyByCountry(IN country_name VARCHAR(50))
BEGIN
	SELECT date, life_expectancy
    FROM demographic_indicators
    WHERE country = country_name
    ORDER BY date;
END //
DELIMITER ;
-- Call this procedure
CALL GetLifeExpectancyByCountry('India');

-- Stored Procedure 2: to get average population growth for a region
DELIMITER //
CREATE PROCEDURE GetAvgPopulationGrowthByRegion(IN region_name VARCHAR(50))
BEGIN
	SELECT region, AVG(population_growth) AS avg_population_growth
    FROM demographic_indicators
    JOIN locations ON demographic_indicators.location_id = locations.location_id
    WHERE region = region_name
    GROUP BY region;
END //
DELIMITER ;
-- Call this procedure
CALL GetAvgPopulationGrowthByRegion('Asia');

-- Function 1: to calculate average life expectancy for a country
DELIMITER //
CREATE FUNCTION GetAvgLifeExpectancy(country_name VARCHAR(50))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE avg_life_exp DECIMAL(5,2);
    
    SELECT AVG(life_expectancy) INTO avg_life_exp
    FROM demographic_indicators
    WHERE country = country_name
    LIMIT 1;
    
    RETURN avg_life_exp;
END //
DELIMITER ;
-- Use this function
SELECT GetAvgLifeExpectancy('Germany');

-- Function 2: to get child mortality rate for a specific year and country
DELIMITER //
CREATE FUNCTION GetChildMortality(country_name VARCHAR(50), year_val INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE mortality_rate DECIMAL(5,2);
    
    SELECT child_mortality_rate INTO mortality_rate
    FROM demographic_indicators
    WHERE country = country_name AND YEAR(date) = year_val
    LIMIT 1;
    
    RETURN mortality_rate;
END //
DELIMITER ;
-- Use this function
SELECT GetChildMortality('Burkina Faso', 2018);










