-- 7. Find the most frequently visited doctor.
SELECT d.doctor_id, d.doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM Doctor d
JOIN Appointment a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY total_appointments DESC
LIMIT 1;