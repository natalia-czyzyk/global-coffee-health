CREATE TABLE coffee_health_staging (
    ID INT,
    Age INT,
    Gender TEXT,
    Country TEXT,
    Coffee_Intake FLOAT,
    Caffeine_mg FLOAT,
    Sleep_Hours FLOAT,
    Sleep_Quality TEXT,
    BMI FLOAT,
    Heart_Rate INT,
    Stress_Level TEXT,
    Physical_Activity_Hours FLOAT,
    Health_Issues TEXT,
    Occupation TEXT,
    Smoking INT,
    Alcohol_Consumption INT
    );

-- ! Import the data csv file into coffee_health_staging table !


CREATE TABLE users (
    ID INT PRIMARY KEY,
    Age INT,
    Gender TEXT,
    Country TEXT,
    Occupation TEXT
);

CREATE TABLE coffee (
    Coffee_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    ID INT,  -- foreign key to users.ID
    Coffee_Intake FLOAT,
    Caffeine_mg FLOAT,
    FOREIGN KEY (ID) REFERENCES users(ID)
);

CREATE TABLE health (
    Health_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    ID INT,  -- foreign key to users.ID
    Sleep_Hours FLOAT,
    Sleep_Quality TEXT,
    BMI FLOAT,
    Heart_Rate INT,
    Stress_Level TEXT,
    Physical_Activity_Hours FLOAT,
    Health_Issues TEXT,
    Smoking INT,
    Alcohol_Consumption INT,
    FOREIGN KEY (ID) REFERENCES users(ID)
);

INSERT OR IGNORE INTO users (ID, Age, Gender, Country, Occupation)
SELECT DISTINCT ID, Age, Gender, Country, Occupation
FROM coffee_health_staging;

INSERT INTO coffee (ID, Coffee_Intake, Caffeine_mg)
SELECT ID, Coffee_Intake, Caffeine_mg
FROM coffee_health_staging;

INSERT INTO health (
    ID, Sleep_Hours, Sleep_Quality, BMI, Heart_Rate, Stress_Level,
    Physical_Activity_Hours, Health_Issues, Smoking, Alcohol_Consumption
)
SELECT ID, Sleep_Hours, Sleep_Quality, BMI, Heart_Rate, Stress_Level,
       Physical_Activity_Hours, Health_Issues, Smoking, Alcohol_Consumption
FROM coffee_health_staging;
