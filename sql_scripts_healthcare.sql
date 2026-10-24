CREATE  DATABASE hospital_data;
USE hospital_data;
SELECT* FROM cleaned_healthcare_dataset;

ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Name` TO `patient_name`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Age` TO `age`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Gender` TO `gender`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Blood Type` TO `blood_type`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Medical Condition` TO `medical_condition`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Doctor` TO `doctor`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Hospital` TO `hospital`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Medication` TO `medication`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Test Results` TO `test_results`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Date of Admission` TO `date_of_admission`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Discharge Date` TO `discharge_date`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Admission Type` TO `admission_type`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Room Number` TO `room_number`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Length of stay` TO `length_of_stay`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Insurance Provider` TO `insurance_provider`;
ALTER TABLE cleaned_healthcare_dataset RENAME COLUMN `Billing Amount` TO `billing_amount`;

WITH avg_billing AS (
    SELECT AVG(billing_amount) AS overall_avg_bill 
    FROM cleaned_healthcare_dataset
)
SELECT 
    patient_name, 
    age, 
    gender,  
    medical_condition, 
    date_of_admission, 
    doctor, 
    hospital, 
    insurance_provider, 
    billing_amount,
    room_number, 
    admission_type, 
    discharge_date, 
    medication, 
    test_results, 
    length_of_stay,
    
 
    CASE 
        WHEN age < 35 THEN 'Young'
        WHEN age BETWEEN 35 AND 55 THEN 'Middle Aged'
        ELSE 'Senior'
    END AS age_group,

    CASE 
        WHEN medication IN ('Paracetamol', 'Aspirin') THEN 'Analgesic'
        WHEN medication = 'Ibuprofen' THEN 'NSAID'
        WHEN medication = 'Penicillin' THEN 'Antibiotic'
        WHEN medication = 'Lipitor' THEN 'Cardiovascular'
        ELSE 'General'
    END AS drug_category,

    CASE 
        WHEN billing_amount > (SELECT overall_avg_bill FROM avg_billing)
        THEN 'High Value Patient'
        ELSE 'Standard Patient'
    END AS high_value_patient,

    RANK() OVER(PARTITION BY medical_condition ORDER BY billing_amount DESC) AS condition_billing_rank

FROM cleaned_healthcare_dataset;

SELECT AGE 
FROM Cleaned_healthcare_dataset 
ORDER BY age ASC;