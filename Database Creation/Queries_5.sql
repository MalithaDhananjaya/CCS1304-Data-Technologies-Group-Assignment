-- 5. Display unpaid bills.
SELECT b.bill_id, p.full_name, b.total_amount, b.bill_date, b.payment_method
FROM Billing b
JOIN Patient p ON b.patient_id = p.patient_id
WHERE b.payment_status = 'Unpaid';