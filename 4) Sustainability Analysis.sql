USE world_bank_data;

-- Access to Electricity Over Time by country
SELECT country, date, access_electricity
FROM sustainable_indicators
ORDER BY country, date;

-- Top 10 countries by renewable energy consumption
SELECT country, renewable_energy_consumption
FROM sustainable_indicators
WHERE date = (SELECT MAX(date) FROM sustainable_indicators)
ORDER BY renewable_energy_consumption DESC
LIMIT 10;

-- Average access to electricity by Region
SELECT region, AVG(access_electricity) AS avg_access_electricity
FROM sustainable_indicators
JOIN locations ON sustainable_indicators.location_id = locations.location_id
GROUP BY region
ORDER BY avg_access_electricity DESC;

-- Yearly Renewable Energy Consumption for a specific country
SELECT YEAR(date) AS year, renewable_energy_consumption
FROM sustainable_indicators
WHERE country = 'Germany'
ORDER BY year;

-- Countries with low access to electricity (below 50%)
SELECT country, access_electricity
FROM sustainable_indicators
WHERE date = (SELECT MAX(date) FROM sustainable_indicators)
	AND access_electricity < 50
ORDER BY access_electricity ASC;

-- View 1: for access to electricity by country
CREATE VIEW AccessElectricityByCountry AS
SELECT country, date, access_electricity
FROM sustainable_indicators
ORDER BY country, date;
-- Query this view
SELECT * FROM AccessElectricityByCountry WHERE country = 'India';

-- View 2: for average renewable energy consumption by region
CREATE VIEW AvgRenewableEnergyByRegion AS
SELECT region, AVG(renewable_energy_consumption) AS avg_renewable_energy
FROM sustainable_indicators
JOIN locations ON sustainable_indicators.location_id = locations.location_id
GROUP BY region;
-- Use this view
SELECT * FROM AvgRenewableEnergyByRegion;

-- View 3: yearly renewable energy consumption for each country
CREATE VIEW RenewableEnergyByCountry AS
SELECT country, YEAR(date) AS year, AVG(renewable_energy_consumption) AS avg_renewable_energy
FROM sustainable_indicators
GROUP BY country, year;
-- Use this view
SELECT * FROM RenewableEnergyByCountry WHERE country = 'Brazil';

-- Stored Procedure 1: retrieve electricity access trends for a country
DELIMITER //
CREATE PROCEDURE GetElectricityAccessByCountry(IN country_name VARCHAR(50))
BEGIN
	SELECT date, access_electricity
    FROM sustainable_indicators
    WHERE country = country_name
    ORDER BY date;
END //
DELIMITER ;
-- Call this procedure
Call GetElectricityAccessByCountry('China');

-- Stored Procedure 2: to get average renewable energy consumption by region
DELIMITER //
CREATE PROCEDURE GetAvgRenewableEnergyByRegion(IN region_name VARCHAR(50))
BEGIN
	SELECT region, AVG(renewable_energy_consumption) AS avg_renewable_energy
    FROM sustainable_indicators
    JOIN locations ON sustainable_indicators.location_id = locations.location_id
    WHERE region = region_name
    GROUP BY region;
END //
DELIMITER ;
-- Call this procedure
Call GetAvgRenewableEnergyByRegion('Europe');

-- Stored Procedure 3: to retrieve Top N countries by Access to Electricity
DELIMITER //
CREATE PROCEDURE GetTopCountriesByElectricityAccess(IN top_n INT)
BEGIN
	SELECT country, access_electricity
    FROM sustainable_indicators
    WHERE date = (SELECT MAX(date) FROM sustainable_indicators)
    ORDER BY access_electricity DESC
    LIMIT top_n;
END //
DELIMITER ;
-- Call this procedure
CALL GetTopCountriesByElectricityAccess(5);

-- Function 1: Calculate Average Renewable Energy Consumption for a country
DELIMITER //
CREATE FUNCTION GetAvgRenewableEnergy(country_name VARCHAR(50))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE avg_renewable DECIMAL(5,2);
    
    SELECT AVG(renewable_energy_consumption) INTO avg_renewable
    FROM sustainable_indicators
    WHERE country = country_name;
    
    RETURN avg_renewable;
END //
DELIMITER ;
-- Use this function
SELECT GetAvgRenewableEnergy('Canada');

-- Function 2: get renewable energy consumption for a specific year and country
DELIMITER //
CREATE FUNCTION GetRenewableEnergyConsumption(country_name VARCHAR(50), year_val INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE renewable_energy DECIMAL(5,2)
    
    SELECT renewable_energy_consumption INTO renewable_energy
    FROM sustainable_indicators
    WHERE country = country_name AND YEAR(date) = year_val
    LIMIT 1;
    
    RETURN renewable_energy;
END //
DELIMITER ;
SELECT GetRenewableEnergyConsumption('Germany', 2019);





