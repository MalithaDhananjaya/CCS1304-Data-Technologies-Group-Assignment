SELECT 
    d.doctor_name,
    d.qualification,
    d.consultation_fee,
    dept.dept_name
FROM Doctor d
JOIN Department dept ON d.department_id = dept.department_id
WHERE dept.dept_name = 'Cardiology';