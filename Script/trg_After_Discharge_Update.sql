DELIMITER //

CREATE TRIGGER trg_After_Discharge_Update
AFTER UPDATE ON Admission
FOR EACH ROW
BEGIN
    IF NEW.admission_status = 'Discharged' AND OLD.admission_status != 'Discharged' THEN
        UPDATE Room 
        SET room_status = 'Available' 
        WHERE room_id = NEW.room_id;
    END IF;
END //

DELIMITER ;