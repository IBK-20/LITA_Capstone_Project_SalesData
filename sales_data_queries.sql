-- Select all columns from the sales_data table
SELECT *
FROM lita_db.sales_data;

-- Change the header column to the right format
Alter Table sales_data
change `Customer Id` CustomerID varchar(15);

-- create a calcuated column for sales
Alter table sales_data
add Sales int;

update  sales_data
Set Sales = Quantity * UnitPrice;

-- Total sales for each product category
SELECT Product, Sum(Sales)
FROM sales_data
Group by Product
order by 2 Desc;

-- Number of sales transactions in each region
SELECT Region, count(Sales)
FROM sales_data
Group by Region
Order by 2 DESC;

-- Highest-selling product by total sales value
SELECT Product, Sum(Sales)
FROM sales_data
Group by Product
order by 2 Desc
Limit 1;

-- Changing the date column to the right format
Select Orderdate,
str_to_date(OrderDate, '%m/%d/%Y')
from sales_data;

Update  sales_data
set OrderDate = str_to_date(OrderDate, '%m/%d/%Y');

Alter table sales_data
Modify column OrderDate Date;

-- Monthly sales totals for the current year
SELECT substring(OrderDate, 1, 7) as Month_Year, Sum(Sales) as Sales
FROM sales_data
Where Year(OrderDate) = 2024
Group by Month_Year;

-- Monthly sales rolling total
With Rolling_total As
( SELECT substring(OrderDate, 1, 7) as Month_Year, Sum(Sales) as Sales
FROM sales_data
Where Year(OrderDate) = 2024
Group by Month_Year 
)
Select Month_Year, Sales, Sum(Sales) over (Order by Month_Year) as Monthly_Rolling_total_2024
From Rolling_total;

-- Top 5 customers by total purchase amount
SELECT CustomerID, sum(Sales)
FROM sales_data
Group by CustomerID
Order by 2 DESC
Limit 5;

-- Percentage of total sales contributed by each region
select Region, Sum(Sales) as Region_Sales, Sum(sales) * 100/ Sum(sum(sales)) over () as Sales_Percentage
From sales_data
Group by Region
Order by 3 Desc;