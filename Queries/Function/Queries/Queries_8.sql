-- 8. Display patients with multiple appointments.
SELECT p.patient_id, p.full_name, COUNT(a.appointment_id) AS total_appointments
FROM Patient p
JOIN Appointment a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.full_name
HAVING COUNT(a.appointment_id) > 1;