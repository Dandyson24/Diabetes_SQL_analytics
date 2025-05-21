/* DIABETES DATA ANALYTICS USING SQL
From an original data set(denormalized single) with 50 columns, this was normalized into 7 tables and insights were generated*/

/* 1. Total number of unique patients
Findings: 73,426 individual patients visited for care during the reporting period*/
SELECT DISTINCT COUNT (patient_nbr)
FROM patients;

/* Total encounters within the period
Finding: 101,766 encounters were recorded. This means that many clients visited more than once*/
SELECT COUNT (encounter_id)
FROM encounters;

/* 3. Readmission Rate by Age Group
Insight: What age group has the highest rate of hospital readmission?
Use case: Helps target prevention programs for high-risk age groups.diagnoses
Findings: The older the patients, the higher the likelihood of readmission*/

SELECT 
    p.age,
    COUNT(e.encounter_id) AS total_visits,
    SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(100.0 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) / COUNT(e.encounter_id), 2) AS readmission_rate
FROM patients p
JOIN encounters e ON p.patient_nbr = e.patient_nbr
GROUP BY p.age
ORDER BY readmission_rate DESC;

/*4. Average Length of Stay by Medical Specialty
Insight: Which specialties are associated with longer hospital stays?
Use case: Identifies where resource optimization or process review may be needed
Finding: The Pediatrics-Allergyand Immunology specialty had the longest aveage stay though the number of encounters were few(3)*/


SELECT 
    medical_specialty,
    ROUND(AVG(time_in_hospital), 2) AS avg_length_of_stay,
    COUNT(*) AS num_encounters
FROM encounters
WHERE medical_specialty IS NOT NULL
GROUP BY medical_specialty
ORDER BY avg_length_of_stay DESC;

/*5. Medication Impact on Readmission using metformin as an example
Insight: Are certain medications associated with lower readmission rates?
Why: Evaluates drug effectiveness in real-world settings.*/

SELECT 
    m.metformin,
    COUNT(e.encounter_id) AS total,
    SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted,
    ROUND(100 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) / COUNT(e.encounter_id), 2) AS readmission_rate
FROM medications m
JOIN encounters e ON m.encounter_id = e.encounter_id
GROUP BY m.metformin
ORDER BY readmission_rate DESC;

/* 6 Most common Primary Diagnoses
Insight: What are the most common primary diagnoses?
Why: Helps identify top health issues for focused interventions
Findings: Diagnoses 428 was the most common*/

SELECT 
    diag_1,
    COUNT(*) AS frequency
FROM diagnoses
GROUP BY diag_1
ORDER BY frequency DESC
LIMIT 10;

/* 7.Multi-visit patient profile
Insight: What proportion of patients have multiple hospital admissions?
Use case:Identifies patients for chronic care programs.
Finding: Patient with number 88785891 visited the hospital more frequently than others
*/
SELECT 
    patient_nbr,
    COUNT(encounter_id) AS visit_count
FROM encounters
GROUP BY patient_nbr
HAVING COUNT(encounter_id) > 1
ORDER BY visit_count DESC;

/* 8.Number of Medications vs. Readmission
Insight: Does polypharmacy correlate with higher readmission?
Use: Flags patients at risk from complex regimens
Findings: Polypharmacy (Pills larger than 5 at a time were associated with higher readmission rates*/

SELECT 
    p.num_medications,
    COUNT(e.encounter_id) AS total,
    SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted,
    ROUND(100 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) / COUNT(e.encounter_id), 2) AS readmission_rate
FROM procedures p
JOIN encounters e ON p.encounter_id = e.encounter_id
GROUP BY p.num_medications
ORDER BY num_medications DESC;

/* 9. Gender Disparities in Readmission

Insight: Do males and females have different readmission rates?
Use: Highlights potential health equity issues.
Findings: Though more females were re-admitted in absolute numbers, 
there was no significant gender difference in proportions for the readmission rate
*/
SELECT 
    p.gender,
    COUNT(e.encounter_id) AS total_visits,
    SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_count,
    ROUND(100 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) / COUNT(e.encounter_id), 2) AS readmission_rate
FROM patients p
JOIN encounters e ON p.patient_nbr = e.patient_nbr
GROUP BY p.gender;

/* 10.Lab Procedures vs. Readmission
Insight: Are more lab tests associated with lower readmission?
Use: Assesses if diagnostic rigor affects outcomes
Findings: Higher number of lab procedure was associated with higher readmission rate 
and this is as expected as the clinicians would want to ascertain present state of health per visit

*/

SELECT 
    pr.num_lab_procedures,
    COUNT(e.encounter_id) AS total,
    SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted,
    ROUND(100.0 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) / COUNT(e.encounter_id), 2) AS readmission_rate
FROM procedures pr
JOIN encounters e ON pr.encounter_id = e.encounter_id
GROUP BY pr.num_lab_procedures
ORDER BY pr.num_lab_procedures DESC;

/* 11. Effect of Change in Diabetes Medication
Insight: Does changing diabetes medication affect readmission?
Use: Evaluates whether treatment adjustments improve outcomes
Finding: Medication changes are associated with readmission rates
*/
SELECT 
    tc.change,
    COUNT(e.encounter_id) AS total,
    SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted,
    ROUND(100.0 * SUM(CASE WHEN e.readmitted <> 'NO' THEN 1 ELSE 0 END) / COUNT(e.encounter_id), 2) AS readmission_rate
FROM treatment_changes tc
JOIN encounters e ON tc.encounter_id = e.encounter_id
GROUP BY tc.change;

/* 12. Average Time in Hospital by Race
Use: Ascertains which race has the highest average duration of stay
Finding: The African Americans stay longer in the hospitals averagely
*/

SELECT 
    p.race,
    ROUND(AVG(e.time_in_hospital), 2) AS avg_time_in_hospital,
    COUNT(*) AS num_encounters
FROM patients p
JOIN encounters e ON p.patient_nbr = e.patient_nbr
GROUP BY p.race
ORDER BY avg_time_in_hospital DESC;

