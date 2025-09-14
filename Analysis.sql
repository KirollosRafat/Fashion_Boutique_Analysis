# Let's see how many columns are there
SELECT COUNT(*)
FROM fashion_boutique;

# Turn the purchase_date column from text to date
ALTER TABLE  fashion_boutique
MODIFY purchase_date DATE;

SELECT *
FROM fashion_boutique;

SELECT ROUND(AVG(customer_rating),1) AS avg_customer_rating 
FROM fashion_boutique;

# Handle the missing customer_rating by mean imputation
UPDATE fashion_boutique
SET customer_rating = 2.5 # 2.5 is obtained from the prvious query
WHERE customer_rating = '' OR customer_rating IS NULL;

SELECT *
FROM fashion_boutique;

# inspect the max and min price category,brand
SELECT category,brand,current_price
FROM fashion_boutique
WHERE current_price = (SELECT MAX(current_price) FROM fashion_boutique)  OR 
current_price = (SELECT MIN(current_price) FROM fashion_boutique);

# What is the best color,season:
-- best selling color
SELECT color,MAX(current_price) AS max_price
FROM fashion_boutique
GROUP BY color
ORDER BY max_price DESC
LIMIT 1;

-- best selling season
SELECT season
FROM fashion_boutique
GROUP BY season
ORDER BY MAX(current_price) DESC
LIMIT 1;

# Average Customer Rating Satisfaction Per Category
SELECT category, ROUND((AVG(customer_rating)/5)*100,2) AS satisfaction_percentage
FROM  fashion_boutique
GROUP BY category
ORDER BY satisfaction_percentage DESC;

# Customer Rating Per Category,Brand
SELECT category,brand,MAX(customer_rating) AS max_rating
FROM fashion_boutique
GROUP BY category,brand
HAVING max_rating = 5
ORDER BY brand;


# Let's see the best selling size for each category
SELECT brand,size
FROM fashion_boutique
WHERE current_price IN (SELECT MAX(current_price) FROM fashion_boutique GROUP BY category) AND size <> '';

# Let's see How many returns occured
SELECT COUNT(is_returned) AS number_of_returns
FROM fashion_boutique
WHERE is_returned = 'True';

# Percentage of returns
WITH returns_ AS
(
SELECT COUNT(is_returned) AS number_of_returns
FROM fashion_boutique
WHERE is_returned = 'True'
),
not_returned AS
(
SELECT COUNT(is_returned) AS total_purchases
FROM fashion_boutique
)
SELECT *, ROUND((number_of_returns/total_purchases)*100,2) AS returns_percentage
FROM returns_
INNER JOIN not_returned;

# Let's inspect the common reasons why returns happen
WITH common_reasons AS 
(
SELECT is_returned,return_reason
FROM fashion_boutique
WHERE is_returned = 'True'
)
SELECT return_reason,COUNT(is_returned) AS number_of_returns_per_reason
FROM common_reasons
GROUP BY return_reason
ORDER BY number_of_returns_per_reason DESC;
## Seems that the most common is customers change their mind and the second one is size issue.
## Size should be obtained with high care to reduce the returns of such issue.

# Final insight: Let's see how the boutique performed from 2024 to 2025
WITH profit_2024 AS (
SELECT YEAR(purchase_date) AS years, ROUND(SUM(current_price),2) AS total_price_2024
FROM fashion_boutique
WHERE is_returned = 'False' AND YEAR(purchase_date) = 2024
GROUP BY years
),
profit_2025 AS (
SELECT YEAR(purchase_date) AS years, ROUND(SUM(current_price),2) AS total_price_2025
FROM fashion_boutique
WHERE is_returned = 'False' AND YEAR(purchase_date) = 2025
GROUP BY years
)
SELECT ROUND((total_price_2025 - total_price_2024),2) AS difference_between_years
FROM profit_2024
JOIN profit_2025;

# The bussiness is growing as total profit of 2025 is greater than that of 2024 by '128458.05'

