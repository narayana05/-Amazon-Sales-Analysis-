
USE dbamazon;
#Business Questions To Answer:
#What is the count of distinct cities in the dataset?

SELECT COUNT(DISTINCT City) AS DistinctCityCount 
FROM amazon;


#2 For each branch, what is the corresponding city?

SELECT DISTINCT Branch, City
FROM amazon;

#3 What is the count of distinct product lines in the dataset?

SELECT COUNT(DISTINCT `Product line`) AS DistinctProductLineCount
FROM amazon;

-- #4 Which payment method occurs most frequently?
SELECT Payment, COUNT(*) AS Frequency
FROM amazon
GROUP BY Payment
ORDER BY Frequency DESC
LIMIT 1;

-- #5 Which product line has the highest sales?
SELECT `Product line`, SUM(Total) AS TotalSales
FROM amazon
GROUP BY `Product line`
ORDER BY TotalSales DESC
LIMIT 1;

-- #6 How much revenue is generated each month?
SELECT MONTHNAME(Date) AS Month, SUM(Total) AS MonthlyRevenue 
FROM amazon 
GROUP BY Month
LIMIT 0, 1000;


-- #7 In which month did the cost of goods sold reach its peak?
SELECT DATE_FORMAT(Date, '%M') AS Month, SUM(cogs) AS TotalCOGS 
FROM amazon 
GROUP BY Month 
ORDER BY TotalCOGS DESC 
LIMIT 1;

-- #8 Which product line generated the highest revenue?
SELECT `Product line`, SUM(Total) AS TotalRevenue
FROM amazon
GROUP BY `Product line`
ORDER BY TotalRevenue DESC
LIMIT 1;

-- #9 In which city was the highest revenue recorded?
SELECT City, SUM(Total) AS TotalRevenue
FROM amazon
GROUP BY City
ORDER BY TotalRevenue DESC
LIMIT 1;

-- #10 Which product line incurred the highest Value Added Tax?
SELECT `Product line`, SUM(`Tax 5%`) AS TotalVAT
FROM amazon
GROUP BY `Product line`
ORDER BY TotalVAT DESC
LIMIT 1;

-- #11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
SELECT *,
    CASE 
        WHEN Total > (SELECT AVG(Total) FROM amazon) THEN 'Good'
        ELSE 'Bad'
    END AS SalesPerformance
FROM amazon;

-- #12 Identify the branch that exceeded the average number of products sold.
SELECT Branch
FROM (
    SELECT Branch, COUNT(*) AS ProductsSold
    FROM amazon
    GROUP BY Branch
) AS SoldProducts
WHERE ProductsSold > (SELECT AVG(ProductsSold) FROM (SELECT Branch, COUNT(*) AS ProductsSold FROM amazon GROUP BY Branch) AS AvgSoldProducts);


-- #13 Which product line is most frequently associated with each gender?
SELECT Gender, `Product line`, COUNT(*) AS Frequency
FROM amazon
GROUP BY Gender, `Product line`
ORDER BY Frequency DESC
LIMIT 1;

-- #14 Calculate the average rating for each product line.
SELECT `Product line`, AVG(Rating) AS AverageRating
FROM amazon
GROUP BY `Product line`;

-- #15 Count the sales occurrences for each time of day on every weekday.
SELECT 
    CASE 
        WHEN CAST(SUBSTRING(Time, 1, 2) AS UNSIGNED) >= 6 AND CAST(SUBSTRING(Time, 1, 2) AS UNSIGNED) < 12 THEN 'Morning'
        WHEN CAST(SUBSTRING(Time, 1, 2) AS UNSIGNED) >= 12 AND CAST(SUBSTRING(Time, 1, 2) AS UNSIGNED) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS TimeOfDay,
    DAYNAME(Date) AS Weekday,
    COUNT(*) AS SalesOccurrences 
FROM amazon 
GROUP BY TimeOfDay, Weekday;


-- #16 Identify the customer type contributing the highest revenue.
SELECT `Customer type`, SUM(Total) AS TotalRevenue
FROM amazon
GROUP BY `Customer type`
ORDER BY TotalRevenue DESC
LIMIT 1;

-- #17 Determine the city with the highest VAT percentage.
SELECT City, AVG(`Tax 5%`) AS AverageVAT
FROM amazon
GROUP BY City
ORDER BY AverageVAT DESC
LIMIT 1;

-- #18 Identify the customer type with the highest VAT payments.
SELECT `Customer type`, SUM(`Tax 5%`) AS TotalVAT
FROM amazon
GROUP BY `Customer type`
ORDER BY TotalVAT DESC
LIMIT 1;

-- #19 What is the count of distinct customer types in the dataset?
SELECT COUNT(DISTINCT `Customer type`) AS DistinctCustomerTypeCount
FROM amazon;

-- #20 What is the count of distinct payment methods in the dataset?
SELECT COUNT(DISTINCT Payment) AS DistinctPaymentMethodCount
FROM amazon;

-- #21 Which customer type occurs most frequently?
SELECT `Customer type`, COUNT(*) AS Frequency
FROM amazon
GROUP BY `Customer type`
ORDER BY Frequency DESC
LIMIT 1;

-- #22 Identify the customer type with the highest purchase frequency.
SELECT `Customer type`, COUNT(*) AS PurchaseFrequency
FROM amazon
GROUP BY `Customer type`
ORDER BY PurchaseFrequency DESC
LIMIT 1;

-- #23 Determine the predominant gender among customers.
SELECT Gender, COUNT(*) AS Frequency
FROM amazon
GROUP BY Gender
ORDER BY Frequency DESC
LIMIT 1;

-- #24 Examine the distribution of genders within each branch.
SELECT Branch, Gender, COUNT(*) AS Frequency
FROM amazon
GROUP BY Branch, Gender;

-- #25 Identify the time of day when customers provide the most ratings.
SELECT 
    CASE 
        WHEN CAST(SUBSTRING(Time, 1, 2) AS SIGNED) >= 6 AND CAST(SUBSTRING(Time, 1, 2) AS SIGNED) < 12 THEN 'Morning'
        WHEN CAST(SUBSTRING(Time, 1, 2) AS SIGNED) >= 12 AND CAST(SUBSTRING(Time, 1, 2) AS SIGNED) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS TimeOfDay,
    COUNT(Rating) AS RatingCount
FROM amazon
GROUP BY TimeOfDay
ORDER BY RatingCount DESC
LIMIT 1;


-- #26 Determine the time of day with the highest customer ratings for each branch.
SELECT 
    CASE 
        WHEN CAST(SUBSTR(Time, 1, 2) AS SIGNED) >= 6 AND CAST(SUBSTR(Time, 1, 2) AS SIGNED) < 12 THEN 'Morning'
        WHEN CAST(SUBSTR(Time, 1, 2) AS SIGNED) >= 12 AND CAST(SUBSTR(Time, 1, 2) AS SIGNED) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS TimeOfDay,
    AVG(Rating) AS AverageRating
FROM amazon
GROUP BY TimeOfDay
ORDER BY AverageRating DESC
LIMIT 1;


-- #27 Identify the day of the week with the highest average ratings.
SELECT DAYNAME(Date) AS Weekday, AVG(Rating) AS AverageRating
FROM amazon
GROUP BY Weekday
ORDER BY AverageRating DESC
LIMIT 1;

-- #28 Determine the day of the week with the highest average ratings for each branch.
SELECT 
    Branch,
    DAYNAME(Date) AS Weekday,
    AVG(Rating) AS AverageRating
FROM amazon
GROUP BY Branch, Weekday;
