DELIMITER //

CREATE PROCEDURE sp_AdmitPatient(
    IN p_patient_id INT,
    IN p_room_id INT
)
BEGIN
    -- 1. Admission එක Insert කිරීම
    INSERT INTO Admission (patient_id, room_id, admission_date, admission_status)
    VALUES (p_patient_id, p_room_id, NOW(), 'Admitted');
    
    -- 2. Room එක 'Occupied' ලෙස Update කිරීම
    UPDATE Room 
    SET room_status = 'Occupied' 
    WHERE room_id = p_room_id;
END //

DELIMITER ;