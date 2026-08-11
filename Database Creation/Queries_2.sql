-- 2. List doctors by department.
SELECT d.dept_name, doc.doctor_name, doc.specialization, doc.qualification 
FROM Doctor doc
JOIN Department d ON doc.department_id = d.department_id
ORDER BY d.dept_name;