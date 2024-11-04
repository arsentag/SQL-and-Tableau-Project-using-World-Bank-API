CREATE DATABASE world_bank_data;
USE world_bank_data;


-- Table 1 locations with location_id as the primary key
CREATE TABLE locations (
location_id INT PRIMARY KEY,
country VARCHAR(50),
countryiso3code VARCHAR(10),
region VARCHAR(50)
);

-- Table 2 economic_indicators with indicator_id as primary key
CREATE TABLE economic_indicators (
indicator_id INT PRIMARY KEY,
location_id INT,
country VARCHAR(50),
date DATE,
gdp_usd DECIMAL(15,2),
gdp_per_capita_usd DECIMAL(15,2),
inflation_rate DECIMAL(5,2),
fdi_usd DECIMAL(15,2),
exports_gdp DECIMAL(5,2),
unemployment_rate DECIMAL(5,2),
unemployment_growth_rate DECIMAL(5,2),
gdp_growth_rate DECIMAL(5,2),
high_gdp TINYINT,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Table 3 demographic_indicators with demographic_id as primary key
CREATE TABLE demographic_indicators (
demographic_id INT PRIMARY KEY,
location_id INT,
country VARCHAR(50),
date DATE,
population_total INT,
population_growth DECIMAL(5,2),
urban_population DECIMAL(5,2),
urbanization_rate_change DECIMAL(5,2),
life_expectancy DECIMAL(5,2),
child_mortality_rate DECIMAL(5,2),
primary_school_enrollment DECIMAL(5,2),
FOREIGN KEY(location_id) REFERENCES locations(location_id)
);

-- Table 4 sustainable_indicators with sustainable_id as primary key
CREATE TABLE sustainable_indicators (
sustainable_id INT PRIMARY KEY,
location_id INT,
country VARCHAR(50),
date DATE,
access_electricity DECIMAL(5,2),
renewable_energy_consumption DECIMAL(5,2),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- View a Sample of Data
SELECT * FROM economic_indicators LIMIT 10;

-- Countries with the Highest GDP Growth Rate
SELECT country, date, gdp_growth_rate
FROM economic_indicators
ORDER BY gdp_growth_rate DESC
LIMIT 100;

-- Count the Number of Records per Country
SELECT country, COUNT(*) AS record_count
FROM economic_indicators
GROUP BY country
ORDER BY record_count DESC;


-- Top 10 Countries with the Highest Renewable Energy Consumption
SELECT country, renewable_energy_consumption
FROM sustainable_indicators
ORDER BY renewable_energy_consumption DESC
LIMIT 10;

-- Average Unemployment Rate by Year
SELECT YEAR(date) AS year, AVG(unemployment_rate) AS avg_unemployment
FROM economic_indicators
GROUP BY year
ORDER BY year;