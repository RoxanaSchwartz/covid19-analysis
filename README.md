# COVID-19 Data Analysis

## Overview
This project analyzes COVID-19 data using BigQuery, including schema exploration, data cleaning, and aggregation of the top 10 regions by confirmed cases.

## Steps
1. **Schema Exploration**: Inspected columns (e.g., location_key, date, new_confirmed).
2. **Data Preview**: Viewed initial data (e.g., RO, US_AK).
3. **Quality Check**: Checked for NULLs, duplicates, and outliers.
4. **Data Cleaning**: Created a clean table `cleaned_covid_data`.
5. **Analysis**: Aggregated top 10 regions by confirmed cases (see `covid_data_cleaned.csv`).

## Files
- `covid19_analysis.sql`: SQL queries for the analysis
- `covid_data_cleaned.csv`: Results of the top 10 regions
