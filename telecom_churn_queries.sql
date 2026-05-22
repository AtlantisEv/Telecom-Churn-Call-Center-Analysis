Query1:
SELECT 
  COUNT(customerID) AS total_customers
  FROM `portfolio-project-493303.telecom_analysis.telecom_churn`
----To Confirm Sheet Uploaded properly----
Query2:
SELECT 
  COUNTIF(Churn =true) AS churned_customers,
  COUNT(customerID) AS total_customers,
  COUNTIF(Churn = true) / COUNT(customerID) AS churn_rate
FROM `portfolio-project-493303.telecom_analysis.telecom_churn` 

----Results:churned_customers:1869/total_customer:7043/churn_rate:0.2653698707936(want to convert to percentage)----
Query3:
SELECT 
  COUNTIF(Churn = TRUE) AS churned_customers,
  COUNT(customerID) AS total_customers,
  ROUND(COUNTIF(Churn = TRUE) / COUNT(customerID) * 100, 2) AS churn_rate_percent
FROM 
  `portfolio-project-493303.telecom_analysis.telecom_churn`
----Results:churned_customers:1869/total_customer:7043/churn_rate:26.54(converted)----

Query4:
SELECT 
  gender,
  COUNT(customerID) AS total_customers,
  COUNTIF(Churn = TRUE) AS churned_customers,
  ROUND(COUNTIF(Churn = TRUE) / COUNT(customerID) * 100, 2) AS churn_rate_percent
FROM 
  `portfolio-project-493303.telecom_analysis.telecom_churn`
GROUP BY 
  gender
----Results: Row 1 Gender:Female,total_customers:3488,churned_customers:939,churn_rate_percent:26.92----
----Results: Row 2 Gender:Male,total_customers:3555,churned_customers:930,churn_rate_percent:26.16----
  --Insights: Gender is not a significant churn factor--

Query5:
--SeniorCitizen is stored as (0/1) Integer not Boolean 
--CASE statement to convert readable labels
-------
SELECT 
  CASE 
    WHEN SeniorCitizen = 1 THEN 'Senior'
    WHEN SeniorCitizen = 0 THEN 'Non Senior'
    ELSE 'Unknown'
  END AS senior_status,
  COUNT(customerID) AS total_customers,
  COUNTIF(Churn = TRUE) AS churned_customers,
  ROUND(COUNTIF(Churn = TRUE) / COUNT(customerID) * 100, 2) AS churn_rate_percent
FROM 
  `portfolio-project-493303.telecom_analysis.telecom_churn`
GROUP BY 
  SeniorCitizen            
----Results:Non Senior,total_customers:5901,churned_customers:1393,churn_rate_percent:23.61----
----Results:Senior,total_customers:1142,churned_customers:476,churn_rate_percent:41.68----
--Insights: Senior Churn rate is almost double to non senior rate(could be strong churn predictor)--

Query6:
--Churn rate by contract type
--ORDER BY added to sort churn rate highest to lowest
--Identify if and which contract type predicts churn
SELECT 
  Contract,
  COUNT(customerID) AS total_customers,
  COUNTIF(Churn = TRUE) AS churned_customers,
  ROUND(COUNTIF(Churn = TRUE) / COUNT(customerID) * 100, 2) AS churn_rate_percent
FROM 
  `portfolio-project-493303.telecom_analysis.telecom_churn`
GROUP BY 
  Contract
ORDER BY 
  churn_rate_percent DESC
----Results:Month-to-month, total_customer: 3875, churned_customers: 1655, churn_rate_percent:42.71----
----Results:One Year,total_customers: 1473,churned_customers: 166,churn_rate_percent: 11.27----
----Results:Two Year,total_customers: 1695,churned_customers: 48,,churn_rate_percent: 2.83----
--Insights:Contract type is a strong churn predictor;Pushing for more long term contacts may be affective--


Query6:
--Churn By Tenure Group
--WHERE clause to filter only churned customers before grouping
--CASE statement creates tenure buckets 
--OVER() window function calculates percentage of total churn
--ORDER BY churned_customers DESC 
SELECT
  CASE
    WHEN tenure BETWEEN 0 AND 12 THEN 'Early (0-12 months)'
    WHEN tenure BETWEEN 13 AND 36 THEN 'Mid (13-36 months)'
    WHEN tenure > 36 THEN 'Long Term (37+ months)'
    ELSE 'Unknown'
  END AS tenure_group,
  COUNT(customerID) AS churned_customers,
  ROUND(COUNT(customerID) / SUM(COUNT(customerID)) OVER() * 100, 2) AS pct_of_total_churn
FROM
  `portfolio-project-493303.telecom_analysis.telecom_churn`
WHERE
  Churn = TRUE
GROUP BY
  tenure_group
ORDER BY
  churned_customers DESC
----Results:tenure_group: Early 0-12 months, churned_customers: 1037, pct_of_total_churn:55.48----
----Results:tenure_group: Mid 13-36 months, churned_customers: 474, pct_of_total_churn:25.36----
----Results:tenure_group: Long Term 37+ months, churned_customers: 358, pct_of_total_churn:19.15----
--Insight: Over half of churn occurs within the Early tenure

 