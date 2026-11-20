-- Compare the first observed view and purchase for each user within November.
WITH user_events AS (
  SELECT
    user_pseudo_id,
    LOGICAL_OR(event_name = 'view_item') AS viewed_product,
    LOGICAL_OR(event_name = 'purchase') AS purchased,
    MIN(IF(event_name = 'view_item', event_timestamp, NULL)) AS first_view_ts,
    MIN(IF(event_name = 'purchase', event_timestamp, NULL)) AS first_purchase_ts
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20201130'
    AND event_name IN ('view_item', 'purchase')
    AND user_pseudo_id IS NOT NULL
  GROUP BY user_pseudo_id
),
summary AS (
  SELECT
    COUNT(DISTINCT IF(viewed_product, user_pseudo_id, NULL)) AS product_viewers,
    COUNT(DISTINCT IF(purchased, user_pseudo_id, NULL)) AS purchasers,
    COUNT(DISTINCT IF(viewed_product AND purchased, user_pseudo_id, NULL))
      AS users_with_both_events,
    COUNT(DISTINCT IF(first_view_ts < first_purchase_ts, user_pseudo_id, NULL))
      AS viewers_who_purchased
  FROM user_events
)
SELECT
  *,
  ROUND(100 * SAFE_DIVIDE(viewers_who_purchased, product_viewers), 2)
    AS view_to_purchase_rate_pct
FROM summary;
