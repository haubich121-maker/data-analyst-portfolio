/*
==========================================================
FINTECH LOAN PERFORMANCE ANALYSIS
SQL ANALYSIS
==========================================================

Business Question:
Why did loan applications increase while total
Disbursed Value decreased?

Analytical Objectives:
1. Measure application growth
2. Evaluate credit quality
3. Analyze risk profile changes
4. Identify rejection drivers
5. Identify approved-but-not-disbursed drivers
6. Evaluate acquisition channel performance
7. Analyze marketing performance
8. Compare Q1 vs Q2 business performance

Analytical Funnel:

Marketing
    ↓
Applications
    ↓
Credit Assessment
    ↓
Approval
    ↓
Disbursement

Database:
PostgreSQL

Author:
Tran Thi Bich Hau

==========================================================
*/
/* =====================================================
1. APPLICATION VOLUME BY QUARTER
===================================================== */

SELECT
    quarter,
    COUNT(DISTINCT application_id) AS total_applications
FROM case1_finance.loan_application
GROUP BY quarter
ORDER BY quarter;
/* =====================================================
2. APPLICATION VOLUME BY ACQUISITION CHANNEL
===================================================== */

SELECT
    quarter,
    acquisition_channel,
    COUNT(DISTINCT application_id) AS applications
FROM case1_finance.loan_application
GROUP BY
    quarter,
    acquisition_channel
ORDER BY
    quarter,
    applications DESC;

/* =====================================================
3. APPLICATION VOLUME BY LOAN TYPE
===================================================== */

SELECT
    quarter,
    loan_type,
    COUNT(DISTINCT application_id) AS applications
FROM case1_finance.loan_application
GROUP BY
    quarter,
    loan_type
ORDER BY
    quarter,
    applications DESC;

/* =====================================================
4. CREDIT QUALITY BY QUARTER
===================================================== */

SELECT
    la.quarter,
    COUNT(DISTINCT la.application_id) AS applications,
    ROUND(AVG(ca.credit_score), 2) AS avg_credit_score
FROM case1_finance.loan_application la
JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id
GROUP BY la.quarter
ORDER BY la.quarter;

/* =====================================================
5. RISK BAND DISTRIBUTION BY QUARTER
===================================================== */

SELECT
    la.quarter,
    ca.risk_band,
    COUNT(DISTINCT la.application_id) AS applications,

    ROUND(
        100.0 * COUNT(DISTINCT la.application_id)
        / SUM(COUNT(DISTINCT la.application_id))
          OVER (PARTITION BY la.quarter),
        2
    ) AS risk_band_share_pct

FROM case1_finance.loan_application la

JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id

GROUP BY
    la.quarter,
    ca.risk_band

ORDER BY
    la.quarter,
    ca.risk_band;

/* =====================================================
6. REJECTION REASONS BY QUARTER
===================================================== */

SELECT
    la.quarter,
    ca.rejection_reason,
    COUNT(DISTINCT la.application_id) AS rejected_applications

FROM case1_finance.loan_application la

JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id

WHERE ca.approval_status = 'Rejected'

GROUP BY
    la.quarter,
    ca.rejection_reason

ORDER BY
    la.quarter,
    rejected_applications DESC;

/* =====================================================
7. NON-DISBURSEMENT REASONS FOR APPROVED APPLICATIONS
===================================================== */

SELECT
    la.quarter,
    ld.non_disbursement_reason,
    COUNT(DISTINCT la.application_id) AS applications

FROM case1_finance.loan_application la

JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id

JOIN case1_finance.loan_disbursement ld
    ON la.application_id = ld.application_id

WHERE ca.approval_status = 'Approved'
  AND ld.disbursed_flag = 0

GROUP BY
    la.quarter,
    ld.non_disbursement_reason

ORDER BY
    la.quarter,
    applications DESC;

/* =====================================================
8. APPLICATION FUNNEL BY QUARTER
===================================================== */

SELECT
    la.quarter,

    COUNT(DISTINCT la.application_id)
        AS applications,

    COUNT(DISTINCT CASE
        WHEN ca.approval_status = 'Approved'
        THEN la.application_id
    END) AS approved_applications,

    COUNT(DISTINCT CASE
        WHEN ld.disbursed_flag = 1
        THEN la.application_id
    END) AS disbursed_applications,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN ca.approval_status = 'Approved'
            THEN la.application_id
        END)
        / NULLIF(
            COUNT(DISTINCT la.application_id),
            0
        ),
        2
    ) AS approval_rate_pct,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN ld.disbursed_flag = 1
            THEN la.application_id
        END)
        / NULLIF(
            COUNT(DISTINCT la.application_id),
            0
        ),
        2
    ) AS application_to_disbursement_rate_pct

FROM case1_finance.loan_application la

LEFT JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id

LEFT JOIN case1_finance.loan_disbursement ld
    ON la.application_id = ld.application_id

GROUP BY la.quarter

ORDER BY la.quarter;

/* =====================================================
9. DISBURSEMENT PERFORMANCE BY QUARTER
===================================================== */

SELECT
    la.quarter,

    COUNT(DISTINCT CASE
        WHEN ld.disbursed_flag = 1
        THEN la.application_id
    END) AS disbursed_applications,

    SUM(
        CASE
            WHEN ld.disbursed_flag = 1
            THEN ld.disbursed_amount
            ELSE 0
        END
    ) AS total_disbursed_value,

    ROUND(
        AVG(
            CASE
                WHEN ld.disbursed_flag = 1
                THEN ld.disbursed_amount
            END
        ),
        0
    ) AS avg_disbursed_amount

FROM case1_finance.loan_application la

LEFT JOIN case1_finance.loan_disbursement ld
    ON la.application_id = ld.application_id

GROUP BY la.quarter

ORDER BY la.quarter;
/* =====================================================
10. ACQUISITION CHANNEL PERFORMANCE
===================================================== */

SELECT
    la.quarter,
    la.acquisition_channel,

    COUNT(DISTINCT la.application_id)
        AS applications,

    COUNT(DISTINCT CASE
        WHEN ca.approval_status = 'Approved'
        THEN la.application_id
    END) AS approved_applications,

    COUNT(DISTINCT CASE
        WHEN ld.disbursed_flag = 1
        THEN la.application_id
    END) AS disbursed_applications,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN ca.approval_status = 'Approved'
            THEN la.application_id
        END)
        / NULLIF(
            COUNT(DISTINCT la.application_id),
            0
        ),
        2
    ) AS approval_rate_pct,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN ld.disbursed_flag = 1
            THEN la.application_id
        END)
        / NULLIF(
            COUNT(DISTINCT la.application_id),
            0
        ),
        2
    ) AS application_to_disbursement_rate_pct

FROM case1_finance.loan_application la

LEFT JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id

LEFT JOIN case1_finance.loan_disbursement ld
    ON la.application_id = ld.application_id

GROUP BY
    la.quarter,
    la.acquisition_channel

ORDER BY
    la.quarter,
    applications DESC;

/* =====================================================
11. CREDIT QUALITY BY ACQUISITION CHANNEL
===================================================== */

SELECT
    la.quarter,
    la.acquisition_channel,

    COUNT(DISTINCT la.application_id)
        AS applications,

    ROUND(
        AVG(ca.credit_score),
        2
    ) AS avg_credit_score,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN ca.risk_band IN ('D', 'E')
            THEN la.application_id
        END)
        / NULLIF(
            COUNT(DISTINCT la.application_id),
            0
        ),
        2
    ) AS high_risk_share_pct,

    COUNT(DISTINCT CASE
        WHEN ca.approval_status = 'Rejected'
        THEN la.application_id
    END) AS rejected_applications

FROM case1_finance.loan_application la

JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id

GROUP BY
    la.quarter,
    la.acquisition_channel

ORDER BY
    la.quarter,
    avg_credit_score;

/* =====================================================
12. MARKETING PERFORMANCE BY CHANNEL
===================================================== */

SELECT
    quarter,
    channel,

    SUM(spend) AS total_spend,
    SUM(clicks) AS total_clicks,
    SUM(leads) AS total_leads

FROM case1_finance.marketing_performance

GROUP BY
    quarter,
    channel

ORDER BY
    quarter,
    total_spend DESC;

/* =====================================================
13. APPLICATION VOLUME VS MARKETING SPEND
===================================================== */

SELECT
    la.quarter,

    COUNT(DISTINCT la.application_id)
        AS total_applications,

    m.total_marketing_spend

FROM case1_finance.loan_application la

LEFT JOIN (

    SELECT
        quarter,
        SUM(spend) AS total_marketing_spend

    FROM case1_finance.marketing_performance

    GROUP BY quarter

) m
    ON la.quarter = m.quarter

GROUP BY
    la.quarter,
    m.total_marketing_spend

ORDER BY
    la.quarter;

/* =====================================================
14. APPLICATION QUALITY CHECK
===================================================== */

SELECT
    la.quarter,
    ca.risk_band,
    ca.rejection_reason,

    COUNT(DISTINCT la.application_id)
        AS applications

FROM case1_finance.loan_application la

JOIN case1_finance.credit_assessment ca
    ON la.application_id = ca.application_id

GROUP BY
    la.quarter,
    ca.risk_band,
    ca.rejection_reason

ORDER BY
    la.quarter,
    ca.risk_band,
    applications DESC;

/* =====================================================
15. BUSINESS ANALYSIS SUMMARY
===================================================== */

WITH quarterly_summary AS (

    SELECT
        la.quarter,

        COUNT(DISTINCT la.application_id)
            AS applications,

        COUNT(DISTINCT CASE
            WHEN ca.approval_status = 'Approved'
            THEN la.application_id
        END) AS approved_applications,

        COUNT(DISTINCT CASE
            WHEN ld.disbursed_flag = 1
            THEN la.application_id
        END) AS disbursed_applications,

        SUM(
            CASE
                WHEN ld.disbursed_flag = 1
                THEN ld.disbursed_amount
                ELSE 0
            END
        ) AS total_disbursed_value,

        AVG(
            CASE
                WHEN ld.disbursed_flag = 1
                THEN ld.disbursed_amount
            END
        ) AS avg_disbursed_amount

    FROM case1_finance.loan_application la

    LEFT JOIN case1_finance.credit_assessment ca
        ON la.application_id = ca.application_id

    LEFT JOIN case1_finance.loan_disbursement ld
        ON la.application_id = ld.application_id

    GROUP BY la.quarter
)

SELECT
    quarter,

    applications,

    approved_applications,

    disbursed_applications,

    ROUND(
        100.0 *
        approved_applications
        / NULLIF(applications, 0),
        2
    ) AS approval_rate_pct,

    ROUND(
        100.0 *
        disbursed_applications
        / NULLIF(applications, 0),
        2
    ) AS application_to_disbursement_rate_pct,

    total_disbursed_value,

    ROUND(
        avg_disbursed_amount,
        0
    ) AS avg_disbursed_amount

FROM quarterly_summary

ORDER BY quarter;

/* =====================================================
16. Q1 VS Q2 BUSINESS CHANGE
===================================================== */

WITH quarterly_summary AS (

    SELECT
        la.quarter,

        COUNT(DISTINCT la.application_id)
            AS applications,

        COUNT(DISTINCT CASE
            WHEN ca.approval_status = 'Approved'
            THEN la.application_id
        END) AS approved_applications,

        COUNT(DISTINCT CASE
            WHEN ld.disbursed_flag = 1
            THEN la.application_id
        END) AS disbursed_applications,

        SUM(
            CASE
                WHEN ld.disbursed_flag = 1
                THEN ld.disbursed_amount
                ELSE 0
            END
        ) AS total_disbursed_value,

        AVG(
            CASE
                WHEN ld.disbursed_flag = 1
                THEN ld.disbursed_amount
            END
        ) AS avg_disbursed_amount

    FROM case1_finance.loan_application la

    LEFT JOIN case1_finance.credit_assessment ca
        ON la.application_id = ca.application_id

    LEFT JOIN case1_finance.loan_disbursement ld
        ON la.application_id = ld.application_id

    GROUP BY la.quarter
),

comparison AS (

    SELECT

        MAX(
            CASE
                WHEN quarter = 'Q1'
                THEN applications
            END
        ) AS q1_applications,

        MAX(
            CASE
                WHEN quarter = 'Q2'
                THEN applications
            END
        ) AS q2_applications,

        MAX(
            CASE
                WHEN quarter = 'Q1'
                THEN approved_applications
            END
        ) AS q1_approved,

        MAX(
            CASE
                WHEN quarter = 'Q2'
                THEN approved_applications
            END
        ) AS q2_approved,

        MAX(
            CASE
                WHEN quarter = 'Q1'
                THEN disbursed_applications
            END
        ) AS q1_disbursed,

        MAX(
            CASE
                WHEN quarter = 'Q2'
                THEN disbursed_applications
            END
        ) AS q2_disbursed,

        MAX(
            CASE
                WHEN quarter = 'Q1'
                THEN total_disbursed_value
            END
        ) AS q1_disbursed_value,

        MAX(
            CASE
                WHEN quarter = 'Q2'
                THEN total_disbursed_value
            END
        ) AS q2_disbursed_value,

        MAX(
            CASE
                WHEN quarter = 'Q1'
                THEN avg_disbursed_amount
            END
        ) AS q1_avg_disbursed,

        MAX(
            CASE
                WHEN quarter = 'Q2'
                THEN avg_disbursed_amount
            END
        ) AS q2_avg_disbursed

    FROM quarterly_summary
)

SELECT

    q1_applications,
    q2_applications,

    ROUND(
        100.0 *
        (q2_applications - q1_applications)
        / NULLIF(q1_applications, 0),
        2
    ) AS application_growth_pct,

    q1_approved,
    q2_approved,

    ROUND(
        100.0 *
        (q2_approved - q1_approved)
        / NULLIF(q1_approved, 0),
        2
    ) AS approved_growth_pct,

    q1_disbursed,
    q2_disbursed,

    ROUND(
        100.0 *
        (q2_disbursed - q1_disbursed)
        / NULLIF(q1_disbursed, 0),
        2
    ) AS disbursed_application_growth_pct,

    q1_disbursed_value,
    q2_disbursed_value,

    ROUND(
        100.0 *
        (q2_disbursed_value - q1_disbursed_value)
        / NULLIF(q1_disbursed_value, 0),
        2
    ) AS disbursed_value_change_pct,

    q1_avg_disbursed,
    q2_avg_disbursed,

    ROUND(
        100.0 *
        (q2_avg_disbursed - q1_avg_disbursed)
        / NULLIF(q1_avg_disbursed, 0),
        2
    ) AS avg_disbursed_amount_change_pct

FROM comparison;

/* =====================================================
BUSINESS INTERPRETATION
=====================================================

Key Findings:

1. Application volume increased significantly from Q1
   to Q2.

2. Application growth did not translate into meaningful
   growth in disbursed applications.

3. Credit quality deteriorated, with average credit score
   declining from Q1 to Q2.

4. High-risk customers (Risk Band D/E) represented a much
   larger share of applications in Q2.

5. Rejection volume increased substantially, with low
   credit score becoming a major rejection driver.

6. Approved-but-not-disbursed applications also increased,
   indicating an additional conversion gap after approval.

7. TikTok generated the largest application volume in Q2
   but was associated with significantly lower credit quality
   and higher high-risk share than other channels.

8. Therefore, the business issue is not simply insufficient
   application volume. The key challenge is application
   quality and downstream conversion.

Business Direction:

- Improve acquisition quality
- Monitor channel-level credit quality
- Optimize targeting on high-volume channels
- Reduce approved-but-not-disbursed friction
- Monitor approval and disbursement conversion
- Balance acquisition volume with customer quality

==========================================================
END OF ANALYSIS
==========================================================
*/
