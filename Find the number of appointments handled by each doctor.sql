SELECT 
    d.doctor_id,
    d.doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments
FROM Doctor d
LEFT JOIN Appointment a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name, d.specialization;