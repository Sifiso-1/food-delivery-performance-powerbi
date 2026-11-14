-- PROJECT: Food Delivery Performance Analysis
-- FILE: delivery_clean | TABLE: delivery_clean

-- 1. REMOVE NULLS / BLANK ROWS
DELETE FROM delivery_clean
WHERE driver_rating IS NULL
   OR area IS NULL
   OR delivery_time IS NULL
   OR order_date IS NULL;

-- 2. FIX DATES
-- order_date was showing as ####### / text, convert to DATE
UPDATE delivery_clean
SET order_date = TRY_CAST(order_date AS DATE)
WHERE order_date IS NOT NULL;

-- 3. CREATE / FIX ON-TIME vs LATE
-- You already have is_late, so we recalculate it to be 100% correct
UPDATE delivery_clean
SET is_late = CASE
    WHEN delivery_time > promised_time THEN 'Yes'
    ELSE 'No'
END;

-- 4. FIX AREA NAMES
-- Standardise area: Midrand, Soweto, Sandton, etc.
UPDATE delivery_clean
SET area = TRIM(area);

UPDATE delivery_clean
SET area = 'Midrand' WHERE LOWER(area) IN ('midrand ', 'midrand', 'midrand  ');
UPDATE delivery_clean
SET area = 'Soweto' WHERE LOWER(area) IN ('soweto ', 'soweto', 'soweto  ');
UPDATE delivery_clean
SET area = 'Sandton' WHERE LOWER(area) LIKE '%sandton%';
UPDATE delivery_clean
SET area = 'Fourways' WHERE LOWER(area) LIKE '%fourways%';
UPDATE delivery_clean
SET area = 'Roodepoort' WHERE LOWER(area) LIKE '%roodepoort%';

-- Also fix restaurant names that got cut off
UPDATE delivery_clean
SET restaurant = 'McDonalds' WHERE restaurant LIKE 'McDonald%';
UPDATE delivery_clean
SET restaurant = 'Chicken Licken' WHERE restaurant LIKE 'Chicken Lik%';

-- 5. REMOVE DUPLICATES
WITH Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY order_date) AS rn
    FROM delivery_clean
)
DELETE FROM Duplicates
WHERE rn > 1;

-- FINAL CHECK - This should give you On-Time ~4.8 and Late ~3.5
SELECT is_late, COUNT(*) AS Total_Orders, AVG(driver_rating) AS Avg_Rating
FROM delivery_clean
WHERE order_status = 'Delivered'
GROUP BY is_late;