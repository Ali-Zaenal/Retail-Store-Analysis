/********************************************************************************
MONTHLY REVENUE AND GROWTH
=================================================================================
Objective: Analyze total revenue monthly and identify growth and active customers
*********************************************************************************
  -- Truncate Order_date to a month, for grouping transaction monthly.
  -- Counting Customer_ID to identify total of active customers.
  -- Filter out blank customer id and zero sales retrieved.
*/

with Monthly_Sales as (
  SELECT

    date_trunc(Order_Date, MONTH) as Sales_Month,
    round(sum(Sales_Amount), 2) as Total_Revenue,
    count(distinct Customer_ID) as Active_Customers

  FROM `sales_clean`

  where Customer_ID is not null and Sales_Amount > 0
  group by Sales_Month
)

select
  Sales_Month,
  Total_Revenue,
  Active_Customers,

-- Getting previous month revenue using window function.
-- Calculating the month-over-month percentage growth.

  lag(Total_Revenue) over(order by Sales_Month) as Last_Month_Revenue,
  round(
    ((Total_Revenue - lag(Total_Revenue) over (order by Sales_Month))
    / nullif(lag(Total_Revenue) over(order by Sales_Month), 0) * 100), 1
  ) as MoM_Growth_Pct

from Monthly_Sales
