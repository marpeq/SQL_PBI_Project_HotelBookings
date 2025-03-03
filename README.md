# SQL_PBI_Project_HotelBookings
SQL/PowerBI Beginner Project - Hotel booking data analysis

![Captura de ecrã 2025-03-03 161342](https://github.com/user-attachments/assets/bc0df2d2-c6ea-403d-bbf9-12a716768c9e)

This Power BI project analyzes hotel revenue, average daily rates, guest counts, and parking requirements over time for two hotels. The data spans 2018 to 2020.

Key Visualizations
- Hotel Revenue (total, over time, and by hotel)
- Average Daily Rate (ADR) (average daily, over time, and by hotel)
- Hotel Guests (total, over time and by hotel)
- Daily Parking Required (average daily, over time and by hotel)

Files in This Repository
- HotelBookings.pbix – Power BI report
- CreateTables_SQL_script.sql – PostgreSQL script used to create the database tables used in PBI. Created using the tables in the CSV files
- hotel_revenue_2018.csv – Revenue data for 2018
- hotel_revenue_2019.csv – Revenue data for 2019
- hotel_revenue_2020.csv – Revenue data for 2020
- hotel_revenue_market_segment.csv – Revenue categorized by market segment
- hotel_revenue_meal_cost.csv – Revenue categorized by meal cost

How to Use This Project
1. Upload the CSV files into a PostgreSQL database.
2. Run CreateTables_SQL_script.sql to create the necessary tables.
3. Open Power BI and import the two newly created tables: hotel_data and hotel_parking_summary.
4. Load HotelBookings.pbix in Power BI.
5. Explore the visualizations.



