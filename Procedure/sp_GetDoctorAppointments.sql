DELIMITER //

CREATE PROCEDURE sp_GetDoctorAppointments(IN p_doctor_id INT)
BEGIN
    SELECT 
        a.appointment_id,
        p.full_name AS patient_name,
        p.contact_number,
        a.appointment_date,
        a.appointment_time,
        a.consultation_room
    FROM Appointment a
    JOIN Patient p ON a.patient_id = p.patient_id
    WHERE a.doctor_id = p_doctor_id AND a.status = 'Scheduled'
    ORDER BY a.appointment_date, a.appointment_time;
END //

DELIMITER ;