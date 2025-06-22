drop database dataspark
use dataspark
show tables in dataspark
-- 01_Detailed_Sales_Transactions_With_Profit_Local_and_USD.csv
-- Insight: Full transaction details with revenue and profit (USD only)
SELECT 
    `Order Number`, `Line Item`, `Order Date`, `Delivery Date`, `CustomerKey`, `StoreKey`, `ProductKey`,
    Quantity, `Currency Code`, Gender, Name AS CustomerName, City, State, Country, Continent,
    `Product Name`, Brand, Category, Subcategory, `Unit Cost USD`, `Unit Price USD`,
    (Quantity * `Unit Price USD`) AS Revenue_USD,
    (Quantity * `Unit Cost USD`) AS Cost_USD,
    ((Quantity * `Unit Price USD`) - (Quantity * `Unit Cost USD`)) AS Profit_USD
FROM Sales_Store_Customer_Product;

-- 02_Store_Performance_Revenue_Profit_Per_SqM.csv
-- Insight: Store-level performance
SELECT 
    StoreKey, State, Country, `Square Meters`, `Open Date`, Is_Online,
    COUNT(DISTINCT `Order Number`) AS Total_Orders,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD,
    SUM((Quantity * `Unit Price USD`) - (Quantity * `Unit Cost USD`)) AS Total_Profit_USD,
    ROUND(SUM(Quantity * `Unit Price USD`) / `Square Meters`, 2) AS Revenue_per_SqM
FROM Sales_Store_Customer_Product
GROUP BY StoreKey, State, Country, `Square Meters`, `Open Date`, Is_Online;

-- 03_Top_Customers_By_Revenue.csv
-- Insight: High-value customers
SELECT 
    CustomerKey, Name AS CustomerName, Gender, Age_group, City, Country,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD,
    COUNT(DISTINCT `Order Number`) AS Total_Orders
FROM Sales_Store_Customer_Product
GROUP BY CustomerKey, Name, Gender, Age_group, City, Country
ORDER BY Total_Revenue_USD DESC;

-- 04_Top_20_Best_Selling_Products.csv
-- Insight: Top 20 products by revenue and quantity
SELECT 
    `ProductKey`, `Product Name`, Brand, Category, Subcategory,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD
FROM Sales_Store_Customer_Product
GROUP BY `ProductKey`, `Product Name`, Brand, Category, Subcategory
ORDER BY Total_Revenue_USD DESC;

-- 05_Monthly_Revenue_Trend.csv
-- Insight: Revenue trend by month
SELECT 
    Order_Year, Order_Month,
    SUM(Quantity * `Unit Price USD`) AS Monthly_Revenue_USD
FROM Sales_Store_Customer_Product
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;

-- 06_AgeGroup_Gender_Insights_Revenue_Orders.csv
-- Insight: Revenue by Age Group and Gender
SELECT 
    Age_group, Gender,
    COUNT(DISTINCT `Order Number`) AS Total_Orders,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD
FROM Sales_Store_Customer_Product
GROUP BY Age_group, Gender;

-- 07_Top_Cities_And_Countries_By_Revenue.csv
-- Insight: Top cities and countries
SELECT 
    Country, City,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD,
    COUNT(DISTINCT `Order Number`) AS Total_Orders
FROM Sales_Store_Customer_Product
GROUP BY Country, City
ORDER BY Total_Revenue_USD DESC;

-- 08_Profitability_By_Product_Category_Subcategory.csv
-- Insight: Profit per product category and subcategory
SELECT 
    Category, Subcategory,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD,
    SUM(Quantity * `Unit Cost USD`) AS Total_Cost_USD,
    SUM((Quantity * `Unit Price USD`) - (Quantity * `Unit Cost USD`)) AS Total_Profit_USD
FROM Sales_Store_Customer_Product
GROUP BY Category, Subcategory;

-- 09_Most_Popular_Brands_By_Revenue.csv
-- Insight: Brands with highest revenue
SELECT 
    Brand,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD
FROM Sales_Store_Customer_Product
GROUP BY Brand
ORDER BY Total_Revenue_USD DESC;

-- 10_AgeGroup_Preference_By_Product_Category.csv
-- Insight: Age group vs. category preferences
SELECT 
    Age_group, Category,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Quantity * `Unit Price USD`) AS Total_Revenue_USD
FROM Sales_Store_Customer_Product
GROUP BY Age_group, Category
ORDER BY Age_group, Total_Revenue_USD DESC;

