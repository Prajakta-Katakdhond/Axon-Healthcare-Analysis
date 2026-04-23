/* ================= KPI 1 =================
   Total Patients
=========================================== */
SELECT COUNT(DISTINCT `Patient ID`) AS Total_Patients
FROM stg_patient;


/* ================= KPI 2 =================
   Total Visits
=========================================== */
SELECT COUNT(*) AS Total_Visits
FROM stg_visit;


/* ================= KPI 3 =================
   Total Revenue
=========================================== */
SELECT ROUND(SUM(`Treatment Cost`),2) AS Total_Revenue
FROM stg_treatments;


/* ================= KPI 4 =================
   Average Treatment Cost
=========================================== */
SELECT ROUND(AVG(`Treatment Cost`),2) AS Avg_Treatment_Cost
FROM stg_treatments;


/* ================= KPI 5 =================
   Visits Per Doctor
=========================================== */
SELECT 
    `Doctor ID`,
    COUNT(*) AS Total_Visits
FROM stg_visit
GROUP BY `Doctor ID`
ORDER BY Total_Visits DESC;


/* ================= KPI 6 =================
   Top 5 Most Common Diagnosis
=========================================== */
SELECT 
    Diagnosis,
    COUNT(*) AS Diagnosis_Count
FROM stg_visit
GROUP BY Diagnosis
ORDER BY Diagnosis_Count DESC
LIMIT 5;


/* ================= KPI 7 =================
   Follow-Up Required Percentage
=========================================== */
SELECT 
    ROUND(
        (SUM(CASE WHEN `Follow Up Required` = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(*)) * 100, 2
    ) AS FollowUp_Percentage
FROM stg_visit;


/* ================= KPI 8 =================
   Revenue By Treatment Type
=========================================== */
SELECT 
    `Treatment Type`,
    ROUND(SUM(`Treatment Cost`),2) AS Total_Revenue
FROM stg_treatments
GROUP BY `Treatment Type`
ORDER BY Total_Revenue DESC;


/* ================= KPI 9 =================
   Monthly Visit Trend
=========================================== */
SELECT 
    DATE_FORMAT(`Visit Date`, '%Y-%m') AS Month,
    COUNT(*) AS Total_Visits
FROM stg_visit
GROUP BY Month
ORDER BY Month;


/* ================= KPI 10 =================
   Top 5 Revenue Generating Doctors
=========================================== */
SELECT 
    v.`Doctor ID`,
    ROUND(SUM(t.`Treatment Cost`),2) AS Doctor_Revenue
FROM stg_visit v
JOIN stg_treatments t 
    ON v.`Visit ID` = t.`Visit ID`
GROUP BY v.`Doctor ID`
ORDER BY Doctor_Revenue DESC
LIMIT 5;


/* ================= KPI 11 =================
   Average Patient Age
=========================================== */
SELECT ROUND(AVG(Age),1) AS Avg_Patient_Age
FROM stg_patient;
