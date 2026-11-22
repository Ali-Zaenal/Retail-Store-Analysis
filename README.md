# Retail Store Analysis
End-to-end data analysis project featuring data cleaning, growth tracking, and cohort retention analysis to uncover key business drivers.


# Data Cleaning, Growth Analysis & Customer Retention

## 📌 Project Overview
This project analyzes Retail Sales to evaluate business performance and customer retention. The workflow covers raw data cleaning, exploratory growth analysis, and time-based cohort analysis to identify actionable opportunities for improving customer retention.

## 🛠️ Tools & Technologies
* **Language:** SQL, BigQuery
* CTEs, Window Functions, Joins, Cohort Modeling, Data Imputation

## 🔍 Key Workflow & Methodology
1. **Data Cleaning & Preprocessing:** 
   * Handled missing values, removed duplicate records, and standardized formats.
   * Filtered out "Returned" and "Cancelled" orders.
2. **Growth Analysis:** 
   * Measured Month-over-Month (MoM) growth across key metrics such as active customers, revenue, and growth percentage.
   * Identified seasonal trends and peak acquisition periods.
3. **Cohort Analysis:** 
   * Grouped users into monthly acquisition cohorts based on their first purchase.
   * Calculate customer retention percentage.
   * Calculate Yearly new customer acquisition.

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
                        
