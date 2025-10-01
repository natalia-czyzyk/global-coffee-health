-- Average coffee intake by country

SELECT Country,
       AVG(Coffee_Intake) AS Avg_Coffee_Intake,
       AVG(Caffeine_mg) AS Avg_Caffeine
FROM users u
JOIN coffee c ON u.ID = c.ID
GROUP BY Country
ORDER BY Avg_Coffee_Intake DESC;

-- Consumers who drink more coffee than the average

SELECT u.ID, u.Age, u.Gender, c.Coffee_Intake
FROM users u
JOIN coffee c ON u.ID = c.ID
WHERE c.Coffee_Intake > (
    SELECT AVG(Coffee_Intake) 
    FROM coffee)
ORDER BY c.Coffee_Intake DESC
;

-- Biggest coffee consumers in the dataset

SELECT u.ID, u.Age, u.Gender, c.Coffee_Intake, c.Caffeine_mg
FROM users u
JOIN coffee c ON u.ID = c.ID
WHERE c.Coffee_Intake > 3
ORDER BY c.Coffee_Intake DESC;


-- Average sleep hours by 10 year age groups

SELECT 
    CASE
        WHEN u.Age BETWEEN 18 AND 19 THEN '18-19'
        WHEN u.Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN u.Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN u.Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN u.Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN u.Age BETWEEN 60 AND 69 THEN '60-69'
        ELSE '70+' 
    END AS Age_Bin,
    AVG(h.Sleep_Hours) AS Avg_Sleep
FROM users u
JOIN health h ON u.ID = h.ID
GROUP BY Age_Bin
ORDER BY Age_Bin;


-- Average sleep hours vs. coffee intake level

SELECT 
    CASE
        WHEN c.Coffee_Intake BETWEEN 0 AND 1 THEN '0-1 cups'
        WHEN c.Coffee_Intake BETWEEN 1.1 AND 3 THEN 'more than 1 cup'
        WHEN c.Coffee_Intake BETWEEN 3.1 AND 5 THEN 'more than 3 cups'
        ELSE 'more than 5 cups'
    END AS Coffee_Level,
    AVG(h.Sleep_Hours) AS Avg_Sleep
FROM users u
JOIN coffee c ON u.ID = c.ID
JOIN health h ON u.ID = h.ID
GROUP BY Coffee_Level
ORDER BY Coffee_Level;