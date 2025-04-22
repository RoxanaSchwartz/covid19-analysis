/*
COVID-19 Analysis with BigQuery
Steps: Schema validation, data cleansing, top 10 region analysis
*/

-- check schema
SELECT *
FROM `bigquery-public-data.covid19_open_data.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'covid19_open_data';

-- preview data
SELECT *
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
LIMIT 10;

-- check data quality (NULL)
SELECT 
  COUNT(*) AS total_rows,
  SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_date,
  SUM(CASE WHEN location_key IS NULL THEN 1 ELSE 0 END) AS null_location,
  SUM(CASE WHEN new_confirmed IS NULL THEN 1 ELSE 0 END) AS null_confirmed
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
LIMIT 10000;

-- check data quality (count duplicates)
SELECT 
  date,
  location_key,
  COUNT(*) AS duplicate_count
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
GROUP BY date, location_key
HAVING COUNT(*) > 1
LIMIT 10;

-- check data quality (outliners)
SELECT 
  date,
  location_key,
  new_confirmed
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE new_confirmed > 1000000  
LIMIT 10;

-- clean data & create table
CREATE TABLE `covid19-analysis-457510.covid19.cleaned_covid_data` AS
SELECT 
  date,
  location_key,
  new_confirmed
FROM `bigquery-public-data.covid19_open_data.covid19_open_data`
WHERE date IS NOT NULL
  AND location_key IS NOT NULL
  AND new_confirmed IS NOT NULL
  AND new_confirmed < 1000000
LIMIT 100000;

-- analysis
SELECT 
  location_key, 
  COUNT(*) AS total_records,
  SUM(new_confirmed) AS total_confirmed,
  AVG(new_confirmed) AS avg_confirmed
FROM `covid19-analysis-457510.covid19.cleaned_covid_data`
GROUP BY location_key
ORDER BY total_confirmed DESC
LIMIT 10;