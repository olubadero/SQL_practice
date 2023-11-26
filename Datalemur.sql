-- https://datalemur.com/questions

-- Cities With Completed Trades

-- Write a query to list the top three cities that have the most completed trade orders in descending order.
-- Output the city and number of orders.
SELECT City AS Cities, COUNT(Status) AS Total_orders
FROM (SELECT * 
    FROM trades as t
    JOIN users as u
    USING (user_id)
    WHERE t.status = 'Completed') as Completed_order_count
GROUP BY Cities
ORDER BY Total_orders DESC
LIMIT 3;


-- Unfinished Parts
-- Write a SQL query that determines which parts have begun the assembly process but are not yet finished.
SELECT DISTINCT(part)
FROM parts_assembly
WHERE finish_date is NULL;

-- Page With No Likes
-- Write a query to return the page IDs of all the Facebook pages that don't have any likes. The output should be in ascending order.

SELECT page_id
FROM pages as p
LEFT JOIN page_likes as PL
USING (page_id)
WHERE liked_date IS NULL
ORDER BY page_id;


-- Laptop vs Mobile Viewership
-- Define “mobile” as the sum of tablet and phone viewership numbers. Write a query to compare the viewership on laptops versus mobile devices.

SELECT SUM(CASE WHEN device_type = 'laptop' THEN 1 
                WHEN device_type = 'tablet' THEN 1
                ELSE 0 END) as laptop_views,
        SUM(CASE WHEN device_type = 'phone' THEN 1 
                ELSE 0 END) as mobile_views
FROM viewership;


-- Highest Number of Products
-- Write a query to obtain the user IDs and number of products purchased by the top 3 customers; these customers must have spent at least $1,000 in total.
-- Output the user id and number of products in descending order. To break ties (i.e., if 2 customers both bought 10 products), the user who spent more should take precedence.

SELECT user_id, COUNT(product_id) as Product_Num
FROM user_transactions
GROUP BY user_id
HAVING SUM(SPEND) >= 1000
ORDER BY 2 DESC, sum(spend) DESC
LIMIT 3;

-- Purchasing Activity by Product Type
-- Write a query to calculate the cumulative purchases for each product type over time in chronological order.
-- Output the order date, product, and the cumulative number of quantities purchased (conveniently abbreviated as cum_purchased).
SELECT 
  order_date,
  product_type,
  SUM(quantity) OVER (
    PARTITION BY product_type 
    ORDER BY order_date) AS cum_purchased
FROM total_trans
ORDER BY order_date;


-- Teams Power Users
-- Write a query to find the top 2 power users who sent the most messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. 
-- Output the results in descending count of the messages.

SELECT sender_id, COUNT(content) as Message_Count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8' AND
      EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY 2 DESC
LIMIT 2;

-- LinkedIn Power Creators (Part 1)
-- The LinkedIn Creator team is looking for power creators who use their personal profile as a company or influencer page. If someone's LinkedIn page 
-- has more followers than the company they work for, we can safely assume that person is a power creator.
-- Write a query to return the IDs of these LinkedIn power creators ordered by the IDs.
-- Assumption: Each person with a LinkedIn profile in this database works at one company only.

SELECT profile_id
FROM personal_profiles as pp
JOIN company_pages as cp
ON cp.company_id = pp.employer_id
WHERE pp.followers > cp.followers
ORDER BY pp.profile_id;

-- Duplicate Job Listings
-- Write a query to get the number of companies that have posted duplicate job listings (two jobs at the same company with the same title and description).

SELECT COUNT(DISTINCT(Company_id)) as Duplicate_Companies
FROM (SELECT j1.Company_id, j1.title, j1.description
      FROM job_listings j1
      JOIN job_listings j2
      on j1.job_id <> j2.job_id and j1.title = j2.title and j1.company_id = j2.company_id and j1.description = j2.description) as duplicates;

SELECT 
  company_id, 
  title, 
  description, 
  COUNT(job_id) AS job_count
FROM job_listings
GROUP BY 
  company_id, 
  title, 
  description;


-- Repeat Purchases on Multiple Days
-- Write a query to obtain the number of users who purchased the same product on two or more different days. Output the number of unique users.

WITH Repeat_CTE AS (SELECT user_id, product_id, purchase_date, 
    RANK() OVER(PARTITION BY USER_ID, product_id ORDER BY DATE (purchase_date)) AS repeat_purchase
FROM purchases
GROUP BY user_id, purchase_date, product_id)
SELECT COUNT(User_id)
FROM Repeat_CTE 
WHERE Repeat_CTE.repeat_purchase = 2;


-- User's Third Transaction
-- Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

SELECT user_id, spend, transaction_date
FROM(SELECT user_id, spend, transaction_date, 
row_number() OVER(PARTITION BY user_id ORDER BY transaction_date) AS Times
FROM transactions) as transaction
WHERE transaction.times = 3;


-- Photoshop Revenue Analysis
-- For every customer that bought Photoshop, return a list of their customer_id, 
-- and how much they spent in total for other Adobe products excluding Photoshop.
-- Sort your answer by customer_id in ascending order.


SELECT customer_id, SUM(revenue)
FROM adobe_transactions
WHERE customer_id IN (SELECT customer_id
FROM adobe_transactions
WHERE product = 'Photoshop') AND product <> 'Photoshop'
GROUP BY customer_id
ORDER BY customer_id;

-- Histogram of Tweets
-- Write a query to obtain a histogram of tweets posted per user in 2022. 
-- Output the tweet count per user as the bucket, and then the number of Twitter users who fall into that bucket.

SELECT tweet_bucket, COUNT(user_id) as users_num
FROM(SELECT COUNT(tweet_id) as tweet_bucket, user_id
FROM tweets
WHERE tweet_date BETWEEN '01/01/2022 00:00:00' AND '12/31/2022 00:00:00'
GROUP BY user_id) as x
GROUP BY x.tweet_bucket;


-- Average Review Ratings
-- write a query to get the average stars for each product every month.
-- The output should include the month in numerical value, product id, and average star rating rounded to two decimal places. 
-- Sort the output based on month followed by the product id.
SELECT EXTRACT(month from submit_date) as Mth, product_id, ROUND(AVG(stars), 2) as avg_stars
FROM reviews
GROUP BY 1, 2
ORDER BY 1, 2;

SELECT EXTRACT(month from submit_date) as Mth, product_id, ROUND(AVG(stars), 2) as avg_stars
FROM(SELECT submit_date, product_id, stars
FROM reviews) as extracted
GROUP BY 1, 2
ORDER BY 1, 2;

-- Unfinished Parts
-- Write a SQL query that determines which parts have begun the assembly process but are not yet finished.

SELECT DISTINCT(part)
FROM parts_assembly
WHERE finish_date is NULL;


-- Data Science Skills
-- You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
-- Write a SQL query to list the candidates who possess all of the required skills for the job. 
-- Sort the the output by candidate ID in ascending order.
SELECT candidate_id
FROM(SELECT candidate_id, COUNT(skill) AS skills
  FROM candidates
  WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
  GROUP BY candidate_id) as x
WHERE x.skills = 3;


-- Final Account Balance
-- Given a table of bank deposits and withdrawals, return the final balance for each account.

SELECT account_id,
SUM(case when transaction_type = 'Deposit' then amount else -amount end)as final_balance
FROM transactions
GROUP BY account_id;


-- Ad Campaign ROAS
-- Write a query to calculate the return on ad spend (ROAS) for each advertiser across all ad campaigns. 
-- Round your answer to 2 decimal places, and order your output by the advertiser_id
SELECT advertiser_id, ROUND((sum(revenue)/sum(spend), 2) as ROAS
FROM ad_campaigns
GROUP BY advertiser_id
ORDER BY advertiser_id;

-- Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times. From now on, we'll refer to this ranking number as "song appearances".
-- Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence.
-- Assumptions: If two artists' songs have the same number of appearances, the artists should have the same rank.
-- The rank number should be continuous (1, 2, 2, 3, 4, 5) and not skipped (1, 2, 2, 4, 5).

SELECT artist_name, Artist_Rank
FROM(SELECT artist_id, song_count, 
  dense_rank() over(ORDER BY song_count Desc) as Artist_Rank
  FROM(SELECT artist_id, COUNT(song_id) as song_count
  FROM songs 
  JOIN global_song_rank as gsr
  USING (song_id)
  WHERE gsr.rank <= 10
  GROUP BY artist_id) as ranking) as Ranks
JOIN artists
USING (artist_id)
WHERE Artist_Rank <= 5
ORDER BY Artist_Rank, artist_name;

-- Given a table of Facebook posts, for each user who posted at least twice in 2021, 
-- write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. 
-- Output the user and number of the days between each user's first and last post.

WITH CTE AS (SELECT user_id, date_part('day', MAX(post_date)-MIN(post_date)) as days_between
      FROM posts
      WHERE date_part('year', post_date) = 2021
      GROUP BY user_id)
SELECT user_id, days_between
FROM CTE 
WHERE days_between <> 0;


WITH CTE AS (SELECT user_id, EXTRACT(DAY FROM MAX(post_date)-MIN(post_date)) as days_between
            FROM posts
            WHERE date_part('year', post_date) = 2021
            GROUP BY user_id)
SELECT user_id, days_between
FROM CTE
WHERE days_between <> 0;

-- New TikTok users sign up with their emails and each user receives a text confirmation to activate their account. 
-- Assume you are given the below tables about emails and texts.
-- Write a query to display the ids of the users who did not confirm on the first day of sign-up, but confirmed on the second day.
-- Assumption:
-- action_date is the date when the user activated their account and confirmed their sign-up through the text.

WITH CTE AS (SELECT user_id, signup_action, action_date, signup_date, date_part('day', action_date -signup_date) AS difference
    FROM emails
    JOIN texts
    USING (email_id)
    WHERE signup_action = 'Confirmed')
    
SELECT user_id
FROM CTE 
WHERE difference = 1;

-- Your team at JPMorgan Chase is soon launching a new credit card, and to gain some context, 
-- you are analyzing how many credit cards were issued each month.
-- Write a query that outputs the name of each credit card and the difference in issued amount between the month with the most cards issued, 
-- and the least cards issued. Order the results according to the biggest difference.

WITH CTE AS (SELECT card_name, issued_amount, 
    lead(issued_amount) over(partition by card_name order by issue_year, issue_month) AS next_amount, 
    issue_month, issue_year
    FROM monthly_cards_issued),
    
    issue_difference AS (SELECT card_name, issued_amount, next_amount, next_amount - issued_amount AS difference
              FROM CTE 
              WHERE next_amount IS NOT NULL)
              
SELECT card_name, SUM(difference) as difference
FROM issue_difference
GROUP BY card_name
ORDER BY difference DESC;

-- CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. 
-- Each drug can only be produced by one manufacturer.
-- Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. 
-- Display the result from the highest to the lowest total profit.
SELECT drug, total_sales - cogs AS total_profit
FROM pharmacy_sales
ORDER BY total_profit DESC
LIMIT 3;

-- CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. 
-- Each drug can only be produced by one manufacturer.
-- Write a query to find out which manufacturer is associated with the drugs that were not profitable and how much money CVS lost on these drugs. 
-- Output the manufacturer, number of drugs and total losses. Total losses should be in absolute value. 
-- Display the results with the highest losses on top.
 SELECT manufacturer, count(drug) AS drug_count, ABS(SUM(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE (total_sales - cogs) <= 0
GROUP BY 1
ORDER BY total_loss DESC;

-- Write a query to find the total sales of drugs for each manufacturer. 
-- Round your answer to the closest million, and report your results in descending order of total sales.
-- Because this data is being directly fed into a dashboard which is being seen by business stakeholders, format your result like this: "$36 million".
SELECT manufacturer, CONCAT('$',ROUND(SUM(total_sales)/1000000),' ','million')as sales_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC;


-- Write a query to find how many UHG members made 3 or more calls. case_id column uniquely identifies each call made
WITH CTE AS (SELECT policy_holder_id, COUNT(*)
        FROM callers
        GROUP BY policy_holder_id
        HAVING COUNT(*) >= 3)
        
SELECT COUNT(*) AS member_count
FROM CTE;


-- Calls to the Advocate4Me call centre are categorised, but sometimes they can't fit neatly into a category. 
-- These uncategorised calls are labelled “n/a”, or are just empty (when a support agent enters nothing into the category field).
-- Write a query to find the percentage of calls that cannot be categorised. Round your answer to 1 decimal place.

SELECT 
  ROUND(100.0 * 
    COUNT(case_id)/
      (SELECT COUNT(*) FROM callers),1) AS uncategorised_call_pct
FROM callers
WHERE call_category IS NULL 
  OR call_category = 'n/a';


WITH uncategorised_calls AS (
  SELECT COUNT(case_id) AS call_count
  FROM callers
  WHERE call_category IS NULL
    OR call_category = 'n/a'
)

SELECT 
  ROUND(100.0 * call_count 
    / (SELECT COUNT(*) FROM callers), 1) AS uncategorised_call_pct
FROM uncategorised_calls
GROUP BY call_count;

-- Assume you have an events table on app analytics. Write a query to get the app’s click-through rate (CTR %) in 2022. 
-- Output the results in percentages rounded to 2 decimal places.
-- Notes:
-- Percentage of click-through rate = 100.0 * Number of clicks / Number of impressions
SELECT  app_id, ROUND(100.0*SUM(case when event_type = 'click' THEN 1 ELSE 0 END)/
        SUM(case when event_type = 'impression' THEN 1 ELSE 0 END), 2) as ctr_rate
        FROM events
        WHERE date_part('year', timestamp) = 2022
        GROUP BY app_id;
        
-- You are given a list of numbers representing how many emails each Microsoft Outlook user has in their inbox. 
-- Before the Product Management team can work on features related to inbox zero or bulk-deleting email, they simply want to know what the mean, median, and mode are for the number of emails.
-- Output the median, median and mode (in this order). Round the mean to the the closest integer and assume that there are no ties for mode.
SELECT 
  ROUND(AVG(email_count)) as mean,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY email_count) AS median,
  MODE() WITHIN GROUP (ORDER BY email_count) AS mode
 FROM inbox_stats;
 
 
 WITH CTE AS(SELECT email_count, row_number() OVER(ORDER BY email_count) AS rn
        FROM inbox_stats)

SELECT ROUND(AVG(email_count)) AS mean, (SELECT AVG(email_count) FROM CTE  WHERE Rn IN (7, 8)) AS median, 
(SELECT email_count, COUNT(*) FROM CTE GROUP BY email_count ORDER BY 2 DESC LIMIT 1) as mode
FROM CTE;

-- Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. 
-- The launch month is the earliest record in the monthly_cards_issued table for a given card. 
-- Order the results starting from the biggest issued amount.
WITH CTE AS (SELECT card_name, issued_amount,issue_month, issue_year, 
        row_number() over(PARTITION BY card_name ORDER BY issue_year, issue_month) AS RN
        FROM monthly_cards_issued)
SELECT card_name, issued_amount
FROM CTE 
WHERE RN = 1
ORDER BY issued_amount DESC;

-- Assume you are given the tables below containing information on Snapchat users, their ages, and their time spent sending and opening snaps. 
-- Write a query to obtain a breakdown of the time spent sending vs. opening snaps (as a percentage of total time spent on these activities) for each age group.
-- Output the age bucket and percentage of sending and opening snaps. Round the percentage to 2 decimal places.
-- Notes:
-- You should calculate these percentages:
-- time sending / (time sending + time opening)
-- time opening / (time sending + time opening)
-- To avoid integer division in percentages, multiply by 100.0 and not 100

WITH CTE AS (SELECT age_bucket, activity_type, time_spent 
      FROM activities
      JOIN age_breakdown
      USING (user_id)
      WHERE activity_type <> 'chat'),
      
    total_time AS (SELECT age_bucket, SUM(CASE WHEN activity_type='send' THEN time_spent ELSE 0 END) AS send_perc, 
             SUM(CASE WHEN activity_type='open' THEN  time_spent ELSE 0 END) AS open_perc, 
             SUM(time_spent) AS total_time_spent
      FROM CTE
      GROUP BY age_bucket)

SELECT age_bucket, ROUND(send_perc/total_time_spent*100.0, 2) AS send_perc,
    ROUND(open_perc/total_time_spent*100.0, 2) AS open_perc
FROM total_time;

-- Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two different columns. 
-- Refer to the Example Output below for the output format.
-- Definition:
-- 1st, 3rd, and 5th measurements taken within a day are considered odd-numbered measurements and the 2nd, 4th, and 6th measurements are even-numbered measurements.
WITH CTE AS (SELECT  measurement_time, date_trunc('day', measurement_time) AS measurement_day, measurement_value, 
      row_number() OVER(PARTITION BY date_trunc('day', measurement_time) ORDER BY measurement_time) AS measurement_num
      FROM measurements)

SELECT measurement_day, SUM(CASE WHEN measurement_num%2 != 0 THEN measurement_value ELSE 0 END) as odd_sum,
      SUM(CASE WHEN measurement_num%2 = 0 THEN measurement_value ELSE 0 END) as even_sum
FROM CTE
GROUP BY measurement_day;

WITH CTE AS (SELECT  measurement_time, date_trunc('day', measurement_time) AS measurement_day, measurement_value, 
      row_number() OVER(PARTITION BY date_trunc('day', measurement_time) ORDER BY measurement_time) AS measurement_num
      FROM measurements)

SELECT measurement_day, SUM(CASE WHEN measurement_num%2 = 1  THEN measurement_value ELSE 0 END) as odd_sum,
      SUM(CASE WHEN measurement_num%2 = 0 THEN measurement_value ELSE 0 END) as even_sum
FROM CTE
GROUP BY measurement_day;



        
