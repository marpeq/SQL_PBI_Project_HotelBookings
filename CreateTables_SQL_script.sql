-- Drop the existing table if it already exists to avoid conflicts
DROP TABLE IF EXISTS hotel_data;


CREATE TABLE hotel_data as
	-- Create the hotel_data table by combining data from revenue for 2018, 2019, and 2020
    WITH tb2018_2019_2020 AS (
        SELECT * FROM revenue2018
        UNION 
        SELECT * FROM revenue2019
        UNION 
        SELECT * FROM revenue2020
    ),
    
     -- Add discount and meal cost information to the combined revenue data
    tb18_19_20_meal_disc AS (
        SELECT 
            tb2018_2019_2020.*,
            market_segment."Discount",
            meal_cost."Cost" AS meal_cost
        FROM tb2018_2019_2020
        LEFT JOIN market_segment 
            ON tb2018_2019_2020.market_segment = market_segment.market_segment
        LEFT JOIN meal_cost
            ON tb2018_2019_2020.meal = meal_cost.meal 
    ),
    
    -- Calculate the arrival date and revenue based on the number of nights stayed and discount
    tb18_19_20_meal_disc_date_rev AS (
        SELECT 
            tb18_19_20_meal_disc.*,
            DATE(
                CONCAT(
                    tb18_19_20_meal_disc.arrival_date_year, '-',
                    LPAD(
                        CASE tb18_19_20_meal_disc.arrival_date_month
                            WHEN 'January' THEN '1'
                            WHEN 'February' THEN '2'
                            WHEN 'March' THEN '3'
                            WHEN 'April' THEN '4'
                            WHEN 'May' THEN '5'
                            WHEN 'June' THEN '6'
                            WHEN 'July' THEN '7'
                            WHEN 'August' THEN '8'
                            WHEN 'September' THEN '9'
                            WHEN 'October' THEN '10'
                            WHEN 'November' THEN '11'
                            WHEN 'December' THEN '12'
                        END, 2, '0'
                    ), '-',
                    LPAD(tb18_19_20_meal_disc.arrival_date_day_of_month::TEXT, 2, '0')
                )
            ) AS arrival_date,
            (tb18_19_20_meal_disc.stays_in_weekend_nights + tb18_19_20_meal_disc.stays_in_week_nights) * 
            (tb18_19_20_meal_disc.adr * tb18_19_20_meal_disc."Discount") AS Revenue
        FROM tb18_19_20_meal_disc
    )
    
    SELECT * from tb18_19_20_meal_disc_date_rev;

-------------------------------------------------------------------------------------------------------------------------    

-- Drop the existing hotel_parking_summary table if it exists to avoid conflicts    
DROP TABLE IF EXISTS hotel_parking_summary;


-- Create the hotel_parking_summary table using recursive CTE
CREATE TABLE hotel_parking_summary AS
	WITH RECURSIVE stay_dates AS (
	    -- Base case: first stay_date
	    SELECT 
	        hotel, 
	        required_car_parking_spaces, 
	        arrival_date,  
	        arrival_date::date AS stay_date,  
	        (arrival_date + INTERVAL '1 day' * (stays_in_weekend_nights + stays_in_week_nights))::date AS departure_date
	    FROM hotel_data 
	    
	    UNION ALL
	    
	    -- Recursive case: increment the stay_date by one day
	    SELECT 
	        hotel, 
	        required_car_parking_spaces, 
	        stay_dates.arrival_date,  
	        (stay_dates.stay_date + INTERVAL '1 day')::date AS stay_date,  
	        stay_dates.departure_date
	    FROM stay_dates
	    WHERE stay_dates.stay_date < stay_dates.departure_date
	)
	
	SELECT 
	    hotel, 
	    stay_date, 
	    SUM(required_car_parking_spaces) AS total_parking_needed
	FROM stay_dates
	GROUP BY hotel, stay_date
	ORDER BY hotel, stay_date;
	    
	
    
    
    
    
    
    
