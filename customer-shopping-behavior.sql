-- Total Revenue by Gender
SELECT 
    Gender,
    SUM(`Purchase Amount (USD)`) AS total_revenue
FROM customer_shopping_behavior
GROUP BY Gender;


-- Customers with Discount and Above Average Purchase Amount
SELECT 
    `Customer ID`,
    `Purchase Amount (USD)`,
    `Discount Applied`
FROM customer_shopping_behavior
WHERE `Discount Applied` = 'Yes'
AND `Purchase Amount (USD)` > (
    SELECT AVG(`Purchase Amount (USD)`)
    FROM customer_shopping_behavior
);


-- Top 5 Items by Average Review Rating
SELECT 
    `Item Purchased`,
    AVG(`Review Rating`) AS avg_rating
FROM customer_shopping_behavior
GROUP BY `Item Purchased`
ORDER BY avg_rating DESC
LIMIT 5;


-- Average Purchase Amount by Shipping Type
SELECT 
    `Shipping Type`,
    AVG(`Purchase Amount (USD)`) AS avg_purchase_amount
FROM customer_shopping_behavior
WHERE `Shipping Type` IN ('Standard', 'Express')
GROUP BY `Shipping Type`;


-- Revenue and Average Purchase by Subscription Status
SELECT 
    `Subscription Status`,
    AVG(`Purchase Amount (USD)`) AS avg_purchase,
    SUM(`Purchase Amount (USD)`) AS total_revenue
FROM customer_shopping_behavior
GROUP BY `Subscription Status`;


-- Top 5 Items with Highest Discount Usage Rate
SELECT 
    `Item Purchased`,
    ROUND(
        (SUM(CASE WHEN `Discount Applied` = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
        2
    ) AS discount_rate
FROM customer_shopping_behavior
GROUP BY `Item Purchased`
ORDER BY discount_rate DESC
LIMIT 5;


-- Customer Segmentation Based on Previous Purchases
SELECT 
    `Customer ID`,
    `Previous Purchases`,
    CASE
        WHEN `Previous Purchases` = 0 THEN 'New'
        WHEN `Previous Purchases` BETWEEN 1 AND 5 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_segment
FROM customer_shopping_behavior;


-- Customer Count by Segment
SELECT 
    CASE
        WHEN `Previous Purchases` = 1 THEN 'New'
        WHEN `Previous Purchases` BETWEEN 2 AND 8 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_segment,
    COUNT(*) AS customer_count
FROM customer_shopping_behavior
GROUP BY customer_segment;


-- Most Purchased Items by Category
SELECT 
    Category,
    `Item Purchased`,
    COUNT(*) AS total_purchase
FROM customer_shopping_behavior
GROUP BY Category, `Item Purchased`
ORDER BY Category, total_purchase DESC;


-- Loyal Customers by Subscription Status
SELECT 
    `Subscription Status`,
    COUNT(*) AS total_customers
FROM customer_shopping_behavior
WHERE `Previous Purchases` > 5
GROUP BY `Subscription Status`;


-- Revenue by Age Group
SELECT 
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 40 THEN '26-40'
        WHEN Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS age_group,
    SUM(`Purchase Amount (USD)`) AS total_revenue
FROM customer_shopping_behavior
GROUP BY age_group
ORDER BY total_revenue DESC;