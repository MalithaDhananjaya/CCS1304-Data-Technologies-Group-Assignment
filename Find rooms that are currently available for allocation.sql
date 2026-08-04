SELECT 
    room_id,
    room_category,
    bed_number
FROM Room
WHERE is_available = TRUE;