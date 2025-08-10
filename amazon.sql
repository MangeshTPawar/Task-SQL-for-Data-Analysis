-- Q1: View orders
SELECT * FROM amazon;

-- Q2: Count total orders
SELECT COUNT(*) AS total_orders FROM amazon;

-- Q3: Total revenue (sum of total_sale)
SELECT ROUND(SUM(total_sales),2) AS total_revenue FROM amazon;

-- Q4: Total revenue for completed orders
SELECT ROUND(SUM(total_sales),2) AS revenue_completed
FROM amazon
WHERE status = 'Completed';

-- Q5: Total revenue by status
SELECT status, ROUND(SUM(total_sales),2) AS revenue
FROM amazon
GROUP BY status
ORDER BY revenue DESC;

-- Q6: Total revenue by category
SELECT category, ROUND(SUM(total_sales),2) AS revenue
FROM amazon
GROUP BY category
ORDER BY revenue DESC;

-- Q7: Total quantity sold per product
SELECT product, SUM(quantity) AS total_quantity
FROM amazon
GROUP BY product
ORDER BY total_quantity DESC;

-- Q8: Average order value (AOV)
SELECT ROUND(AVG(total_sales),2) AS avg_order_value FROM amazon;

-- Q9: Highest single order by value
SELECT order_id, date, customer_name, total_sales
FROM amazon
ORDER BY total_sales DESC
LIMIT 1;

-- Q10: Lowest non-zero order
SELECT order_id, date, total_sales
FROM amazon
WHERE total_sales > 0
ORDER BY total_sales ASC
LIMIT 1;

-- Q11: Orders placed in the last 30 days 
SELECT * FROM amazon
WHERE date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY date DESC;

-- Q12: Revenue by customer (who bought the most in money)
SELECT customer_name, ROUND(SUM(total_sales),2) AS total_spent
FROM amazon
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- Q13: Count orders per payment method
SELECT payment_method, COUNT(*) AS orders_count
FROM amazon
GROUP BY payment_method
ORDER BY orders_count DESC;

-- Q14: Top 5 cities by revenue
SELECT customer_location, ROUND(SUM(total_sales),2) AS revenue
FROM amazon
GROUP BY customer_location
ORDER BY revenue DESC
LIMIT 5;

-- Q15: List of pending orders (for follow-up)
SELECT order_id, date, customer_name, product, total_sales
FROM amazon
WHERE status = 'Pending'
ORDER BY date;

-- Q16: Data validation - show rows where total_sale differs from price * quantity
SELECT order_id, price, quantity, total_sales, ROUND(price * quantity, 2) AS calc_total, 
       ROUND(ABS(total_sales - price * quantity),2) AS diff
FROM amazon
WHERE total_sales IS NULL OR ROUND(ABS(total_sales - price * quantity),2) > 0.01;

-- Q17: Create a simple view of completed order summary
DROP VIEW IF EXISTS vw_completed_orders;
CREATE VIEW vw_completed_orders AS
SELECT order_id,date, product, category, quantity, total_sales, customer_name, customer_location, payment_method
FROM amazon
WHERE status = 'Completed';

-- Q18: Use the view
SELECT * FROM vw_completed_orders ORDER BY date DESC LIMIT 50;

-- Q19: Count cancelled orders
SELECT COUNT(*) AS cancelled_count
FROM amazon
WHERE status = 'Cancelled';

-- Q20: Distinct products sold
SELECT DISTINCT product FROM amazon ORDER BY product;

-- Q21: First and last order date in dataset
SELECT MIN(date) AS first_order, MAX(date) AS last_order FROM amazon;

-- Q22: Top 3 products by revenue
SELECT product, ROUND(SUM(total_sales),2) AS revenue
FROM amazon
GROUP BY product
ORDER BY revenue DESC
LIMIT 3;

-- Q23: Simple EXPLAIN for performance check (shows index usage)
EXPLAIN SELECT * FROM amazon WHERE status='Completed' AND category='Electronic';





