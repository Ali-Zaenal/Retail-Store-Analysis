/*******************************************************************************
DATA CLEANING
================================================================================

Objective:    Transform raw retail transaction records into a standardized, 
              deduplicated, and reliable dataset for downstream analytics.
--------------------------------------------------------------------------------
*******************************************************************************/

/*
1. CUSTOMER IDENTITY REPAIR:
   - Trailing/leading white spaces removed.
   - Text standardized to Proper Case.
   - Resolves missing values in the Customer_Name and Customer_Gender by applying a deterministic cross-column look-forward/look-back mechanism
     based on the customer’s unique ID.
   - Resolves missing values in the Customer_Age and convert it from approximate decimals (FLOAT64) to solid ages (INT64).
*/
WITH Data_Cleaning AS (
  SELECT
    Transaction_ID,
    Order_ID,
    Order_Date,
    Order_Time,
    Customer_ID,

    INITCAP(TRIM(MAX(Customer_Name) OVER(PARTITION BY Customer_ID))) AS Customer_Name,
    CAST(MAX(Customer_Age) OVER(PARTITION BY Customer_ID) AS INT64) AS Customer_Age,
    COALESCE(INITCAP(TRIM(MAX(Customer_Gender) OVER(PARTITION BY Customer_ID))), 'Unknown') AS Customer_Gender,
    INITCAP(TRIM(Customer_Segment)) AS Customer_Segment,

    
 /*
 2. PRODUCT CATALOG ALIGNMENT:
   - Resolves missing values in the Product_Name by applying a deterministic cross-column look-forward/look-back mechanism
     based on the product’s unique ID.
   - Standardized layout enforced across Category and Subcategory attributes.
 */

    Product_ID,
    TRIM(MAX(Product_Name) OVER(PARTITION BY Product_ID)) AS Product_Name,
    INITCAP(TRIM(Product_Category)) AS Product_Category,
    INITCAP(TRIM(Product_Subcategory)) AS Product_Subcategory,



    INITCAP(TRIM(Sales_Channel)) AS Sales_Channel,
    Quantity,
    Unit_Price,
    Discount_Percentage,
    Sales_Amount, 
    Cost_Amount,  
    Profit,
    COALESCE(INITCAP(TRIM(Payment_Method)), "Unknown") AS Payment_Method,
    INITCAP(TRIM(Sales_Representative)) AS Sales_Representative,
    INITCAP(TRIM(Order_Status)) As Order_Status

  FROM `retail.sales`
  where Order_Status != "Returned" and Order_Status != "Cancelled"
),

/*
3. REMOVE DUPLICATE:
   - Isolates unique retail transactions by evaluating transactional fields.
   - If exact duplicates exist, only the first chronological instance is retained.
*/

Remove_Duplicate AS (
  SELECT
    *,
    ROW_NUMBER() OVER(
      PARTITION BY
        Transaction_ID,
        Order_ID, 
        Customer_ID, 
        Product_ID, 
        CAST(Sales_Amount AS STRING), -- Cast strictly inside window syntax
        CAST(Cost_Amount AS STRING), 
        CAST(Profit AS STRING),      
        Sales_Representative
      ORDER BY Transaction_ID
    ) AS Row_Instance_Num
  FROM Data_Cleaning
)


SELECT
  * EXCEPT(Row_Instance_Num)
FROM Remove_Duplicate
 WHERE Row_Instance_Num = 1


