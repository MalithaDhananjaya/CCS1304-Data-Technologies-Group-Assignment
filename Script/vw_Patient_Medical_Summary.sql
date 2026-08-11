CREATE VIEW vw_Patient_Medical_Summary AS
SELECT 
    p.patient_id,
    p.full_name AS patient_name,
    d.doctor_name,
    t.diagnosis,
    t.prescription,
    t.treatment_date
FROM Patient p
JOIN Treatment t ON p.patient_id = t.patient_id
JOIN Doctor d ON t.doctor_id = d.doctor_id;