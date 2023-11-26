SELECT *
FROM Foodie_Fi.Subscriptions
JOIN Foodie_Fi.Plans
USING (plan_id)
ORDER BY customer_id;


-- customers next subscription
SELECT *, lead(plan_name) over(PARTITION BY customer_id ORDER BY customer_id) as next_subscription
FROM Foodie_Fi.Subscriptions
JOIN Foodie_Fi.Plans
USING (plan_id);

-- customers 2 next subscription
SELECT *, lead(plan_name, 2) over(PARTITION BY customer_id ORDER BY customer_id) as next_subscription
FROM Foodie_Fi.Subscriptions
JOIN Foodie_Fi.Plans
USING (plan_id);

-- customers previous subscription
SELECT *, lag(plan_name) over(PARTITION BY customer_id ORDER BY customer_id) as previous_subscription
FROM Foodie_Fi.Subscriptions
JOIN Foodie_Fi.Plans
USING (plan_id);

-- customers 2 previous subscriptions
SELECT *, lag(plan_name, 2) over(PARTITION BY customer_id ORDER BY customer_id) as previous_subscription
FROM Foodie_Fi.Subscriptions
JOIN Foodie_Fi.Plans
USING (plan_id);

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

-- making independent comments in each row
SELECT platform, SUM(transactions) as total_transaction, 'yes' as comment 
FROM `Data _Mart`.NEW_Data
GROUP BY platform;

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%S';

SELECT id, account_id, occurred_at
FROM orders;

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd 
LIMIT 20;

SELECT id, account_id, total_amt_usd
FROM Orders
ORDER BY account_id, total_amt_usd DESC;

SELECT id, account_id, total_amt_usd
FROM Orders
ORDER BY total_amt_usd DESC, account_id;

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

SELECT id, account_id, poster_amt_usd/(poster_amt_usd + gloss_amt_usd + standard_amt_usd) * 100 as poster_percentage
FROM orders
LIMIT 10;

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

SELECT *
FROM accounts
WHERE name LIKE 'C%';

SELECT *
FROM accounts
WHERE name LIKE '%one%';

SELECT *
FROM accounts
WHERE name LIKE '%s';

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT LIKE ('C%');

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT LIKE ('%one%');

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT LIKE ('%s');

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%S';

SELECT *
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01';

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%S';

SELECT *
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29; 

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%');

SELECT *
FROM Orders as O
JOIN Accounts as A
ON O.account_id = A.id;

SELECT standard_qty, gloss_qty, poster_qty, website, primary_poc
FROM Orders as O
JOIN Accounts as A
ON O.account_id = A.id;

SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id;

SELECT a.name, a.primary_poc, we.occurred_at, we.channel
FROM web_events as we
JOIN accounts as a
on we.account_id = a.id
WHERE a.name = 'Walmart';

SELECT sr.name, r.name, a.name
FROM accounts as a
JOIN sales_reps as sr
ON a.sales_rep_id = sr.id
JOIN region as r
on sr.region_id = r.id
ORDER BY a.name;


SELECT r.name as region, a.name as account_name, o.total_amt_usd/(o.total + 0.01) as unit_price
FROM region as r 
JOIN sales_reps as s
ON s.region_id = r.id
JOIN accounts as a
ON a.sales_rep_id = s.id
JOIN orders as o
ON o.account_id = a.id;

SELECT r.name as region, sr.name as rep, a.name as account_name
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id AND r.name = 'Midwest'
JOIN accounts as a
ON a.sales_rep_id = sr.id
ORDER BY a.name;

SELECT r.name as region, sr.name as rep, a.name as account_name
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id AND sr.name LIKE '% K%' AND r.name = 'Midwest'
JOIN accounts as a
ON a.sales_rep_id = sr.id
ORDER BY a.name;

SELECT r.name as region, sr.name as rep, a.name as account_name
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id
JOIN accounts as a
ON a.sales_rep_id = sr.id
WHERE sr.name LIKE '% K%' AND r.name = 'Midwest'                                 
ORDER BY a.name;

SELECT r.name as region, sr.name as rep, a.name as account_name
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id AND sr.name LIKE 'S%' AND r.name = 'Midwest'
JOIN accounts as a
ON a.sales_rep_id = sr.id
ORDER BY a.name;

SELECT r.name as region, a.name as account_name , (total_amt_usd/total + 0.01) as unit_price
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id 
JOIN accounts as a
ON a.sales_rep_id = sr.id
JOIN orders as o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

SELECT r.name as region, a.name as account_name , (total_amt_usd/total + 0.01) as unit_price
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id 
JOIN accounts as a
ON a.sales_rep_id = sr.id
JOIN orders as o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50;

SELECT distinct(a.name) as account_name, we.channel as channel
FROM web_events AS we 
JOIN accounts as a
ON we.account_id = a.id
WHERE a.id = 1001;

SELECT r.name as region, a.name as account_name , (total_amt_usd/total + 0.01) as unit_price
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id 
JOIN accounts as a
ON a.sales_rep_id = sr.id
JOIN orders as o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

SELECT r.name as region, a.name as account_name , (total_amt_usd/total + 0.01) as unit_price
FROM sales_reps AS sr
JOIN region AS r
ON sr.region_id = r.id 
JOIN accounts as a
ON a.sales_rep_id = sr.id
JOIN orders as o
ON o.account_id = a.id
WHERE o.standard_qty > 100
ORDER BY unit_price DESC;

SELECT SUM(poster_qty)
FROM orders;

SELECT SUM(standard_qty)
FROM orders;

SELECT SUM(total_amt_usd)
FROM orders;

SELECT standard_amt_usd + gloss_amt_usd as Total
FROM orders;

SELECT SUM(standard_qty)/SUM(standard_amt_usd) as per_unit_price
FROM orders;

-- If you want to average and include null values the sum and divide by count

-- median
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- earliest order date
SELECT min(occurred_at)
FROM orders;

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT a.name as account_name, MIN(o.occurred_at) AS earliest_order
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name,  o.occurred_at
ORDER BY o.occurred_at
LIMIT 1;

-- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

-- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

-- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
-- Your query should return only three values - the date, channel, and account name.
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id 
ORDER BY w.occurred_at DESC
LIMIT 1;

-- Find the total number of times each type of channel from the web_events was used. 
-- Your final table should have two columns - the channel and the number of times the channel was used.
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel;

-- Who was the primary contact associated with the earliest web_event?
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

-- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. 
-- Order from smallest dollar amounts to largest.
SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

-- Sort of strange we have a bunch of orders with no dollars. We might want to look into those.

-- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;

SELECT a.name as account_name, avg(standard_qty) as standard, avg(gloss_qty) as gloss, avg(poster_qty) as poster
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name;

SELECT a.name as account_name, avg(standard_amt_usd) as standard_amount_avg, avg(gloss_amt_usd) as gloss_amount_avg, avg(poster_amt_usd) as poster_amount_avg
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name;

SELECT sr.name as reps_name, channel, count(channel)
FROM web_events as we
JOIN accounts as a
ON we.account_id = a.id
JOIN sales_reps as sr
ON sr.id = a.sales_rep_id
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT a.id as accounts, a.name, r.name as region, COUNT(DISTINCT r.name)
FROM accounts as a 
JOIN sales_reps as sr
ON a.sales_rep_id = sr.id
JOIN region as r
ON sr.region_id = r.id
GROUP BY 1, 2, 3
ORDER BY 1;

SELECT reps.name as Rep_name, SUM(Reps.rep_count)
FROM(SELECT s.id AS ID, s.name AS Name, a.id AS account_id, a.name as account_name, count(distinct s.id) AS Rep_count
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name, a.id, a.name) as Reps
GROUP BY 1
ORDER BY 2 DESC;

SELECT sr.name as Reps_name, count(*)
FROM accounts as a
JOIN sales_reps as sr
ON a.sales_rep_id = sr.id
GROUP BY 1
ORDER BY 2 DESC;

SELECT a.id as account_id, a.name as account_name, count(*)
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id 
GROUP BY 1, 2
HAVING COUNT(*) > 20
ORDER BY 3 DESC;

SELECT sr.name as Reps_name, count(*)
FROM accounts as a
JOIN sales_reps as sr
ON a.sales_rep_id = sr.id
GROUP BY 1
HAVING count(*) > 5
ORDER BY 2 DESC;

SELECT a.id as account_id, a.name as account_name, o.total_amt_usd as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id 
GROUP BY 1, 2, 3
HAVING o.total_amt_usd > 30000
ORDER BY 3 DESC;

SELECT a.id as account_id, a.name as account_name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id 
GROUP BY 1, 2, o.total_amt_usd
HAVING o.total_amt_usd > 30000
ORDER BY 3 DESC;

SELECT COUNT(*)
FROM(SELECT sr.name as Reps_name, count(*)
FROM accounts as a
JOIN sales_reps as sr
ON a.sales_rep_id = sr.id
GROUP BY 1
HAVING count(*) > 5
ORDER BY 2 DESC) AS Rep;

SELECT a.id as account_id, a.name as account_name, o.total_amt_usd as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id 
GROUP BY 1, 2, 3
HAVING o.total_amt_usd < 1000
ORDER BY 3 DESC;

SELECT a.id as account_id, a.name as account_name, o.total_amt_usd as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id 
ORDER BY 3 DESC
LIMIT 1;

SELECT a.id as account_id, a.name as account_name, o.total_amt_usd as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id 
ORDER BY 3
LIMIT 1;

-- Multiple accounts have spent 0.00 so 
SELECT a.id as account_id, a.name as account_name, o.total_amt_usd as total_spent
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id 
WHERE o.total_amt_usd = 0.00
ORDER BY 3;

SELECT a.name as account, channel, count(*)
FROM accounts as a
JOIN web_events as we
ON a.id = we.account_id AND Channel = 'facebook'
GROUP BY 1, 2
HAVING COUNT(*) > 6
ORDER BY 3 DESC;

SELECT we.channel, count(*)
FROM accounts as a
JOIN web_events as we
ON a.id = we.account_id
GROUP BY we.channel
ORDER BY 2 DESC
LIMIT 1;

SELECT a.name as account_name, we.channel, count(*)
FROM accounts as a
JOIN web_events as we
ON a.id = we.account_id
GROUP BY a.name, we.channel
ORDER BY 3 DESC;

SELECT date_part('year', occurred_at) as year, SUM(total_amt_usd) AS total_yearly_revenue
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT date_part('month', occurred_at) as month, SUM(total_amt_usd) AS total_yearly_revenue
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

SELECT date_part('year', occurred_at) as year, count(*) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT date_part('month', occurred_at) as month, count(*) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT a.name as account_name , date_trunc('month', o.occurred_at) as Month, SUM(o.total_amt_usd) AS total_orders
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id AND a.name = 'Walmart'
GROUP BY 1, 2
ORDER BY 3 DESC;

-- adding and deducting to date by days and time
SELECT a.name as account_name , date_add(o.occurred_at, interval 10 day) as  add_10days,
date_add(o.occurred_at, interval 10 minute) as  add_10mins, 
date_add(o.occurred_at, interval -5 day) as  minus_5days
FROM orders as o;

SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;

-- Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or
--  ’Small’ - depending on if the order is $3000 or more, or less than $3000.
SELECT account_id, total_amt_usd,
		CASE WHEN total_amt_usd > 3000 THEN 'Large'
		ELSE 'Small' END AS order_level
FROM orders;

-- Write a query to display the number of orders in each of three categories, based on the total number of items in each order. 
-- The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.

SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
   WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
   ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;

-- We would like to understand 3 different branches of customers based on the amount associated with their purchases. 
-- The top branch includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
-- The second branch is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 usd. 
-- Provide a table that includes the level associated with each account. You should provide the account name, 
-- the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.

SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC;

-- We would now like to perform a similar calculation to the first, but we want to obtain 
-- the total amount spent by customers only in 2016 and 2017. 
-- Keep the same levels as in the previous question. Order with the top spending customers listed first.
SELECT a.name as customer, SUM(o.total_amt_usd) as total_spend, 
	CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'Top Level' 
	WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'Mid-level' 
    ELSE 'Low Level' 
    END as Customer_Levels
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2016-01-01'AND '2018-01-01'
GROUP BY o.account_id, a.name
ORDER BY 3 DESC;

SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31' 
GROUP BY 1
ORDER BY 2 DESC;

-- We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. 
-- Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. 
-- Place the top sales people first in your final table.
SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;

-- It is worth mentioning that this assumes each name is unique - which has been done a few times. 
-- We otherwise would want to break by the name and the id of the table.

-- The previous didn't account for the middle, nor the dollar amount associated with the sales.
--  Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, 
-- which are sales reps associated with more than 200 orders or more than 750000 in total sales. 
-- The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, 
-- total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table.
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;

SELECT DC.channel, avg(DC.counts)
FROM(SELECT DATE_TRUNC('Day', occurred_at) as day, channel, Count(*) as counts
FROM web_events
GROUP BY 1, 2
ORDER BY 3 DESC) as DC
GROUP BY 1
ORDER BY 2 DESC;

SELECT *
FROM orders 
WHERE DATE_TRUNC('Month', occurred_at) = (SELECT DATE_TRUNC('Month', MIN(occurred_at))
	FROM orders);
    
SELECT avg(poster_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM(SELECT *
	FROM orders 
	WHERE DATE_TRUNC('Month', occurred_at) = (SELECT DATE_TRUNC('Month', MIN(occurred_at))
	FROM orders)) as first_orders;

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

SELECT spend.region, MAX(spend.client_spend)
FROM(SELECT sr.name, r.name as region, SUM(total_amt_usd) as client_spend
	FROM accounts as a
	JOIN orders as o
	ON a.id = o.account_id
	JOIN sales_reps as sr
	ON a.sales_rep_id = sr.id
	JOIN region as r
	ON r.id = sr.region_id
	GROUP BY sr.name, r.name) as spend
GROUP BY 1
ORDER BY 2 DESC;

SELECT reg as Region, sr as Sales_Rep, Max 
FROM(SELECT tab1.region as reg, MAX(tab1.client_spend) as 	max
	FROM(SELECT sr.name as sr, r.name as region, SUM(total_amt_usd) as client_spend
	FROM accounts as a
	JOIN orders as o
	ON a.id = o.account_id
	JOIN sales_reps as sr
	ON a.sales_rep_id = sr.id
	JOIN region as r
	ON r.id = sr.region_id
	GROUP BY sr.name, r.name) as tab1
	GROUP BY 1)tab2
JOIN(SELECT sr.name as sr, r.name as region, SUM(total_amt_usd) as client_spend
	FROM accounts as a
	JOIN orders as o
	ON a.id = o.account_id
	JOIN sales_reps as sr
	ON a.sales_rep_id = sr.id
	JOIN region as r
	ON r.id = sr.region_id
	GROUP BY sr.name, r.name) as tab3
ON tab2.max = tab3.client_spend AND tab2.reg = tab3.region
ORDER BY 3 DESC;

SELECT r.name as region, SUM(o.total_amt_usd), COUNT(*)
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
JOIN sales_reps as sr
ON a.sales_rep_id = sr.id
JOIN region as r
ON r.id = sr.region_id
GROUP BY r.name
ORDER BY 1, 2;

SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
      SELECT MAX(total_amt)
      FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
              FROM sales_reps s
              JOIN accounts a
              ON a.sales_rep_id = s.id
              JOIN orders o
              ON o.account_id = a.id
              JOIN region r
              ON r.id = s.region_id
              GROUP BY r.name) sub);

WITH table1 AS (
          SELECT *
          FROM web_events),

     table2 AS (
          SELECT *
          FROM accounts)


SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;


-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY 1,2
   ORDER BY 3 DESC), 
t2 AS (
   SELECT region_name, MAX(total_amt) total_amt
   FROM t1
   GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

-- For the region with the largest sales total_amt_usd, how many total orders were placed?

WITH t1 AS (
   SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY r.name), 
t2 AS (
   SELECT MAX(total_amt)
   FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

-- For the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?

WITH t1 AS (
		  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
		  FROM accounts a
		  JOIN orders o
		  ON o.account_id = a.id
		  GROUP BY 1
		  ORDER BY 2 DESC
		  LIMIT 1), 
t2 AS (
	  SELECT a.name
	  FROM orders o
	  JOIN accounts a
	  ON a.id = o.account_id
	  GROUP BY 1
	  HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;

-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?

WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;

-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 10)
SELECT AVG(tot_spent)
FROM t1;

-- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.

WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),
t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt)
FROM t2;

-- splitting texts 
SELECT LEFT(name, 4), RIGHT(website, 4), COUNT(RIGHT(website, 4))
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

SELECT LEFT(UPPER(name), 1) as first_letter, COUNT(LEFT(name, 1)) as letter_counts
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

SELECT SUM(CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 1 ELSE 0 END) as number_counts, 
SUM(CASE WHEN LEFT(UPPER(name), 1) NOT IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN 1 ELSE 0 END) as letter_counts
FROM accounts;

SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 1 ELSE 0 END AS num, 
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;
      
SELECT SUM(CASE WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 1 ELSE 0 END) as vowel_counts, 
SUM(CASE WHEN LEFT(UPPER(name), 1) NOT IN ('A', 'E', 'I', 'O', 'U') THEN 1 ELSE 0 END) as consonant_counts
FROM accounts;

-- Finding the position of symbols, words in columns
SELECT primary_poc, POSITION(' ' IN primary_poc)
FROM accounts;

SELECT primary_poc, STRPOS( primary_poc, ' ')
FROM accounts;

-- find the length of words in column
SELECT primary_poc, LENGTH(primary_poc)
FROM accounts;

-- convert a string date column to date format, use this '%d/%m/%Y' to identify which position is day month or year as written in the column 
SELECT *, str_to_date(week_date, '%d/%m/%Y') AS formatted_date
FROM `Data _Mart`.Data;

-- pulling out word using position, creating first and last name with one column
SELECT primary_poc, LEFT(primary_poc, POSITION(' ' IN primary_poc)) as first_name, 
RIGHT(primary_poc, LENGTH(Primary_poc) - STRPOS( primary_poc, ' ')) as last_name, 
POSITION(' ' IN primary_poc)
FROM accounts;

SELECT name, LEFT(Name, POSITION(' ' IN Name)) as first_name, 
RIGHT(Name, LENGTH(Name) - POSITION(' ' IN Name)) as last_name, 
POSITION(' ' IN Name)
FROM sales_reps;

-- merging names and creating email address
SELECT name, primary_poc, CONCAT(primary_poc, '@', name, '.com') as poc_email_address, 
primary_poc || '@' || name || '.com' as alt_poc_email
FROM accounts;

-- creating first and last name then creating email address
WITH t1 AS (
 SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;

WITH t1 AS (
 SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ', ''), '.com')
FROM  t1;

WITH t1 AS (
 SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;

-- splitting wrong date format then join the split and casting it as date in a new column
SELECT x.year || '-'|| x.month || '-' || x.day as new_date, 
CAST(x.year || '-'|| x.month || '-' || x.day AS Date) as cast_date, 
(x.year || '-'|| x.month || '-' || x.day)::date as new
FROM (SELECT date, substr(date, 7, 4) as year, substr(date, 4, 2) as day, substr(date, 1, 2) as month
FROM sf_crime_data) as x;

SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, 
a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, 
COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, 
COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT occurred_at, standard_amt_usd, SUM(standard_amt_usd) OVER(ORDER BY occurred_at) as cum_sum, 
SUM(standard_amt_usd) OVER(PARTITION BY occurred_at ORDER BY standard_amt_usd) as partitioned
FROM orders;

SELECT standard_amt_usd, date_trunc('year', occurred_at), SUM(standard_amt_usd) OVER(PARTITION BY date_trunc('year', occurred_at) ORDER BY occurred_at) as running_total
FROM orders;

SELECT id, account_id, total, RANK() OVER(ORDER BY total DESC)
FROM orders;

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders;

-- Creating alias for partition portion
SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at));

-- lead and lag
SELECT account_id,
       standard_sum,
       LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_data,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead_data,
       standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_difference
FROM (
		SELECT account_id, SUM(standard_qty) AS standard_sum
		FROM orders 
		GROUP BY 1) sub;

SELECT occurred_at, total_sum,
LEAD(total_sum) OVER (ORDER BY occurred_at) AS lead_data, LEAD(total_sum) OVER (ORDER BY occurred_at) - total_sum AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_sum
  FROM orders 
 GROUP BY 1
 ) sub;
 
 SELECT account_id, occurred_at, standard_qty,
NTILE(4) OVER(PARTITION BY account_id ORDER BY standard_qty)
FROM orders;

SELECT account_id, occurred_at, gloss_qty,
NTILE(2) OVER(PARTITION BY account_id ORDER BY gloss_qty)
FROM orders;

SELECT account_id, occurred_at, total_amt_usd,
NTILE(100) OVER(PARTITION BY account_id ORDER BY total_amt_usd)
FROM orders;


SELECT column_name(s)
FROM Table_A
FULL JOIN Table_B ON Table_A.column_name = Table_B.column_name
WHERE Table_A.column_name IS NULL OR Table_B.column_name IS NULL;

SELECT *
FROM sales_reps as s
FULL JOIN accounts as a
ON s.id = a.sales_rep_id
WHERE a.sales_rep_id IS NULL OR s.id IS NULL;


-- Joining tables and then rating strings alphabetically
SELECT accounts.name as account_name,
       accounts.primary_poc as poc_name,
       sales_reps.name as sales_rep_name
  FROM accounts
  LEFT JOIN sales_reps
    ON accounts.sales_rep_id = sales_reps.id
   AND accounts.primary_poc < sales_reps.name;
   

-- Self JOIN is optimal when you want to 
-- show both parent and child relationships within a family tree.
SELECT o1.id AS o1_id,
       o1.account_id AS o1_account_id,
       o1.occurred_at AS o1_occurred_at,
       o2.id AS o2_id,
       o2.account_id AS o2_account_id,
       o2.occurred_at AS o2_occurred_at
  FROM orders o1
 LEFT JOIN orders o2
   ON o1.account_id = o2.account_id
  AND o2.occurred_at > o1.occurred_at
  AND o2.occurred_at <= o1.occurred_at + INTERVAL '28 days'
ORDER BY o1.account_id, o1.occurred_at;

SELECT we1.id AS we_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel,
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at,
       we2.channel AS we2_channel
  FROM web_events we1 
 LEFT JOIN web_events we2
   ON we1.account_id = we2.account_id
  AND we1.occurred_at > we2.occurred_at
  AND we1.occurred_at <= we2.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id, we2.occurred_at;

 -- The table with the students information needs to be appended with the late reasons. It requires no aggregation or filter, but all duplicates need to be removed. 
 -- So the final use case is the one where the UNION operator makes the most sense.
 -- UNION only appends distinct values. More specifically, when you use UNION, the dataset is appended, and any rows in the appended table that are exactly identical to rows in the first table are dropped. If you’d like to append all the values 
 -- from the second table, use UNION ALL. You’ll likely use UNION ALL far more often than UNION.
SELECT *
FROM accounts

UNION ALL

SELECT *
  FROM accounts;   
  

WITH double_accounts AS (
    SELECT *
      FROM accounts

    UNION ALL

    SELECT *
      FROM accounts
)

SELECT name,
       COUNT(*) AS name_count
 FROM double_accounts 
GROUP BY 1
ORDER BY 2 DESC;