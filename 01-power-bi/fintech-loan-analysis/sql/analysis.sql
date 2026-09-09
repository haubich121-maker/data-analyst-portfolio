/*
=========================================================
FINTECH LOAN PERFORMANCE ANALYSIS
SQL ANALYSIS
=========================================================

Business Question:
Why did loan applications increase while
total disbursed value decreased?

Analytical Framework:
1. Application Volume
2. Acquisition Channel
3. Customer / Risk Profile
4. Rejection Reasons
5. Disbursement Performance
6. Funnel Performance

Database: PostgreSQL
=========================================================
*/


/* =====================================================
1. APPLICATION VOLUME BY PERIOD
===================================================== */

SELECT
    period,
    COUNT(*) AS total_applications
FROM case1_finance.loan_application
GROUP BY period
ORDER BY period;


/* =====================================================
2. APPLICATIONS BY ACQUISITION CHANNEL
===================================================== */

SELECT
    acquisition_channel,
    COUNT(*) AS total_applications
FROM case1_finance.loan_application
GROUP BY acquisition_channel
ORDER BY total_applications DESC;


/* =====================================================
3. APPLICATIONS BY LOAN TYPE
===================================================== */

SELECT
    loan_type,
    COUNT(*) AS total_applications
FROM case1_finance.loan_application
GROUP BY loan_type
ORDER BY total_applications DESC;


/* =====================================================
4. CUSTOMER RISK DISTRIBUTION
===================================================== */

SELECT
    risk_band,
    COUNT(*) AS total_assessments
FROM case1_finance.credit_assessment
GROUP BY risk_band
ORDER BY risk_band;


/* =====================================================
5. REJECTION REASONS
===================================================== */

SELECT
    rejection_reason,
    COUNT(*) AS rejected_applications
FROM case1_finance.credit_assessment
WHERE rejection_reason IS NOT NULL
GROUP BY rejection_reason
ORDER BY rejected_applications DESC;


/* =====================================================
6. CREDIT QUALITY BY PERIOD
===================================================== */

/*
If the source table contains credit_score,
this query can be used to monitor
average credit quality over time.
*/

SELECT
    period,
    AVG(credit_score) AS avg_credit_score
FROM case1_finance.credit_assessment
GROUP BY period
ORDER BY period;


/* =====================================================
7. AVERAGE CREDIT SCORE BY ACQUISITION CHANNEL
===================================================== */

SELECT
    acquisition_channel,
    AVG(credit_score) AS avg_credit_score
FROM case1_finance.credit_assessment
GROUP BY acquisition_channel
ORDER BY avg_credit_score DESC;


/* =====================================================
8. DISBURSED VALUE BY PERIOD
===================================================== */

/*
If the source table contains disbursed_value,
use this query to monitor disbursement performance.
*/

SELECT
    period,
    SUM(disbursed_value) AS total_disbursed_value
FROM case1_finance.loan_disbursement
GROUP BY period
ORDER BY period;


/* =====================================================
9. AVERAGE DISBURSED AMOUNT BY PERIOD
===================================================== */

SELECT
    period,
    AVG(disbursed_value) AS avg_disbursed_amount
FROM case1_finance.loan_disbursement
GROUP BY period
ORDER BY period;


/* =====================================================
10. NON-DISBURSEMENT REASONS
===================================================== */

SELECT
    non_disbursement_reason,
    COUNT(*) AS applications
FROM case1_finance.loan_disbursement
WHERE non_disbursement_reason IS NOT NULL
GROUP BY non_disbursement_reason
ORDER BY applications DESC;


/* =====================================================
11. MARKETING SPEND BY CHANNEL
===================================================== */

SELECT
    channel,
    SUM(spend) AS total_marketing_spend
FROM case1_finance.marketing_performance
GROUP BY channel
ORDER BY total_marketing_spend DESC;


/* =====================================================
12. MARKETING SPEND BY PERIOD
===================================================== */

SELECT
    period,
    SUM(spend) AS total_marketing_spend
FROM case1_finance.marketing_performance
GROUP BY period
ORDER BY period;


/* =====================================================
13. APPLICATION VOLUME VS MARKETING SPEND
===================================================== */

SELECT
    l.period,
    COUNT(*) AS total_applications,
    m.total_marketing_spend
FROM case1_finance.loan_application l
LEFT JOIN (
    SELECT
        period,
        SUM(spend) AS total_marketing_spend
    FROM case1_finance.marketing_performance
    GROUP BY period
) m
    ON l.period = m.period
GROUP BY
    l.period,
    m.total_marketing_spend
ORDER BY l.period;


/* =====================================================
14. APPLICATION QUALITY CHECK
===================================================== */

SELECT
    risk_band,
    rejection_reason,
    COUNT(*) AS applications
FROM case1_finance.credit_assessment
GROUP BY
    risk_band,
    rejection_reason
ORDER BY
    risk_band,
    applications DESC;


/* =====================================================
15. BUSINESS ANALYSIS SUMMARY
===================================================== */

/*
The analysis should be interpreted through the following
business funnel:

Marketing
    ↓
Applications
    ↓
Credit Assessment
    ↓
Approval
    ↓
Disbursement

Key questions:

1. Which channels generate the most applications?
2. Which channels generate higher-quality customers?
3. Which risk bands are increasing?
4. What are the major rejection reasons?
5. Is application growth translating into disbursement?
6. Which channels should receive more / less marketing budget?
*/
