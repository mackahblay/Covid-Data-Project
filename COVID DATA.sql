-- MELCHIZEDEK ACKAH-BLAY
-- 20 FEBRUARY 2024
-- COVID DATASET PROJECT USING MYSQL WORKBENCH

 

CREATE DATABASE COVID;
USE COVID;

CREATE TABLE covid_data(
start_date DATE,
end_date DATE,
the_group VARCHAR(20),
year VARCHAR(20),
month VARCHAR(20),
state VARCHAR(20),
condition_group VARCHAR(35),
the_condition VARCHAR(45),
age_group VARCHAR(10),
covid_deaths INT,
number_of_mentions INT
);

-- I have finished importing the data, now displaying the results

SELECT * FROM covid_data;
 
-- Removed the year and month columns because their data was not imported correctly
ALTER TABLE covid_data
DROP COLUMN month;


-- ---------------------------- DATA EXPLORATION -------------------------------------

-- 1. Which states had the highest number of COVID-19 deaths during the specified time period?
SELECT state, SUM(covid_deaths) AS total_covid_deaths
FROM covid_data
WHERE state <> 'United States'
GROUP BY state
ORDER BY total_covid_deaths DESC;

-- 2. What are the most common conditions contributing to COVID-19 deaths across all states?
SELECT the_condition, COUNT(the_condition) AS total_condition
FROM covid_data
GROUP BY the_condition
ORDER BY total_condition DESC; 

-- 3. How do COVID-19 deaths vary by age group? Are certain age groups more affected than others?
SELECT age_group, SUM(covid_deaths) AS total_deaths
FROM covid_data
GROUP BY age_group
ORDER BY total_deaths DESC;

-- 4. Are there any correlations between specific conditions and COVID-19 deaths, considering different age groups?
SELECT age_group, the_condition, COUNT(the_condition) AS total_condition
FROM covid_data
GROUP BY age_group,the_condition 
ORDER BY total_condition DESC; 

-- 5. How does the number of mentions of conditions contributing to COVID-19 deaths vary by state?
SELECT state, SUM(number_of_mentions) AS mentions
FROM covid_data
GROUP BY state
ORDER BY mentions DESC;

-- 6. What is the proportion of COVID-19 deaths attributable to each contributing condition?
SELECT the_condition, SUM(covid_deaths) AS deaths
FROM covid_data
GROUP BY the_condition
ORDER BY deaths DESC;

-- 7. What is the ratio of COVID-19 deaths to the total number of deaths within each age group and state?
SELECT state, age_group, ROUND(AVG(covid_deaths), 2) AS deaths 
FROM covid_data
WHERE state <> 'United States'
GROUP BY state, age_group
ORDER BY deaths DESC;

-- 8. How do COVID-19 deaths vary by age group?
SELECT age_group, SUM(covid_deaths) AS covid_deaths
FROM covid_data
WHERE age_group <> 'All Ages'
GROUP BY age_group
ORDER BY covid_deaths DESC;

-- 9. What states and age group had the lowest COVID-19 deaths?
SELECT state, age_group, SUM(covid_deaths) AS covid_deaths
FROM covid_data
WHERE state <> 'United States' AND age_group <> 'Not stated'
GROUP BY state, age_group
ORDER BY covid_deaths;

-- 10. What condition group resulted in the highest COVID-19 deaths?
SELECT condition_group, SUM(covid_deaths) AS covid_deaths
FROM covid_data
GROUP BY condition_group
ORDER BY covid_deaths DESC;

-- 11. What interventions or policies might be effective in reducing 
-- COVID-19 mortality rates based on the analysis of contributing conditions?

-- SOLUTION: Given that most of the COVID-19 deaths are people in the 75-84, there shoud be more investment
-- and awareness towards their well-being. Additionally, the World Health Organization should allocate more
-- resources to 75-84 year olds in unfortunate situations

-- 12. Are there any geographic clusters or hotspots of COVID-19 deaths?
SELECT state, condition_group, the_condition, age_group, SUM(covid_deaths) AS covid_deaths
FROM covid_data
WHERE state <> 'United States'
GROUP BY state, condition_group, the_condition, age_group
ORDER BY covid_deaths DESC;

-- In California, Texas, and Floria, which are the top 3 states with the most COVID-19 deaths respectively,
-- the most common condition group as well as condition is COVID-19
-- Disecting the data by age groups, 85+ year olds in California have the highest COVID-19 deaths. 
-- Once again, the condition group and the condition are COVID-19
-- The next 4 age groups with the highest COVID-19 deaths all have COVID-19 as both the condition group and the condition 




