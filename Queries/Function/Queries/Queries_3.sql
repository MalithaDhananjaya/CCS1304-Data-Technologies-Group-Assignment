-- 3. Display appointments scheduled for a specific doctor (e.g., Dr. Sunil Perera).
SELECT a.appointment_id, p.full_name AS patient_name, a.appointment_date, a.appointment_time, a.status, a.consultation_room
FROM Appointment a
JOIN Patient p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1 AND a.status = 'Scheduled';