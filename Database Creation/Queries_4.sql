-- 4. Find patients admitted to ICU rooms.
SELECT p.patient_id, p.full_name, r.bed_number, rc.category_name, adm.admission_date
FROM Admission adm
JOIN Patient p ON adm.patient_id = p.patient_id
JOIN Room r ON adm.room_id = r.room_id
JOIN Room_Category rc ON r.category_id = rc.category_id
WHERE rc.category_name = 'ICU' AND adm.admission_status = 'Admitted';