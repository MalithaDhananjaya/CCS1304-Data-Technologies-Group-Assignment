SELECT 
    p.patient_id,
    p.full_name AS patient_name,
    a.appointment_date,
    a.appointment_time,
    a.appointment_status,
    d.doctor_name,
    d.specialization
FROM Patient p
JOIN Appointment a ON p.patient_id = a.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id;