DELIMITER //

CREATE FUNCTION fn_GetTotalPaidByPatient(p_patient_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);
    
    SELECT IFNULL(SUM(total_amount), 0.00) INTO v_total
    FROM Billing
    WHERE patient_id = p_patient_id AND payment_status = 'Paid';
    
    RETURN v_total;
END //

DELIMITER ;