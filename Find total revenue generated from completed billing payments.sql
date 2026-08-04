SELECT 
    SUM(total_amount) AS total_revenue
FROM Billing
WHERE payment_status = 'Paid';