# Fintech Loan Performance Analysis

## Project Overview

This project analyzes loan application, approval and disbursement performance for a fintech business.

The business experienced a significant increase in loan applications following marketing expansion. However, total disbursed value declined.

The objective of this project is to identify the key drivers behind this performance gap and provide actionable business recommendations.

---

## Business Problem

> Why did loan applications increase while total disbursed value decreased?

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

The analysis then investigates:

**Customer Mix → Risk Profile → Credit Score → Rejection Reasons**

---

## Dashboard

The Power BI dashboard contains five analytical pages:

### 1. Executive Summary

Provides an overview of business performance and the main performance gap.

[View Dashboard](./dashboard/)

### 2. Storytelling

Follows the analytical journey from application volume to customer quality, risk and rejection reasons.

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

Analyzes customer characteristics, credit quality, risk bands and rejection reasons.

---

## Key Findings

### Finding 1 — Application volume increased

Loan applications increased significantly following marketing expansion.

However, application growth did not translate proportionally into disbursed value.

### Finding 2 — Credit quality weakened

Average credit score decreased from approximately 685 to 634.

This indicates a deterioration in the quality of newly acquired applicants.

### Finding 3 — Higher-risk segments affected approval performance

Higher-risk customer segments showed weaker approval performance.

### Finding 4 — Rejection reasons reveal application-quality issues

Key rejection reasons include:

- Low Credit Score
- High Debt-to-Income
- Income Not Verified
- Incomplete Profile
- Policy Rule Hit

---

## Root Cause

The performance gap can be summarized as:

**Application Growth**

↓

**Weaker Customer Quality**

↓

**Higher Risk / Lower Credit Quality**

↓

**Lower Approval Conversion**

↓

**Lower Disbursement**

Therefore:

> **More Applications ≠ More Disbursement**

---

## Business Recommendations

### 1. Shift from volume-based to quality-based acquisition

Evaluate acquisition performance using:

- Application Volume
- Approval Rate
- Disbursement Rate
- Disbursed Value

### 2. Review high-risk acquisition sources

Identify channels and campaigns with:

- High Risk C–E share
- Low Approval Rate
- Low Disbursement Rate
- High rejection rate

### 3. Improve application quality

Focus on:

- Income verification
- Profile completeness
- Credit-quality screening
- Debt-to-income assessment

### 4. Optimize marketing budget

Prioritize channels that generate successful downstream outcomes rather than only high application volume.

---

## KPI Framework

| Business Area | KPI |
|---|---|
| Acquisition | Applications |
| Credit Quality | Average Credit Score |
| Risk | Risk Band |
| Approval | Approval Rate |
| Conversion | Disbursement Rate |
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
└── dashboard-file/
    ├── README.md
    └── 1607_CS1_Tran_Hau.pbix
