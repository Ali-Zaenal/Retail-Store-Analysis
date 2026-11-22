# Retail Store Analysis
End-to-end data analysis project featuring data cleaning, growth tracking, and cohort retention analysis to uncover key business drivers.


# Data Cleaning, Growth Analysis & Customer Retention

## 📌 Project Overview
This project analyzes Retail Sales to evaluate business performance and customer retention. The workflow covers raw data cleaning, exploratory growth analysis, and time-based cohort analysis to identify actionable opportunities for improving customer retention.

## 🛠️ Tools & Technologies
* **Language:** SQL, BigQuery
* CTEs, Window Functions, Joins, Cohort Modeling, Data Imputation

## 🔍 Key Workflow & Methodology
1. **Data Cleaning & Preprocessing:**  -- [View sql queries](data-cleaning.sql)
   * Handled missing values, removed duplicate records, and standardized formats.
   * Filtered out "Returned" and "Cancelled" orders.
     
     <img width="879" height="337" alt="data_cleaning_1" src="https://github.com/user-attachments/assets/5b8e10b3-0398-4729-a877-148c77cfe3b4" />
     
2. **Growth Analysis:**  -- [View sql queries](revenue-growth.sql)
   * Measured Month-over-Month (MoM) growth across key metrics such as active customers, revenue, and growth percentage.
   * Identified seasonal trends and peak acquisition periods.

      
     <img width="837" height="320" alt="revenue_growth" src="https://github.com/user-attachments/assets/7ffe2250-342d-45a7-bac7-4d319c467b0e" />

     
3. **Cohort Analysis:**  -- [View sql queries](cohort-analysis.sql)
   * Grouped users into monthly acquisition cohorts based on their first purchase.
   * Calculate customer retention percentage.
   * Calculate Yearly new customer acquisition.


     <img width="496" height="120" alt="cohort_year" src="https://github.com/user-attachments/assets/e82a5b1d-9eb8-4d96-bb8b-b327f8c7a9d1" />

     <img width="516" height="284" alt="cohort_rate_1" src="https://github.com/user-attachments/assets/c9c685d1-1936-4848-8e65-0e52bd9c78a8" />
     
     <img width="512" height="283" alt="cohort_rate_2" src="https://github.com/user-attachments/assets/61bf4039-d3d0-45d8-b362-ca049acfa586" />

## ⚠️ Data Limitations
* Only four years of historical data (2022-Jan to 2025-Des).
* No geographic information.
* No customer feedback.

## 💡 Key Insights & Findings
* **Insight 1:**
  * Revenue and active customer counts reliably reach their seasonal highs between October and December.
* **Insight 2:**
  * Customer acquisition is declining significantly. The number of new customers has dropped substantially every year since      2022.
* **Insight 3:**
  * Customer retention is relatively weak. Only around 5–7% of customers return in a given month after                           their acquisition month.
* **Recommendation:**
  1. Investigate the acquisition decline:
      * Compare marketing spending, channel performance, conversion rates, and customer acquisition costs                            across years.
  2. Improve first-month retention: 
      * Month 1 retention is below 7% across all four years
      * Investigate onboarding, first-purchase experience, product value, and customer follow-up                                     campaigns.
      * Test targeted communication within the first 30 days.
                        
