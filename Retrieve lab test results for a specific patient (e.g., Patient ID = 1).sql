SELECT 
    p.full_name AS patient_name,
    lt.test_name,
    lt.test_date,
    lt.test_result,
    lt.test_status
FROM Lab_Test lt
JOIN Patient p ON lt.patient_id = p.patient_id
WHERE p.patient_id = 1;