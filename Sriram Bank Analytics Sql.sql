-- Create Database
CREATE DATABASE bank_analytics;

SELECT * FROM finance1;
SELECT * FROM finance_2;

-- Joining two tables.
SELECT * FROM finance1
JOIN finance_2 
ON finance1.id = finance_2.id;

-- KPI1 Total Loan Applicants
SELECT count(id) 
AS Total_Loan_Applicants
FROM finance1;

-- KPI2 Total Loan amount
SELECT CONCAT('$' ,(round(sum(loan_amnt)/1000000)) , 'M')
AS Total_loan_amount 
FROM finance1;

-- KPI3 Total Funded ampount
SELECT CONCAT('$' ,(round(sum(funded_amnt)/1000000)) , 'M')
AS Total_Funded_amount 
FROM finance1;

-- KPI4 Average Intrest rate
SELECT CONCAT(round(avg(int_rate),2),'%')
AS Average_Intrest_rate
FROM finance1;

-- KPI5 Grade and subgrade wise revolve balance
SELECT grade, sub_grade, concat('$',round(sum(revol_bal)/1000000),'M') AS Total_Revolve_balance
from finance1 
join finance_2 
ON finance1.id = finance_2.id
GROUP BY grade, sub_grade
ORDER BY grade, sub_grade desc;

-- KPI6 month wise state wise loan status
SELECT last_pymnt_d AS month_wise,addr_state AS State_wise,loan_status
FROM finance1 
JOIN finance_2
ON finance1.id = finance_2.id
group by month_wise, state_wise, loan_status order by month_wise desc;


-- KPI7 total payment for verified status and non verified status
SELECT verification_status, concat( '$' ,round(sum(total_pymnt)/1000000), 'M')
AS total_payment
FROM finance1 
JOIN finance_2
ON finance1.id = finance_2.id
GROUP BY verification_status LIMIT 2;

-- KPI8 home ownership vs last payment date stats
SELECT home_ownership, last_pymnt_d, COUNT(home_ownership)
FROM finance1 
JOIN finance_2
ON finance1.id = finance_2.id
group by home_ownership;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'only_full_group_by','')); 
SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

-- KPI9 year wise loan amount
SELECT year(issue_d) AS Year_wise, concat('$', round(sum(loan_amnt)/1000000), 'M') AS Total_Loan_amount
FROM finance1
GROUP BY year(issue_d) ;




