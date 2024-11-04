USE world_bank_data;

-- Retrieve all data from economic_indicators table
SELECT * 
FROM economic_indicators
LIMIT 10;

-- Retrieve GDP and GDP Growth Rate for a Specific Country
SELECT country, date, gdp_usd, gdp_growth_rate
FROM economic_indicators
WHERE country  = 'Japan'
ORDER BY date;

-- View for GDP and GDP Growth Rate
CREATE VIEW gdp_growth_country AS
SELECT country, date, gdp_usd, gdp_growth_rate
FROM economic_indicators
ORDER BY date;
-- Using VIEW for specific country
SELECT * FROM gdp_growth_country WHERE country = 'Australia';

-- Get Average GDP by Year across all countries
SELECT YEAR(date) AS year, AVG(gdp_usd) AS avg_gdp
FROM economic_indicators
GROUP BY year
ORDER BY year;

-- Average GDP Growth Rate by Region
SELECT region, AVG(gdp_growth_rate) AS avg_gdp_growth
FROM economic_indicators
JOIN locations ON economic_indicators.location_id = locations.location_id
GROUP BY region
ORDER BY avg_gdp_growth DESC;

-- Inflation and FDI Trends for Japan
SELECT date, inflation_rate, fdi_usd
FROM economic_indicators
WHERE country = 'Japan'
ORDER BY date;
-- View for Inflation and FDI Trends
CREATE VIEW inflation_fdi_country AS
SELECT date, country, inflation_rate, fdi_usd
FROM economic_indicators
ORDER BY date;
-- Using View for inflation
SELECT * FROM inflation_fdi_country WHERE country = 'Germany';

-- Total Exports as % of GDP by Year for Asia
SELECT YEAR(date) AS year, AVG(exports_gdp) AS avg_exports_gdp
FROM economic_indicators
JOIN locations ON economic_indicators.location_id = locations.location_id
WHERE region = 'Asia'
GROUP BY year
ORDER BY year;
-- View for Total Exports as % of GDP by Year
CREATE VIEW exports_gdp_region AS
SELECT YEAR(date) AS year, region, AVG(exports_gdp) AS avg_exports_gdp
FROM economic_indicators
JOIN locations ON economic_indicators.location_id = locations.location_id
GROUP BY year, region
ORDER BY year;
-- Using View
SELECT * FROM exports_gdp_region WHERE region = 'Europe';

-- Stored Procedure for Top N Countries by GDP
DELIMITER //
CREATE PROCEDURE GetTopCountriesByGDP(IN top_n INT)
BEGIN
	SELECT country, gdp_usd
    FROM economic_indicators
    WHERE date = (SELECT MAX(date) FROM economic_indicators)
    ORDER BY gdp_usd DESC
    LIMIT top_n;
END //

DELIMITER ; 
-- Call Stored Procedure for the top 5 countries by GDP
CALL GetTopCountriesByGDP(5);

-- Stored Procedure for Average Inflation by Year for a specific country
DELIMITER //
CREATE PROCEDURE GetAvgInflationByCountry(IN country VARCHAR(50))
BEGIN
	SELECT YEAR(date) AS year, AVG(inflation_rate) AS avg_inflation
    FROM economic_indicators
    WHERE country = country
    GROUP BY year
    ORDER BY year;
END //
DELIMITER ;
-- Calling stored procedure
CALL GetAvgInflationByCountry('Germany');

-- Function 1: to Calculate GDP per Capita Growth Rate
DELIMITER //
CREATE FUNCTION GetGDPPerCapitaGrowthRate(country VARCHAR(50),year_val INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE gdp_curr DECIMAL(15,2);
    DECLARE gdp_prev DECIMAL(15,2);
    DECLARE growth_rate DECIMAL(5,2);
    
    -- Get GDP per capita for the specified yea
    SELECT gdp_per_capita_usd INTO gdp_curr
    FROM economic_indicators
    WHERE country = country AND YEAR(date) = year_val
    LIMIT 1;
    
    -- Get GDP per capita for the previous year
    SELECT gdp_per_capita_usd INTO gdp_prev
    FROM economic_indicators
    WHERE country = country AND YEAR(date) = year_val - 1
    LIMIT 1;
    
    -- Calculate growth rate
    SET growth_rate = ((gdp_curr - gdp_prev) / gdp_prev) * 100;
    
    RETURN growth_rate;
    END // 
DELIMITER ;
-- Use this function
SELECT GetGDPPerCapitaGrowthRate('Australia', 2020);

-- Function 2: to get average inflation rate for certain country
DELIMITER //
CREATE FUNCTION GetAvgInflation(country VARCHAR(50))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE avg_inflation DECIMAL(5,2);
    
    -- Calculate average inflation
    SELECT AVG(inflation_rate) INTO avg_inflation
    FROM economic_indicators
    WHERE country = country;
    
    RETURN avg_inflation;
END //
DELIMITER ;
-- Use this function
SELECT GetAvgInflation('Japan');

-- Function 3: to calculate year-over-year GDP growth rate
DELIMITER //
CREATE FUNCTION GetYoYGDPGrowth(country VARCHAR(50),year_val INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
	DECLARE gdp_curr DECIMAL(15,2);
    DECLARE gdp_prev DECIMAL(15,2);
    DECLARE growth_rate DECIMAL(5,2);
    
    -- Get GDP for the specified year
    SELECT gdp_usd INTO gdp_curr
    FROM economic_indicators
    WHERE country = country AND YEAR(date) = year_val
    LIMIT 1;
    
    -- Get GDP for the previous year
    SELECT gdp_usd INTO gdp_prev
    FROM economic_indicators
    WHERE country = country AND YEAR(date) = year_val - 1
    LIMIT 1;
    
    -- CALCULATE growth rate
    SET growth_rate = ((gdp_curr - gdp_prev) / gdp_prev) * 100;
    
    RETURN growth_rate;
END //
DELIMITER ;
-- Use this function
SELECT GetYoYGDPGrowth('Canada',2020);