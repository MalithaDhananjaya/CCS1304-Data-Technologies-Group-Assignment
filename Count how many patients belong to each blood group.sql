SELECT 
    blood_group,
    COUNT(patient_id) AS patient_count
FROM Patient
GROUP BY blood_group;