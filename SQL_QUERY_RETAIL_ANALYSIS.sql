-- RETAIL SALES ANALYSIS SQL PROJECT

-- CREATE TABLE
CREATE TABLE RETAIL_SALES(
transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
)
SELECT * FROM RETAIL_SALES

-- DATA EXPLORATION AND CLEANING:
--Determine the total number of records in the dataset?
SELECT COUNT(*) FROM RETAIL_SALES
--Find out how many unique customers are in the dataset?
SELECT COUNT(DISTINCT CUSTOMER_ID) FROM RETAIL_SALES
--Identify all unique product categories in the dataset?
SELECT DISTINCT CATEGORY FROM RETAIL_SALES
--Check for any null values in the dataset and delete records with missing data?
SELECT * FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL
OR SALE_DATE IS NULL
OR SALE_TIME IS NULL
OR CUSTOMER_ID IS NULL
OR GENDER IS NULL
OR AGE IS NULL
OR CATEGORY IS NULL
OR QUANTITY IS NULL
OR PRICE_PER_UNIT IS NULL
OR COGS IS NULL
OR TOTAL_SALE IS NULL

-- DELETE ALL THE NULL RECORDS:
DELETE FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL
OR SALE_DATE IS NULL
OR SALE_TIME IS NULL
OR CUSTOMER_ID IS NULL
OR GENDER IS NULL
OR AGE IS NULL
OR CATEGORY IS NULL
OR QUANTITY IS NULL
OR PRICE_PER_UNIT IS NULL
OR COGS IS NULL
OR TOTAL_SALE IS NULL

SELECT COUNT(*) FROM RETAIL_SALES

-- DATA ANALYSIS AND FINDINGS:
--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM RETAIL_SALES WHERE SALE_DATE = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM RETAIL_SALES
WHERE 
CATEGORY = 'Clothing'
AND 
TO_CHAR(SALE_DATE, 'YYYY-MM') = '2022-11'
AND
QUANTITY >= 4

--3.Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
CATEGORY,
SUM(TOTAL_SALE) AS TOTAL_SALES
FROM RETAIL_SALES
GROUP BY CATEGORY

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT 
AVG(AGE)
FROM RETAIL_SALES
WHERE CATEGORY= 'Beauty'

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM RETAIL_SALES 
WHERE TOTAL_SALE >= 1000

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category and gender:
SELECT 
COUNT( DISTINCT TRANSACTIONS_ID) AS TOTAL_TRANS,
CATEGORY,
GENDER
FROM RETAIL_SALES
GROUP BY CATEGORY, GENDER

--7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
YEAR,
MONTH,
AVG_SALES
FROM 
(  SELECT 
AVG(TOTAL_SALE) AS AVG_SALES,
EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC) as RANK
FROM RETAIL_SALES
GROUP BY MONTH , YEAR) AS T1
WHERE RANK = 1

--8.Write a SQL query to find the top 5 customers based on the highest total sales :
SELECT
CUSTOMER_ID,
SUM(TOTAL_SALE) AS TOTAL_SUM
FROM RETAIL_SALES
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_SUM DESC
LIMIT 5;

--9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
COUNT(DISTINCT CUSTOMER_ID) AS COUNT_D_CUST,
CATEGORY
FROM RETAIL_SALES
GROUP BY CATEGORY

--10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12
                THEN 'Morning'

            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17
                THEN 'Afternoon'

            ELSE 'Evening'
        END AS shift
    FROM retail_sales
-- ABOVE WE JUST CREATED ANOTHER COLUMN NAME SHIFT AS PER CONDITION GIVEN ON THE QUESTION
WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12
                THEN 'Morning'

            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17
                THEN 'Afternoon'

            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)

SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

--END OF PROJECT























