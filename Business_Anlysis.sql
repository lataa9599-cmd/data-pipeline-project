create database AmericanOrders;

use AmericanOrders
select * from Orders

--find duplicates
select Row_ID, Count(*) as Count_of_orders from Orders
group by Row_ID
having Count(*)>1

--delete duplicates

with deleteDup as (
select *,ROW_NUMBER() over(partition by row_id order by row_id) as rn
from Orders)

--select row_id,rn from deleteDup
--where rn >1

delete from deleteDup
where rn>1

--Total Sales

select sum(sales) as Total_sales from Orders

-- Count of Unique Orders

select count(distinct(Order_ID)) as Total_Order_Count from Orders

-- Count of Unique Customer

select count(distinct(Customer_ID)) as Total_Order_Count from Orders

select Avg(Sales) as Total_Avg from Orders


-- Sales by Region

Select Region, sum(Sales) as Total_Sales from orders
group by Region
order by Total_Sales desc


-- number of orders per customer
select customer_id, count(distinct(order_id)) as countofOrders from Orders
group by Customer_ID
order by countofOrders desc

--profit by category

select category,sum(Profit) as Total_Profit from Orders
group by Category
order by Total_Profit desc

--Average sales per Order

select Order_id, avg(sales) as Avg_Sales from Orders
group by Order_ID
order by Avg_Sales desc

--top orders by sals

Select top 5 order_id,sum(sales) as total_Sales from Orders
group by Order_ID
order by total_Sales desc

--Count of Order per year

select year(Order_Date) as Order_Year, sum(sales) as Total_Sales from Orders
group by year(Order_Date)
order by Total_Sales desc

--Sales by region & Category

select Region, Category, sum(Sales) as Total_Sales from Orders
group by Region, Category
order by Region asc

--Average profit per customer

Select Customer_ID, Avg(Profit) as Avg_Profit from Orders
group by Customer_ID
order by Avg_Profit desc

--- Monthly Sales Trend

select year(Order_Date) as Order_Year, FORMAT(order_date,'MMM') as Months,
sum(Sales) as Total_Sales from Orders
where year(order_Date) = '2019'
group by year(Order_Date),FORMAT(order_date,'MMM'),Month(Order_Date)
order by Order_Year, Month(Order_Date) asc

--profit YOY comparision

WITH Yearly_Profit AS (
    SELECT 
        YEAR(Order_Date) AS Order_Year,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY YEAR(Order_Date)
),
PreYearlyProfit AS (
    SELECT 
        Order_Year,
        Total_Profit,
        LAG(Total_Profit) OVER (ORDER BY Order_Year) AS Previous_Year_Profit
    FROM Yearly_Profit
)
SELECT 
    Order_Year,
    Total_Profit,
    Previous_Year_Profit,
    (Total_Profit - Previous_Year_Profit)*100 / NULLIF(Previous_Year_Profit, 0) AS Growth_Percentage
FROM PreYearlyProfit
ORDER BY Order_Year;


-- top 3 customers by Sales

select top 3 customer_name, sum(sales) as Total_Sales from Orders
group by Customer_Name
order by Total_Sales desc

--bottom 5 product by profit

select 3 Product_ID, sum(Profit) as Total_Profit from Orders
group by Product_ID
order by Total_Profit asc

--Region with highest_Sales

select top 1 Region, sum(sales) as Total_Sales from Orders
group by Region
order by Total_Sales desc


--Category contributing most profit
select  top 1 Category, sum(Profit) as Total_Profit,
sum(profit) * 100 / sum(sum(profit)) over() as Contributing from Orders
group by Category
order by Total_Profit desc

--customer with most orders

select top 1 customer_id, count(distinct(order_id)) as countofOrders from Orders
group by Customer_ID
order by countofOrders desc


--Average order value per region

select  Region, avg(Sales) as Order_Value from orders
group by Region
order by Order_Value desc

--orders with segment

select segment, count(distinct(Order_Id)) as Order_Count from Orders
group by Segment
order by Order_Count desc

--Total Sales by Sub-Category

select Sub_Category, sum(Sales) as Total_Sales from Orders
group by Sub_Category
order by Sub_Category desc

--Repeat Customers

select customer_id,
count(distinct(order_Id)) as Order_Count
from Orders
group by Customer_ID
having count(distinct(Order_ID)) > 1
order by Order_Count desc

--or

select customer_Id, Customer_name,
count(distinct(Order_Id)) as OrderCount,
sum(sales) as Lifetime_Value,
min(Order_Date) as First_purchase,
max(Order_Date) as Last_purchase,
DATEDIFF(month,min(Order_Date),max(Order_Date)) as spend_Month
from Orders
group by customer_Id, Customer_name
having count(distinct(order_Id)) > 1
order by Lifetime_Value desc


--Customers who ordered more than 5 times
select customer_id,
count(distinct(order_Id)) as Order_Count
from Orders
group by Customer_ID
having count(distinct(Order_ID)) > 5
order by Order_Count desc

--Orders with negative profit

select order_id, sum(profit) as Total_Profit
from Orders
where Profit < 0
group by Order_id
order by Total_Profit desc

--heighet month sales

select top 1 FORMAT(order_Date,'MMM') as Order_Month , Sum(Sales) as Total_Sales
from Orders
where year(ORder_Date) = '2019'
group by FORMAT(order_Date,'MMM')
order by Total_Sales desc


--rentention Rate

with currentYear AS(

select year(Order_Date) as Order_Year,count(distinct(customer_id))as Current_Cu_count
from Orders
where year(Order_date) = '2019'
group by year(Order_Date)
),

previous_Year As(

select year(Order_Date) as Order_Year,
count(distinct(customer_id))as previous_Cu_Count
from Orders
where year(Order_date) = '2018'
group by year(Order_Date)
)

select 
prev.Previous_Cu_count,
curr.Current_Cu_count,
curr.Current_Cu_count - prev.Previous_Cu_count AS Customer_Diff,
ROUND((curr.Current_Cu_count - prev.Previous_Cu_count) * 100.0 / prev.Previous_Cu_count, 2) AS Growth_Percent
FROM currentYear as curr
CROSS JOIN previous_Year as prev;


--Category contributing Sales
select  Category, sum(Sales) as Total_Sales,
sum(Sales)*100 / sum(sum(Sales)) over() as ContriPer from Orders
group by Category
order by Total_Sales desc

--running Total

select Order_Date, sum(Sales) as Total_Sales,
sum(sum(Sales)) over(order by sum(SaleS) rows between unbounded preceding and current row) as running_total
from Orders
group by Order_Date

--Rank customer by Sales

select customer_Name , sum(Sales) as Total_Sales,
rank() over(Order by sum(Sales) desc) as rn
from Orders
group by Customer_Name

--Rank orders by sales (per region)

select region, sum(sales) as Total_Sales,
rank()over(order by sum(sales)) as rn
from Orders
group by Region

--Dense rank customers by profit
select customer_name, sum(profit) as Total_Profit,
DENSE_RANK()over(order by sum(Profit) desc) as rn
from Orders
group by Customer_Name

--Top 3 products per category

select * from Orders

with top3Products As
(
select Category, Product_Name, sum(Sales) as Total_sales,
DENSE_RANK()Over(Partition by Category order by sum(Sales) desc) as rn
from Orders
group by Category, Product_Name
)

select Category, Product_Name, Total_Sales, rn
from top3Products
where rn <4


--last 3 Month Moving Average

with Monthly_Sales AS(

Select year(Order_Date) As Order_year,
month(Order_Date) as month_no,
sum(sales) as total_sales
from Orders
group by year(order_Date), Month(Order_Date)
)

select order_year, month_no,
Total_Sales, avg(total_Sales) over(order by Order_year, month_no rows between 2 preceding and current row) as moving_Avg
from Monthly_Sales
ORDER BY Order_Year, Month_No;

--first and last Order by Customer

select customer_id, min(order_Date) as First_order, max(Order_Date) as last_Order
from Orders
group by Customer_ID


--Find gap between consecutive orders

with order_Seq as(

select customer_id,
order_id,
Order_date,
lag(order_date) over(Partition by Customer_id order by Order_date) as Pre_Order_dt
from Orders
)
select customer_id,
order_id,
Order_Date,
pre_Order_dt,DATEDIFF(day, Pre_order_dt,Order_date) as days_since_last_day
from order_Seq
where Pre_Order_dt is not null
ORDER BY Customer_ID, Order_Date























-



