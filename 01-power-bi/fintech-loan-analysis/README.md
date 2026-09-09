# Fintech Loan Performance Analysis

## Project Overview

This project analyzes loan application, approval, and disbursement performance for a fintech business.

The business experienced significant growth in loan applications following marketing expansion. However, this growth did not translate proportionally into disbursement performance.

The objective of this project is to identify the key drivers behind this performance gap and provide actionable business recommendations.

---

## Business Problem

> Why did loan applications increase while disbursement performance deteriorated?

The analysis investigates the problem through:

- Application volume
- Customer quality
- Credit score
- Risk profile
- Rejection reasons
- Funnel conversion
- Acquisition channels
- Disbursement performance

---

## Business Objectives

1. Understand application growth.
2. Evaluate customer and credit quality.
3. Identify major rejection drivers.
4. Analyze the loan conversion funnel.
5. Evaluate acquisition channel performance.
6. Identify opportunities to improve disbursement performance.

---

## Tools

- PostgreSQL
- SQL
- Power BI
- DAX
- Power Query
- Excel

---

## Analytical Approach

The analysis follows the business journey:

**Marketing**

↓

**Loan Applications**

↓

**Credit Assessment**

↓

**Approval**

↓

**Disbursement**

The analysis then investigates the underlying drivers:

**Customer Mix → Credit Quality → Risk Profile → Rejection Reasons → Funnel Conversion**

---

## Dashboard

The Power BI dashboard contains seven analytical pages:

### 1. Executive Summary

Provides an overview of business performance and highlights the main performance gap.

### 2. Storytelling

Follows the analytical journey from application growth to customer quality, risk, rejection, and disbursement performance.

### 3. KPI Analysis

Monitors core performance indicators such as:

- Applications
- Approval Rate
- Disbursement Rate
- Average Disbursed Amount
- Disbursed Value

### 4. Funnel Analysis

Analyzes the conversion journey from application to approval and disbursement.

### 5. Customer & Risk Analysis

Analyzes customer characteristics, credit quality, risk bands, and rejection reasons.

### 6. Acquisition Channel Analysis

Evaluates application volume, credit quality, risk profile, and conversion performance across acquisition channels.

### 7. Business Insights

Summarizes key findings, root causes, and business recommendations.

[View Dashboard](./dashboard/)

---

## Key Findings

### Finding 1 — Application volume increased significantly

Loan applications increased from **100K in Q1 to 135K in Q2**, representing approximately **35% growth**.

However, disbursed applications remained almost flat, indicating that application growth did not translate proportionally into successful downstream outcomes.

### Finding 2 — Credit quality deteriorated

Average credit score decreased from approximately **685 in Q1 to 634 in Q2**.

This indicates a deterioration in the quality of newly acquired applicants.

### Finding 3 — High-risk customer mix increased significantly

The share of high-risk customers (Risk Band D–E) increased from approximately **10.5% in Q1 to 34.9% in Q2**.

This substantial shift in customer risk profile was associated with weaker approval performance.

### Finding 4 — Rejection volume increased

The rejection rate increased from approximately **45% in Q1 to 55.9% in Q2**.

Major rejection drivers included:

- Low Credit Score
- High Debt-to-Income
- Income Not Verified
- Incomplete Profile
- Policy Rule Hit

### Finding 5 — Approved applications were increasingly lost before disbursement

Approved-but-not-disbursed applications increased from approximately **7.2K in Q1 to 11.6K in Q2**.

Key reasons included:

- Customer no response
- Offer declined - limit too low
- Offer declined - interest rate
- E-contract not completed
- Bank account validation failed

This indicates that the business challenge exists not only at the approval stage but also in downstream conversion.

### Finding 6 — TikTok generated high volume but lower-quality applicants

In Q2, TikTok generated the largest application volume but was associated with:

- Lower average credit score
- Higher Risk Band D–E share
- Lower approval rate
- Lower application-to-disbursement conversion

This suggests that acquisition performance should be evaluated based on downstream business outcomes rather than application volume alone.

---

## Root Cause

The performance gap can be summarized as:

**Marketing Expansion**

↓

**Higher Application Volume**

↓

**Weaker Applicant Quality**

↓

**Higher Risk / Lower Credit Quality**

↓

**Higher Rejection Rate**

↓

**Lower Approval Conversion**

↓

**Higher Approved-but-Not-Disbursed**

↓

**Weaker Disbursement Outcome**

Therefore:

> **More Applications ≠ More Disbursement**

The analysis suggests that the key business issue is not insufficient acquisition volume, but the **quality of acquired applicants and downstream funnel conversion**.

---

## Business Recommendations

### 1. Shift from volume-based to quality-based acquisition

Evaluate acquisition performance using:

- Application Volume
- Approval Rate
- Disbursement Rate
- Disbursed Value
- Applicant Credit Quality

### 2. Review high-risk acquisition sources

Identify channels and campaigns with:

- High Risk D–E share
- Low Approval Rate
- Low Disbursement Rate
- High Rejection Rate

### 3. Improve application quality

Focus on:

- Income verification
- Profile completeness
- Credit-quality screening
- Debt-to-income assessment

### 4. Reduce post-approval friction

Investigate:

- Customer follow-up
- Loan offer competitiveness
- E-contract completion
- Bank account validation

### 5. Optimize marketing budget

Prioritize channels that generate successful downstream outcomes rather than only high application volume.

---

## KPI Framework

| Business Area | KPI |
|---|---|
| Acquisition | Applications |
| Credit Quality | Average Credit Score |
| Risk | Risk Band D–E Share |
| Approval | Approval Rate |
| Conversion | Application-to-Disbursement Rate |
| Business Outcome | Disbursed Value |
| Efficiency | Average Disbursed Amount |

---

## Project Structure

```text
fintech-loan-analysis/
│
├── README.md
│
├── dashboard/
│   ├── README.md
│   ├── executive-summary.png
│   ├── storytelling.png
│   ├── kpi.png
│   ├── funnel.png
│   ├── customer-risk-01.png
│   └── customer-risk-02.png
│
├── insights/
│   └── business-insights.md
│
├── sql/
│   └── analysis.sql
│
├── validation/
│   └── validation-checklist.md
│
└── dashboard-file/
    ├── README.md
    └── 1607_CS1_Tran_Hau.pbix
