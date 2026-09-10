# E-commerce Funnel Analysis

## 1. Project Overview

This project analyzes e-commerce customer behavior across the conversion funnel, from product discovery to purchase.

The analysis focuses on identifying funnel drop-offs, evaluating acquisition channel performance, and understanding which customer and device segments contribute most to business performance.

> Note: This project uses a synthetic dataset created for portfolio and analytical practice purposes.

---

## 2. Business Problem

The business receives traffic from multiple acquisition channels, but traffic volume does not necessarily translate into purchases or revenue.

The key business questions are:

- Where does the largest funnel drop-off occur?
- Which acquisition channels generate the highest conversion rate?
- Which channels contribute the most orders and revenue?
- How do customer segments perform?
- Does device type significantly affect conversion?
- How does daily conversion and revenue performance fluctuate?

---

## 3. Dataset

The dataset contains four main tables:

### Customers

Customer-level information including:

- Customer ID
- Signup date
- Customer segment
- Device type
- Country

### Sessions

Website session information including:

- Session ID
- Customer ID
- Session date
- Acquisition channel
- Session datetime

### Events

Customer interaction events including:

- View product
- Add to cart
- Checkout
- Purchase

### Orders

Completed order information including:

- Order ID
- Customer ID
- Acquisition channel
- Product category
- Order value
- Payment method

---

## 4. Data Model

The main relationships are:

```text
customers
    │
    └── customer_id
            │
            ▼
        sessions
            │
            ├── session_id
            ▼
          events

        sessions
            │
            └── session_id
                    │
                    ▼
                  orders
```

---

## 5. Analytical Approach

The analysis was structured into the following areas:

1. Overall Business KPIs
2. Overall Funnel Analysis
3. Funnel by Acquisition Channel
4. Acquisition Channel Conversion
5. Revenue by Acquisition Channel
6. Customer Segment Performance
7. Device Performance
8. Daily Performance
9. Business Insights and Recommendations

SQL was used to calculate:

- Sessions
- Orders
- Revenue
- Conversion rate
- Average order value
- Funnel conversion rates
- Channel performance
- Customer segment performance
- Device performance
- Daily performance
---

## 6. Key Findings

### 6.1 Funnel Performance

The overall funnel contains:

| Funnel Stage | Sessions |
|---|---:|
| Sessions | 30,000 |
| View Product | 22,067 |
| Add to Cart | 9,029 |
| Checkout | 6,054 |
| Purchase | 4,093 |

The largest funnel drop-off occurs between **View Product → Add to Cart**, where the conversion rate is **40.92%**.

The overall Session → Purchase conversion rate is **13.64%**.

This suggests that the product consideration stage should be prioritized for further investigation.

Potential areas to investigate include:

- Product page content
- Pricing and offers
- Product information
- Call-to-action effectiveness
- Product merchandising

These are hypotheses for further investigation rather than confirmed causes.
### 6.2 Acquisition Channel Performance

| Channel | Sessions | Orders | Conversion Rate |
|---|---:|---:|---:|
| Email | 2,376 | 600 | 25.25% |
| Organic | 5,491 | 1,015 | 18.48% |
| Google Ads | 6,483 | 1,114 | 17.18% |
| Affiliate | 3,002 | 357 | 11.89% |
| Facebook Ads | 5,430 | 625 | 11.51% |
| TikTok Ads | 7,218 | 382 | 5.29% |

Email has the highest conversion rate at **25.25%**, although its traffic volume is relatively low.

Google Ads provides the strongest overall contribution, generating:

- 6,483 sessions
- 1,114 orders
- Approximately 1.237B revenue
- 17.18% conversion rate

TikTok Ads generates the highest traffic volume at **7,218 sessions**, but has the lowest conversion rate at **5.29%**.

Therefore, high traffic volume does not necessarily indicate high-quality traffic.
### 6.3 Revenue Performance

Google Ads generates the highest total revenue at approximately **1.237B**.

Other channels include:

- Organic: ~1.090B
- Facebook Ads: ~684M
- Email: ~655M
- TikTok Ads: ~444M
- Affiliate: ~420M

TikTok Ads has relatively high average order value, but its low conversion rate limits the number of completed orders and total revenue.

Therefore, TikTok should not necessarily be stopped. Instead, its traffic quality and downstream funnel performance should be investigated further.
### 6.4 Customer Segment Performance

| Segment | Sessions | Orders | Conversion Rate |
|---|---:|---:|---:|
| Returning | 8,685 | 1,218 | 14.02% |
| New | 16,793 | 2,276 | 13.55% |
| Loyal | 4,522 | 599 | 13.25% |

New customers generate the highest revenue contribution mainly because they represent the largest traffic volume.

Returning customers have the highest conversion rate, but the difference compared with New customers is relatively small.

This suggests that customer lifecycle stage is not the primary differentiator of conversion performance in this dataset.

### 6.5 Device Performance

| Device | Sessions | Orders | Conversion Rate |
|---|---:|---:|---:|
| Mobile | 18,256 | 2,483 | 13.60% |
| Desktop | 9,273 | 1,276 | 13.76% |
| Tablet | 2,471 | 334 | 13.52% |

Mobile generates the largest amount of traffic, orders and revenue.

However, conversion rates are very similar across devices, ranging from **13.52% to 13.76%**.

This suggests that device type is not a major differentiator of conversion in this dataset.
### 6.5 Device Performance

| Device | Sessions | Orders | Conversion Rate |
|---|---:|---:|---:|
| Mobile | 18,256 | 2,483 | 13.60% |
| Desktop | 9,273 | 1,276 | 13.76% |
| Tablet | 2,471 | 334 | 13.52% |

Mobile generates the largest amount of traffic, orders and revenue.

However, conversion rates are very similar across devices, ranging from **13.52% to 13.76%**.

This suggests that device type is not a major differentiator of conversion in this dataset.
### 6.6 Daily Performance

Daily traffic remains relatively stable, while conversion and revenue fluctuate.

For example:

**14 April 2026**

- Sessions: 330
- Conversion rate: 18.18%
- Revenue: ~72.8M

**13 May 2026**

- Sessions: 330
- Conversion rate: 8.48%
- Revenue: ~32.5M

Both days have the same number of sessions, but revenue performance is substantially different.

This indicates that traffic volume alone does not explain business performance.

Further investigation should consider:

- Acquisition channel mix
- Funnel performance
- Campaign activity
- Product category
- Customer mix
- Promotions
---

## 7. Business Recommendations

### 1. Improve the Product View → Add to Cart stage

The largest funnel drop-off occurs at this stage.

Further analysis should focus on:

- Product page performance
- Pricing
- Product information
- CTA effectiveness
- Product/category-level conversion

### 2. Maintain Google Ads as a key acquisition channel

Google Ads provides a strong balance between:

- Traffic
- Conversion
- Orders
- Revenue

Its performance makes it an important channel for continued monitoring and optimization.

### 3. Explore Email as an efficient channel

Email has the highest conversion rate at **25.25%** but relatively low traffic volume.

Potential next steps include investigating whether the business can scale email traffic while maintaining conversion efficiency.

### 4. Investigate TikTok traffic quality

TikTok generates the highest session volume but the lowest conversion rate.

Instead of immediately reducing investment, the next analysis should investigate:

- Campaign-level performance
- Audience quality
- Landing page performance
- Funnel drop-off
- Content-to-purchase alignment

### 5. Monitor conversion anomalies

Daily performance shows that similar traffic volumes can produce significantly different revenue outcomes.

A monitoring dashboard could be used to identify abnormal changes in:

- Conversion rate
- Orders
- Revenue
- Average order value
---

## 8. Tools

- PostgreSQL
- SQL
- DBeaver
- Excel
- GitHub
---

## 9. SQL Techniques Used

This project applies:

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- CASE WHEN
- COUNT
- COUNT DISTINCT
- SUM
- ROUND
- NULLIF
- LEFT JOIN
- Date functions
- Aggregation
- Conversion rate calculation
- Business-oriented KPI analysis
---

## 10. Project Structure

```text
ecommerce-funnel-analysis/
├── README.md
└── queries.sql
```
---

## 11. Key Takeaway

The analysis shows that increasing traffic alone does not guarantee better business performance.

The most important opportunity is to improve conversion at the product consideration stage while optimizing acquisition channels based on both traffic quality and business outcomes.

This project demonstrates how SQL can be used to move from raw transactional data to actionable business insights.
