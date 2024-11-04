# SQL-Project-using-World-Bank-API
## Project Overview
This project performs an in-depth analysis of World Bank data to explore economic, demographic, and sustainability trends across various countries and regions. The analysis is conducted through SQL queries, views, stored procedures, and functions, with a structured approach across four main areas:
- Data Collection and Preprocessing
- Economic Performance Analysis
- Demographic Trends Analysis
- Sustainability Analysis
The goal of this project is to showcase SQL skills through complex queries and analysis, providing insights into global indicators such as GDP, life expectancy, renewable energy consumption, and access to electricity.

## Project Structure 
The project consists of four main Jupyter Notebooks and SQL scripts, each focusing on a specific aspect of the data analysis. Here’s a breakdown:
0) Data Collection and Preprocessing.ipynb - Data collection from external APIs, data cleaning, and preprocessing to ensure data consistency before loading into the database.
1) Database and Table Creation - Scripts to create the database schema, including the necessary tables and relationships.
- Database and Table Creation.sql
- Database and Table Creation.docx - Explanation of each table and sample queries.
2) Economic Performance Analysis - Analyzes economic data like GDP and inflation using queries, views, and functions.
- Economic Performance Analysis.sql
- Economic Performance Analysis.docx - Explanation of the queries, views, and stored procedures.
3) Demographic Trends Analysis - Examines demographic indicators such as population growth, urbanization, and life expectancy.
- Demographic Trends Analysis.sql
- Demographic Trends Analysis.docx - Explanation of the queries, views, and stored procedures.
4) Sustainability Analysis - Focuses on sustainability metrics, particularly access to electricity and renewable energy.
- Sustainability Analysis.sql
- Sustainability Analysis.docx - Explanation of the queries, views, and stored procedures.

## Database Schema
### Tables
The database contains the following tables:
- locations - Stores information about each location, including location_id, country, countryiso3code, and region.
- economic_indicators - Contains economic metrics like GDP, GDP per capita, inflation, and unemployment rates.
- demographic_indicators - Holds demographic data such as population growth, urban population, life expectancy, -and child mortality rates.
- sustainable_indicators - Includes sustainability indicators, such as access to electricity and renewable energy consumption.
### Entity-Relationship Diagram (ERD)
An ERD diagram is included in the project to illustrate the relationships between the tables, enabling a clear understanding of how data is structured.

## Analysis Goals
1) Economic Performance Analysis
- Objective: To understand economic trends across countries and regions.
- Key Queries: Includes GDP growth rate analysis, inflation trends, FDI analysis, and exports as a percentage of GDP.
- Stored Procedures and Functions: Created for specific analyses like retrieving top countries by GDP and calculating GDP growth.
2) Demographic Trends Analysis
- Objective: To explore demographic changes such as population growth and life expectancy.
- Key Queries: Identifies countries with high urban populations, analyzes child mortality rates, and tracks population trends over time.
- Stored Procedures and Functions: Includes procedures to calculate average population growth and functions to retrieve life expectancy data.
3) Sustainability Analysis
- Objective: To examine access to electricity and renewable energy consumption trends.
- Key Queries: Focus on access to electricity by region, renewable energy consumption, and identifying countries with low electricity access.
- Stored Procedures and Functions: Includes procedures for retrieving electricity access trends and functions to calculate average renewable energy consumption.

## Setup Instructions
### Requirements
- MySQL: Set up a MySQL database for data storage and queries.
- Python: Use Jupyter Notebook to run the data collection and preprocessing steps.
### Steps to run the project
1. Database Setup: Use 1) Database and Table Creation.sql to create the necessary database schema in MySQL.
2. Data Import: Load the preprocessed data into the MySQL tables.
3. Run Analyses:
- Execute the SQL scripts (2) Economic Performance Analysis.sql, 3) Demographic Trends Analysis.sql, 4) Sustainability Analysis.sql) to perform the various analyses.
- Alternatively, you can query the database using the views, stored procedures, and functions provided.

## Results Interpretation
The results from each analysis provide insights into:
- Economic: Identifies leading economies, inflation patterns, and GDP growth trends.
- Demographic: Highlights countries with high urbanization, high life expectancy, and low child mortality.
- Sustainability: Shows leaders in renewable energy and regions with high electricity access.


## License
This project is licensed under the MIT License.












