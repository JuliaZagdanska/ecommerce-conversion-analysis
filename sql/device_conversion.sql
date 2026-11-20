-- Compare first observed views and purchases within each user-device pair.
-- Both events must use the same device category for this breakdown.
WITH user_device_events AS (
  SELECT
    device.category AS device_type,
    user_pseudo_id,
    LOGICAL_OR(event_name = 'view_item') AS viewed_product,
    LOGICAL_OR(event_name = 'purchase') AS purchased,
    MIN(IF(event_name = 'view_item', event_timestamp, NULL)) AS first_view_ts,
    MIN(IF(event_name = 'purchase', event_timestamp, NULL)) AS first_purchase_ts
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20201130'
    AND event_name IN ('view_item', 'purchase')
    AND device.category IN ('mobile', 'desktop')
    AND user_pseudo_id IS NOT NULL
  GROUP BY device_type, user_pseudo_id
),
device_summary AS (
  SELECT
    device_type,
    COUNT(DISTINCT IF(viewed_product, user_pseudo_id, NULL)) AS product_viewers,
    COUNT(DISTINCT IF(purchased, user_pseudo_id, NULL)) AS purchasers,
    COUNT(DISTINCT IF(first_view_ts < first_purchase_ts, user_pseudo_id, NULL))
      AS viewers_who_purchased
  FROM user_device_events
  GROUP BY device_type
)
SELECT
  *,
  ROUND(100 * SAFE_DIVIDE(viewers_who_purchased, product_viewers), 2)
    AS conversion_rate_pct
FROM device_summary
ORDER BY conversion_rate_pct DESC, device_type;
