/* Ellen alves
Created date: 06/2026
Project Title:
Customer Booking and Revenue Analysis Using SQL
*/

--Query 1 — Total Bookings

SELECT
count(*) AS Total_Bookings
FROM Hotel_bookings;

--Query 2A- Cancellation Overview

SELECT
is_canceled,
count(*) AS Total_Bookings
FROM Hotel_bookings
GROUP BY is_canceled;

--Query 2B- Cancellation Rate

SELECT
count(*) AS Total_Bookings,
sum (is_canceled) AS Canceled_Bookings, 
round (
sum(is_canceled) *100.0 / count(*), 2)
As Cancellation_Rate_Percent
FROM Hotel_bookings;

--Query 3 - Revenue by Customer Type
--Obs: ADR = Average Daily Rate

SELECT
customer_type,
count (*) AS Total_Bookings, 
round (
sum(adr * length_of_stay), 2) AS Estimated_Revenue 
From 
Hotel_bookings
WHERE is_canceled = 0
GROUP BY customer_type
ORDER BY Estimated_Revenue DESC;

--Query 4 - Cancellation Rate by Distribution Channel

SELECT
distribution_channel,
count (*) as Total_Bookings, 
sum (is_canceled) As Canceled_Bookings, 
round(
sum (is_canceled) * 100.0 /count(*), 
2)
As Cancellation_Rate_Percent
FROM Hotel_bookings
GROUP BY distribution_channel
ORDER BY Cancellation_Rate_Percent DESC;

--Query 5- Monthly Booking Volume

SELECT
arrival_date_month,
count (*) AS Total_Bookings
FROM Hotel_bookings
GROUP BY arrival_date_month
ORDER BY Total_Bookings DESC;


-- Query 6 - Lead Time Categories

SELECT
CASE
WHEN lead_time <= 30 THEN 'Short Lead Time'
WHEN lead_time <= 90 THEN 'Medium Lead Time'
ELSE 'Long Lead Time'
END as Lead_Time_Category ,
count (*) as Total_Bookings
FROM Hotel_bookings
GROUP BY Lead_Time_Category 
ORDER BY Total_Bookings DESC; 
