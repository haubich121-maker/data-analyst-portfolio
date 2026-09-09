# SQL & Power BI Validation

## 1. Core KPI Validation

| Metric | Q1 SQL | Q2 SQL | Power BI Status |
|---|---:|---:|---|
| Applications | 100,000 | 135,000 | ✅ |
| Approved Applications | 55,000 | 59,535 | ✅ |
| Disbursed Applications | 47,848 | 47,968 | ✅ |
| Approval Rate | 55.00% | 44.10% | ✅ |
| App → Disbursement Rate | 47.85% | 35.53% | ✅ |

## 2. Credit Quality Validation

| Metric | Q1 | Q2 |
|---|---:|---:|
| Avg Credit Score | 685 | 634 |
| High Risk D/E Share | 10.50% | 34.86% |

## 3. Rejection Validation

| Metric | Q1 | Q2 |
|---|---:|---:|
| Rejected Applications | 45,000 | 75,465 |

Q2 leading rejection reason:

- Low credit score: 21,366 applications

## 4. Approved-but-Not-Disbursed

| Quarter | Applications |
|---|---:|
| Q1 | 7,152 |
| Q2 | 11,567 |

Top reasons:

1. Customer no response
2. Offer declined - limit too low
3. Offer declined - interest rate
4. E-contract not completed
5. Bank account validation failed

## 5. Channel Quality Validation

### TikTok — Q2

- Applications: 60,750
- Average Credit Score: 574.76
- High Risk D/E Share: 63.73%

## 6. Business Conclusion

Application volume increased by 35%, but disbursed
applications remained almost flat.

At the same time, approval rate declined and applicant
credit quality deteriorated significantly.

The increase in high-risk applicants and the strong
concentration of low-quality applications in TikTok
suggest that the change in acquisition mix was associated
with the deterioration in application quality.

The business challenge is therefore not simply generating
more applications, but improving application quality and
downstream conversion.

## 7. Data Quality Note

The scale of `disbursed_amount` should be validated between
Q1 and Q2 before using absolute disbursed-value changes as
a final business conclusion.
