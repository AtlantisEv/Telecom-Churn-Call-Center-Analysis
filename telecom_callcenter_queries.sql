Query1:
SELECT
  COUNT(`Call Id`) AS total_answered_calls,
  COUNTIF(Resolved = TRUE) AS total_resolved,
  COUNTIF(Resolved = FALSE) AS total_unresolved,
  ROUND(COUNTIF(Resolved = TRUE) / COUNT(`Call Id`) * 100, 2) AS resolution_rate_percent
FROM
  `portfolio-project-493303.telecom_analysis.telecom_call_center`
WHERE
  Answered = TRUE
----Results:total_answered_calls: 4054, total_resolved: 3646, total_unresolved: 408, resolution_rate_percentage: 89.94----
--Insights:Strong resolution rate at 90%;408 answered calls with no resolution could be risk--

Query2:
---Resolution Rate By Topic
-- WHERE filters answered calls only
-- HAVING filters calculated resolution rate after grouping
--Initial threshold of 85%, returned no results
--Adjusted to 90%

SELECT
  Topic,
  COUNT(`Call Id`) AS total_calls,
  COUNTIF(Resolved = TRUE) AS resolved_calls,
  COUNTIF(Resolved = FALSE) AS unresolved_calls,
  ROUND(COUNTIF(Resolved = TRUE) / COUNT(`Call Id`) * 100, 2) AS resolution_rate_percent
FROM
  `portfolio-project-493303.telecom_analysis.telecom_call_center`
WHERE
  Answered = TRUE
GROUP BY
  Topic
HAVING
  resolution_rate_percent < 90
ORDER BY
  resolution_rate_percent ASC
----Results:Streaming:total_calls:847,resolved_calls:749,unresolved_calls:98,resolution_rate_percentage:88.43----
----Results:Payment related:total_calls:818,resolved_calls:729,unresolved_calls:89,resolution_rate_percentage:89.12----
----Results:Contact related:total_calls:789,resolved_calls:709,unresolved_calls_80,resolution_rate_percentage:89.86----
--Insights:Streaming calls have lower resolution rate;Overall call center performance is consistent--

Query3:
--Speed Answer vs Satisfaction Rate
--Adjusted buckets based on speeds falling between 10-125 seconds
SELECT
  CASE
    WHEN `Speed of answer in seconds` BETWEEN 0 AND 40 THEN 'Fast (0-40 sec)'
    WHEN `Speed of answer in seconds` BETWEEN 41 AND 80 THEN 'Average (41-80 sec)'
    WHEN `Speed of answer in seconds` > 80 THEN 'Slow (81-125 sec)'
    ELSE 'Unknown'
  END AS speed_category,
  COUNT(`Call Id`) AS total_calls,
  ROUND(AVG(`Satisfaction rating`), 2) AS avg_satisfaction,
  ROUND(AVG(`Speed of answer in seconds`), 2) AS avg_speed_seconds
FROM
  `portfolio-project-493303.telecom_analysis.telecom_call_center`
WHERE
  Answered = TRUE
GROUP BY
  speed_category
ORDER BY
  avg_satisfaction DESC
----Results:Slow(81-125 sec);total_calls:1575,avg_satisfaction:3.42,avg_speed_seconds:103.11----
----Results:Average(41-80 sec);total_calls:1407,avg_satisfaction:3.38,avg_speed_seconds:60.24---- 
----Results:Fast(0-40 sec);total_calls:1072,avg_satisfaction:3.4,avg_speed_seconds:24.78----
--Insights:Speed of answer has little impact on satisfaction;Focus may need to be resolution quality
----============================================================================================================
Query4: Combined Analysis
--Joining telecom_churn + telecom_callcenter
--Purpose: Does poor support determine churn
--Simple Addition used in CASE statement 
--ticket data exists in churn dataset,no JOIN needed
SELECT
  CASE
    WHEN (numAdminTickets + numTechTickets) = 0 THEN 'No Tickets (0)'
    WHEN (numAdminTickets + numTechTickets) BETWEEN 1 AND 2 THEN 'Low (1-2 tickets)'
    WHEN (numAdminTickets + numTechTickets) BETWEEN 3 AND 4 THEN 'Medium (3-4 tickets)'
    WHEN (numAdminTickets + numTechTickets) >= 5 THEN 'High (5+ tickets)'
    ELSE 'Unknown'
  END AS ticket_volume,
  COUNT(customerID) AS total_customers,
  COUNTIF(Churn = TRUE) AS churned_customers,
  ROUND(COUNTIF(Churn = TRUE) / COUNT(customerID) * 100, 2) AS churn_rate_percent
FROM
  `portfolio-project-493303.telecom_analysis.telecom_churn`
GROUP BY
  ticket_volume
ORDER BY
  churn_rate_percent DESC
----Results:High(5+tickets);total_customers:505,churned_customers:273,churn_rate_percent:54.06----
----Results:Low(1-2 tickets);total_customers:310,churned_customers:310,churn_rate_percent:39.54----
----Results:Medium(3-4 tickets);total_customs:723,churned_customers:273,churn_rate_percent:37.76----
----Results:No Tickets(0);total_customers:5031,churned_customers:1013,churn_rate_percent:20.14----
--Insights:High Ticket customers churn more than 2x as cusomers with No Tickets
--Insights:Support Quality is a significant factor of churned customers;Quicker resolve to support tickets can reduce churn
