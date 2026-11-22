/********************************************************************************
COHORT ANALYSIS
=================================================================================
Objective: Analyze customers retention
*********************************************************************************
*/
 -- Calculate total customer acquisition every year
with Cohort_Year as (
  select
    format_date('%Y', min(Order_Date)) as Year,
    Customer_ID
  from `sales_clean`
  where Sales_Amount > 0 and Order_Status != "Returned" and Order_Status != "Cancelled"
  group by Customer_ID
)

select
  Year,
  count(distinct z.Customer_ID) as Total_Cust,
  nullif(lag(count(distinct z.Customer_ID))over (order by Year), 0) as Prev_Year,
  round(
    ((count(distinct z.Customer_ID) - lag(count(distinct z.Customer_ID))over (order by Year))
    / nullif(lag(count(distinct z.Customer_ID))over (order by Year), 0) * 100), 1
  ) as Growth_Pct
from Cohort_Year 
group by Year
order by Year

  -- Find customer's initial purchase.
with Cust_First_Purchase as (
  select
    Customer_ID,
    date_trunc(min(Order_Date), Month) as Cohort_Month

  FROM `sales_clean`

  where Customer_ID is not null and Sales_Amount > 0
  group by Customer_ID
),

  -- Find every customers orders for tracking customers purchases activity.

Activity as (
  select distinct
    Customer_ID,
    date_trunc(Order_Date, MONTH) as Activity_Month

  FROM `sales_clean`

  where Customer_ID is not null and Sales_Amount > 0
),

  -- Count customers unique IDs for tracking total active customers for each month.

Cohort_Sizes as (
  select
    Cohort_Month, 
    count(distinct Customer_ID) as Cohort_Size

  from Cust_First_Purchase

  group by Cohort_Month
)

  -- Tracking cohort retention over time
  -- Calculate the difference between customer's initial acquisition and their subsequent activity month.
  -- Calculate total of retained customers.
  -- Calculate the percentage of retained customers, by using safe_divide() to make sure there is no error when divided by 0.
  -- Group by cohort_month, total_cohort_size, after_month

select
  c.Cohort_Month,
  s.Cohort_Size,
  date_diff(cast(a.Activity_Month as date), cast(c.Cohort_Month as date), month) as After_Month,
  count(distinct a.Customer_ID) as Retained_Cust,
  round(
    safe_divide(count(distinct a.Customer_ID) * 100, s.Cohort_Size), 2
  ) as Retention_Pct

from Cust_First_Purchase c


join Activity a on c.Customer_ID = a.Customer_ID
join Cohort_Sizes s on s.Cohort_Month = c.Cohort_Month

group by 1, 2, 3
order by 1, 3
