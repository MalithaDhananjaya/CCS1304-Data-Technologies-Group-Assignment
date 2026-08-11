-- 10. Display room availability.
SELECT r.room_id, r.bed_number, rc.category_name, rc.daily_rate, r.room_status
FROM Room r
JOIN Room_Category rc ON r.category_id = rc.category_id
WHERE r.room_status = 'Available';