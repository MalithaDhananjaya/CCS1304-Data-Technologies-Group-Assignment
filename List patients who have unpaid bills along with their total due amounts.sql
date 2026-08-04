SELECT 
    p.patient_id,
    p.full_name AS patient_name,
    p.contact_number,
    b.bill_id,
    b.total_amount,
    b.payment_status
FROM Patient p
JOIN Billing b ON p.patient_id = b.patient_id
WHERE b.payment_status = 'Unpaid';