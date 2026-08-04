SELECT 
    p.full_name AS patient_name,
    b.consultation_charges,
    b.room_charges,
    b.lab_charges,
    b.medicine_charges,
    b.total_amount
FROM Billing b
JOIN Patient p ON b.patient_id = p.patient_id;