SELECT 
    p.patient_id,
    p.full_name AS patient_name,
    r.room_category,
    r.bed_number,
    adm.admission_date
FROM Admission adm
JOIN Patient p ON adm.patient_id = p.patient_id
JOIN Room r ON adm.room_id = r.room_id
WHERE adm.admission_status = 'Admitted';