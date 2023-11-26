SELECT * 
FROM sql_inventory.products;

SELECT name 
FROM sql_inventory.products;

SELECT unit_price
FROM sql_inventory.products;

SELECT quantity_in_stock AS STOCK
FROM sql_inventory.products
WHERE NAME IN ('foam dinner plate','longan');

SELECT quantity_in_stock
FROM sql_inventory.products
WHERE NAME IN ('foam dinner plate','longan');

SELECT sum(quantity_in_STOCK) 
FROM sql_inventory.products 
WHERE Name IN ('Longan','petit baguette');

SELECT avg(quantity_in_STOCK) 
FROM sql_inventory.products;

SELECT name, quantity_in_stock, quantity_in_stock + 10 
FROM sql_inventory.products;

SELECT name, quantity_in_stock, quantity_in_stock + 10 * 100 
FROM sql_inventory.products;

SELECT name, quantity_in_stock, (quantity_in_stock + 10) * 100 AS discount 
FROM sql_inventory.products;

UPDATE sql_inventory.PRODUCTS 
SET NAME = 'BROOM' WHERE PRODUCT_ID = 1;

UPDATE sql_inventory.PRODUCTS 
SET NAME = 'Foam Dinner Plate' WHERE PRODUCT_ID = 1;

INSERT INTO sql_inventory.products 
VALUES (11, 'Broom', 550, 5.23);

SELECT * 
FROM sql_inventory.products;

DELETE FROM sql_inventory.products 
WHERE product_id = 11;

SELECT name, unit_price, unit_price * 1.1 AS New_Price 
FROM sql_inventory.products;

SELECT * 
FROM sql_store.orders;

SELECT * 
FROM sql_store.orders 
WHERE order_date >= '2019-01-01';

SELECT * 
FROM sql_store.orders 
WHERE NOT order_date >= '2019-01-01';

SELECT * 
FROM sql_store.order_items 
WHERE order_id = 6 AND unit_price * quantity > 30;

SELECT * 
FROM sql_store.order_items 
WHERE order_id = 6 OR unit_price * quantity > 30;

SELECT * 
FROM sql_store.customers 
WHERE state IN ('VA', 'FL', 'GA');

SELECT * 
FROM sql_store.customers 
WHERE state NOT IN ('VA', 'FL', 'GA');

SELECT * FROM sql_inventory.products;

SELECT * 
FROM sql_inventory.products 
WHERE quantity_in_stock IN (49, 38, 72);

SELECT * 
FROM sql_inventory.products 
WHERE quantity_in_stock BETWEEN 10 AND 50;

SELECT * 
FROM sql_store.customers 
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * 
FROM sql_store.customers 
WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';

SELECT * 
FROM sql_store.customers 
WHERE phone LIKE '%9';

SELECT * 
FROM sql_store.customers 
WHERE phone NOT LIKE '%9';

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP 'FIELD';

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('^FIELD');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('FIELD$');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('FIELD|MAC|ROSE');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('^FIELD|MAC|ROSE');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('FIELD$|MAC|ROSE');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('[GIM]E');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('E[GIM]');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('[A-H]E');

SELECT * 
FROM sql_store.customers 
WHERE first_name REGEXP ('ELKA|AMBUR');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('EY$|ON$');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('^MY|SE');

SELECT * 
FROM sql_store.customers 
WHERE last_name REGEXP ('B[RU]');

SELECT * 
FROM sql_store.orders 
WHERE shipped_date IS NULL;

SELECT * 
FROM sql_store.orders 
WHERE shipped_date IS NOT NULL;

SELECT * 
FROM sql_store.order_items 
where order_id = 2 
ORDER BY product_id;

SELECT * 
FROM sql_store.order_items 
where order_id = 2 
ORDER BY quantity * unit_price DESC;

SELECT *, quantity * unit_price AS total_price 
FROM sql_store.order_items 
where order_id = 2 
ORDER BY total_price DESC;

SELECT * 
FROM sql_store.customers 
ORDER BY points DESC 
LIMIT 3;

INSERT INTO sql_inventory.products 
VALUES (11, 'Broom', 550, 5.23);

SELECT * 
FROM SQL_INVENTORY.PRODUCTS;

INSERT INTO sql_inventory.products (NAME, QUANTITY_IN_STOCK, UNIT_PRICE) 
	VALUES ('Broom', 550, 1.95),
		   ('Mop', 250, 1.20),
           ('Television', 130, 2.4);
           
SELECT * 
FROM sql_store.orders 
JOIN sql_store.customers 
ON orders.customer_id = customers.customer_id;

SELECT first_name, last_name
FROM sql_store.orders 
JOIN sql_store.customers 
ON orders.customer_id = customers.customer_id;

SELECT * 
FROM sql_store.orders 
JOIN sql_store.customers 
ON orders.customer_id = customers.customer_id;

SELECT * 
FROM sql_store.order_items
JOIN sql_inventory.products 
ON order_items.product_id = products.product_id;

SELECT * 
FROM sql_store.order_items
INNER JOIN sql_inventory.products 
ON order_items.product_id = products.product_id;

SELECT * 
FROM sql_store.order_items
LEFT JOIN sql_inventory.products 
ON order_items.product_id = products.product_id;

select * from sql_inventory.products;
SELECT * 
FROM sql_store.order_items
RIGHT JOIN sql_inventory.products 
ON order_items.product_id = products.product_id;
SELECT * 
FROM sql_store.customers 
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * 
FROM sql_store.customers 
WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';


SELECT * 
FROM sql_store.customers 
ORDER BY points DESC 
LIMIT 3;

SELECT * FROM sql_store.orders;
SELECT * FROM sql_store.orders WHERE order_date >= '2019-01-01';
SELECT * FROM sql_store.orders WHERE NOT order_date >= '2019-01-01';

SELECT * FROM sql_store.orders WHERE shipped_date IS NULL;

SELECT * FROM sql_invoicing.payments;
SELECT * FROM sql_inventory.products;
SELECT * FROM sql_invoicing.clients;
SELECT * FROM sql_invoicing.invoices;
SELECT * FROM sql_invoicing.payment_methods;
SELECT * FROM sql_store.customers;
SELECT * FROM sql_store.order_item_notes;
SELECT * FROM sql_store.orders;
SELECT * FROM sql_store.order_items;
SELECT * FROM sql_store.products;
SELECT * FROM sql_store.shippers;
SELECT * FROM sql_store.order_statuses;
SELECT * FROM sql_hr.offices;

SELECT * 
FROM sql_invoicing.payments AS SIP
JOIN sql_invoicing.payment_methods SIPM
	ON SIP.payment_method = SIPM.payment_method_id
ORDER BY AMOUNT DESC;

SELECT *
FROM sql_invoicing.clients AS SIC
JOIN sql_invoicing.invoices AS SII
	ON SIC.client_id = SII.client_id;

SELECT *
,CASE 
	WHEN payment_date = null THEN 'Client has not paid invoice' 
	ELSE 'Invoice Paid'
END 
FROM sql_invoicing.clients AS SIC
JOIN sql_invoicing.invoices AS SII
	ON SIC.client_id = SII.client_id;

SELECT * FROM sql_invoicing.clients AS SIC;

SELECT *,
COUNT(invoice_total) OVER (partition by client_id) AS SII
FROM sql_invoicing.invoices;         

#client with no record of payment
SELECT client_id, invoice_date, due_date, payment_date, invoice_total
FROM(
	SELECT client_id,invoice_date, due_date, payment_date, invoice_total,
	COUNT(payment_date) OVER (partition by payment_date) AS SII
	FROM sql_invoicing.invoices) AS X
WHERE X.SII < 1
order by client_id;       

SELECT SII.client_id, invoice_date, invoice_total, due_date, payment_date
FROM sql_invoicing.clients AS SIC
RIGHT JOIN sql_invoicing.invoices AS SII
	ON SIC.client_id = SII.client_id
ORDER BY payment_date; 

SELECT * FROM sql_invoicing.clients;

#Shows duplicate client with less than 2 payment invoice
SELECT client_id,invoice_date, invoice_total, payment_total, payment_date
FROM (
	SELECT *,
	COUNT(client_id) OVER (partition by client_id) AS COUNT
	FROM sql_invoicing.invoices) AS X
WHERE X.COUNT < 2;


 #show duplicate records for few records
SELECT client_id,invoice_date, invoice_total, payment_total, payment_date
FROM (
	SELECT *,
	row_number() OVER (partition by client_id) AS COUNT
	FROM sql_invoicing.invoices) AS X
WHERE X.COUNT > 2;

#show staff working in the same place but different position
select str1.*
from store as str1
join store as str2
on str1.staff_id <> str2.satff_id and str1.office = str2.office and str1.position <> str2.position;

#shows second highest salary
SELECT Max(salary) 
FROM (SELECT Max(Salary) 
FROM Employee ORDER BY salary DESC) AS MAX
WHERE MAX = 2;

#shows third AND fourth highest salary
SELECT first_name, department, MAX(salary)
FROM (SELECT first_name, department, MAX(salary),
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary) AS MAX
FROM EMPLOYEE
GROUP BY first_name, department
-- HAVING Max(salary)
ORDER BY salary) AS X
WHERE X.MAX BETWEEN 3 AND 4;

SELECT first_name, department, MAX(salary)
FROM (SELECT first_name, department, MAX(salary),
RANK() OVER (PARTITION BY department ORDER BY salary) AS MAX
FROM EMPLOYEE
GROUP BY first_name, department
-- HAVING Max(salary)
ORDER BY salary) AS X
WHERE X.MAX BETWEEN 3 AND 4;

-- delete duplicate records, begin by using select statement to find duplicate records 
-- then use select to find the max or min primary key of the duplicate record
-- then delete employee id not in the max or min duplicate

select first_name, last_name, count(*)
from employee
group by first_name, last_name
having count(*) > 1;

DELETE FROM employee
WHERE employee_id NOT IN (select max(employee_id) 
from employee
group by first_name, last_name);


-- customers that delivery have been made to 
SELECT sc.customer_id, sc.first_name, sc.last_name, sc.address, sc.city, sc.state, S.Name as shipper_name, S.shipped_date
FROM sql_store.customers as SC
Join (SELECT SO.order_id, SO.Customer_id, SO.shipped_date, ss.NAME 
FROM sql_store.orders SO
join sql_store.shippers SS
on SO.shipper_id = SS.shipper_id
order by order_id) as S
ON SC.Customer_id = S.customer_id;

SELECT name, sum(quantity_in_stock) 
FROM sql_inventory.products
where unit_price > 3
group by name, quantity_in_stock;
