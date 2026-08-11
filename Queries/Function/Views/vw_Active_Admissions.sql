CREATE VIEW vw_Active_Admissions AS
SELECT 
    a.admission_id,
    p.full_name AS patient_name,
    r.bed_number,
    rc.category_name,
    rc.daily_rate,
    a.admission_date
FROM Admission a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Room r ON a.room_id = r.room_id
JOIN Room_Category rc ON r.category_id = rc.category_id
WHERE a.admission_status = 'Admitted';