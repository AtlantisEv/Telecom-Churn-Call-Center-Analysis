# Telecom-Churn-Call-Center-Analysis
SQL and Tableau analysis of telecom customer churn and call center performance using Google BigQuery and Tableau
## Project Overview
Analysis of telecom customer churn and call center performance 
to identify key drivers of customer loss and service quality 
using SQL in Google BigQuery and Tableau.

## Tools Used
- Google BigQuery (SQL) — data analysis and querying
- Tableau — data visualization and dashboard
- Google Sheets — data cleaning and documentation

## Data Source
Telecom Company Churn Rate & Call Center Data by datazng — Kaggle
kaggle.com/datasets/datazng/telecom-company-churn-rate-call-center-data

## Datasets
- Telecom Churn Dataset — 7,043 customer records
- Call Center Dataset — 5,000 call records

## Business Questions
### Churn Analysis
1. What is the overall churn rate and which segments churn most?
2. Does contract type predict churn?
3. At what tenure point do customers most commonly churn?

### Call Center Analysis
4. What is the overall resolution rate and which topics resolve least?
5. Is there a relationship between speed of answer and satisfaction?

### Combined Analysis
6. Do customers with more support tickets churn at higher rates?

## Key Findings
- Overall churn rate: 26.54%
- Senior citizens churn at nearly double the rate of non seniors (41.68% vs 23.61%)
- 88.6% of all churned customers were on month-to-month contracts
- 55.48% of churn occurs within first 12 months
- Overall call resolution rate: 89.94%
- Streaming calls have lowest resolution rate at 88.43%
- Speed of answer has minimal impact on satisfaction (0.04 difference)
- High ticket customers churn at 2.7x the rate of no ticket customers (54.06% vs 20.14%)

## Business Questions & Answers

### 1. What is the overall churn rate and which segments churn most?
Analysis of 7,043 customer records revealed an overall churn rate 
of 26.54%. Gender was not a significant churn predictor with female 
and male customers churning at nearly identical rates of 26.92% and 
26.16%. However senior citizens churned at nearly double 
the rate of non senior customers at 41.68% compared to 23.61% 
suggesting age and fixed income constraints may be contributing 
factors to customer loss.

### 2. Does contract type predict churn?
Contract type proved to be the strongest predictor of churn in this 
analysis. Monthly customers churned at 42.71% compared to 
11.27% for one year contracts and only 2.83% for two year contracts. 
Most 88.6% of all churned customers were on 
month to month contracts suggesting that converting customers to 
longer term contracts should be the company's primary retention 
strategy.

### 3. At what tenure point do customers most commonly churn?
Churn risk is the highest early in the customer relationship with 55.48% 
of all churned customers leaving within their first 12 months. This 
drops significantly to 25.36% for mid tenure customers of 13 to 36 
months and further to 19.15% for long term customers of 37 or more 
months. Combined with the contract type finding this suggests that 
the critical retention window is within the first 12 months when 
customers are most likely to be on month-to-month contracts and most 
susceeptible to churning.

### 4. What is the overall resolution rate and which topics resolve least?
Analysis of 4,054 answered calls revealed an overall resolution rate 
of 89.94%. All five call topics performed within a narrow range of 
88.43% to 91.43% resolution rate. Streaming calls had the lowest 
resolution rate at 88.43% followed by payment related calls at 
89.12% and contract related calls at 89.86%. Admin support and 
technical support performed above the overall average at 90.94% and 
91.43%. While overall performance is strong the 
consistent difficulty resolving streaming issues suggests a need for 
additional agent training in this area.

### 5. Is there a relationship between speed of answer and satisfaction?
Contrary to expectations speed of answer had minimal impact on 
customer satisfaction ratings. Fast calls answered within 0 to 40 
seconds averaged a satisfaction rating of 3.40 while slow calls 
taking 81 to 125 seconds averaged 3.42 a difference of only 0.02. 
The average answer speed across all calls was 67.52 seconds with all 
times falling between 10 and 125 seconds. These findings suggest 
that investing resources in faster answer times alone will not 
meaningfully improve customer satisfaction and that resolution 
quality is a more important for a positive customer experience.

### 6. Do customers with more support tickets churn at higher rates?
Customers who contacted support more frequently showed significantly 
higher churn rates confirming that unresolved support issues are a 
major driver of customer loss. Customers with no support tickets 
churned at 20.14% while those with 5 or more tickets churned at 
54.06% — nearly 2.7 times higher. Even customers with just 1 to 2 
tickets showed a churn rate of 39.54% nearly double the no ticket 
rate. These findings suggest that improving first contact resolution 
and proactively following up with high ticket customers could 
significantly reduce overall churn.

## Dashboard
[Click Here To View Tableau Dashboard](https://public.tableau.com/views/TelecomChurnCallCenterAnalysis/TelecomChurnCallCenterAnalysis?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## SQL Queries
Full SQL queries available in repository files:
- telecom_churn_queries.sql
- telecom_callcenter_queries.sql
