DELIMITER //

CREATE TRIGGER trg_After_Admission_Insert
AFTER INSERT ON Admission
FOR EACH ROW
BEGIN
    UPDATE Room 
    SET room_status = 'Occupied' 
    WHERE room_id = NEW.room_id;
END //

DELIMITER ;