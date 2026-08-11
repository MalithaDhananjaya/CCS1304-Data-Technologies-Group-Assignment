-- 9. List laboratory tests completed within a given date range.
SELECT lt.lab_test_id, p.full_name AS patient_name, lt.test_name, lt.test_date, lt.test_result, lt.technician_name
FROM Lab_Test lt
JOIN Patient p ON lt.patient_id = p.patient_id
WHERE lt.test_status = 'Completed' 
  AND lt.test_date BETWEEN '2026-07-01 00:00:00' AND '2026-07-05 23:59:59';