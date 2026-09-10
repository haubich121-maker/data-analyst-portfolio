-- ============================================================
-- E-COMMERCE FUNNEL ANALYSIS
-- PostgreSQL
-- Dataset: Synthetic / Simulated
-- ============================================================


-- ============================================================
-- 01. OVERALL BUSINESS KPIs
-- Business Question:
-- What is the overall business performance?
-- ============================================================
SELECT
    COUNT(DISTINCT s.session_id) AS total_sessions,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS total_revenue,

    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS session_to_purchase_pct,

    ROUND(
        SUM(o.order_value)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value

FROM ecommerceanalysis.sessions s

LEFT JOIN ecommerceanalysis.orders o
    ON s.session_id = o.order_session_id;
    
    
 -- ============================================================
-- 02. OVERALL FUNNEL ANALYSIS
-- Business Question:
-- Where do users drop off in the conversion funnel?
-- ============================================================

SELECT
    COUNT(DISTINCT s.session_id) AS total_sessions,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'view_product'
        THEN e.session_id
    END) AS view_product,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'add_to_cart'
        THEN e.session_id
    END) AS add_to_cart,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'checkout'
        THEN e.session_id
    END) AS checkout,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'purchase'
        THEN e.session_id
    END) AS purchase,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN e.event_type = 'view_product'
            THEN e.session_id
        END)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS session_to_view_pct,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN e.event_type = 'add_to_cart'
            THEN e.session_id
        END)::NUMERIC
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN e.event_type = 'view_product'
                THEN e.session_id
            END),
            0
        ) * 100,
        2
    ) AS view_to_cart_pct,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN e.event_type = 'checkout'
            THEN e.session_id
        END)::NUMERIC
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN e.event_type = 'add_to_cart'
                THEN e.session_id
            END),
            0
        ) * 100,
        2
    ) AS cart_to_checkout_pct,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN e.event_type = 'purchase'
            THEN e.session_id
        END)::NUMERIC
        / NULLIF(
            COUNT(DISTINCT CASE
                WHEN e.event_type = 'checkout'
                THEN e.session_id
            END),
            0
        ) * 100,
        2
    ) AS checkout_to_purchase_pct

FROM ecommerceanalysis.sessions s

LEFT JOIN ecommerceanalysis.events e
    ON s.session_id = e.session_id;

    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS session_to_purchase_pct,

    ROUND(
        SUM(o.order_value)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value

FROM ecommerceanalysis.sessions s

LEFT JOIN ecommerceanalysis.orders o
    ON s.session_id = o.order_session_id;



-- ============================================================
-- 03. FUNNEL BY ACQUISITION CHANNEL
-- Business Question:
-- How does funnel performance differ across channels?
-- ============================================================

SELECT
    s.acquisition_channel,

    COUNT(DISTINCT s.session_id) AS sessions,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'view_product'
        THEN e.session_id
    END) AS view_product,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'add_to_cart'
        THEN e.session_id
    END) AS add_to_cart,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'checkout'
        THEN e.session_id
    END) AS checkout,

    COUNT(DISTINCT CASE
        WHEN e.event_type = 'purchase'
        THEN e.session_id
    END) AS purchase

FROM ecommerceanalysis.sessions s

LEFT JOIN ecommerceanalysis.events e
    ON s.session_id = e.session_id

GROUP BY s.acquisition_channel

ORDER BY sessions DESC;

-- ============================================================
-- 04. ACQUISITION CHANNEL CONVERSION
-- Business Question:
-- Which acquisition channels have the strongest conversion?
-- ============================================================

SELECT
    s.acquisition_channel,

    COUNT(DISTINCT s.session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS conversion_rate_pct

FROM ecommerceanalysis.sessions s

LEFT JOIN ecommerceanalysis.orders o
    ON s.session_id = o.order_session_id

GROUP BY s.acquisition_channel

ORDER BY conversion_rate_pct DESC;

-- ============================================================
-- 05. REVENUE BY ACQUISITION CHANNEL
-- Business Question:
-- Which acquisition channels generate the most revenue?
-- ============================================================

SELECT
    s.acquisition_channel,

    COUNT(DISTINCT s.session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS total_revenue,

    ROUND(
        SUM(o.order_value)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value,

    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS conversion_rate_pct

FROM ecommerceanalysis.sessions s

LEFT JOIN ecommerceanalysis.orders o
    ON s.session_id = o.order_session_id

GROUP BY s.acquisition_channel

ORDER BY total_revenue DESC;


-- ============================================================
-- 06. CUSTOMER SEGMENT PERFORMANCE
-- Business Question:
-- How does conversion performance differ across customer segments?
-- ============================================================

SELECT
    c.customer_segment,

    COUNT(DISTINCT s.session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS total_revenue,

    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS conversion_rate_pct

FROM ecommerceanalysis.customers c

JOIN ecommerceanalysis.sessions s
    ON c.customer_id = s.customer_id

LEFT JOIN ecommerceanalysis.orders o
    ON s.session_id = o.order_session_id

GROUP BY c.customer_segment

ORDER BY conversion_rate_pct DESC;


-- ============================================================
-- 07. DEVICE PERFORMANCE
-- Business Question:
-- How does performance differ across devices?
-- ============================================================

SELECT
    c.device_type,

    COUNT(DISTINCT s.session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS total_revenue,

    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS conversion_rate_pct

FROM ecommerceanalysis.customers c

JOIN ecommerceanalysis.sessions s
    ON c.customer_id = s.customer_id

LEFT JOIN ecommerceanalysis.orders o
    ON s.session_id = o.order_session_id

GROUP BY c.device_type

ORDER BY sessions DESC;

-- ============================================================
-- 08. DAILY PERFORMANCE
-- Business Question:
-- How does business performance change over time?
-- ============================================================

SELECT
    s.session_date,

    COUNT(DISTINCT s.session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    ROUND(
        SUM(o.order_value),
        2
    ) AS revenue,

    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / COUNT(DISTINCT s.session_id) * 100,
        2
    ) AS conversion_rate_pct,

    ROUND(
        SUM(o.order_value)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value

FROM ecommerceanalysis.sessions s

LEFT JOIN ecommerceanalysis.orders o
    ON s.session_id = o.order_session_id

GROUP BY s.session_date

ORDER BY s.session_date;

-- ============================================================
-- 09. BUSINESS INSIGHTS SUMMARY
-- ============================================================

/*

KEY FINDINGS

1. Funnel
The largest funnel drop-off occurs between View Product
and Add to Cart, with a 40.92% conversion rate.

2. Acquisition
TikTok Ads generated the highest traffic volume but had
the lowest conversion rate at 5.29%.

3. Revenue
Google Ads generated the highest revenue at approximately
1.237B and the highest number of orders at 1,114.

4. Email
Email achieved the highest conversion rate at 25.25%
despite having relatively lower traffic volume.

5. Customer Segment
Conversion rates were relatively consistent across
customer segments, ranging from 13.25% to 14.02%.

6. Device
Conversion rates were relatively consistent across devices,
while Mobile generated the highest business volume.

7. Daily Performance
Conversion and revenue varied significantly even when
traffic volume was similar.


BUSINESS RECOMMENDATIONS

1. Investigate the View Product → Add to Cart stage.

2. Investigate TikTok traffic quality and downstream
   funnel performance.

3. Explore opportunities to scale high-converting
   Email / CRM traffic.

4. Maintain a strong mobile experience because Mobile
   generates the largest business volume.

5. Monitor daily conversion and revenue anomalies.

*/