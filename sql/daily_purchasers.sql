-- Count unique purchasers per GA4 reporting date.
-- The same user can contribute on multiple dates.
SELECT
  PARSE_DATE('%Y%m%d', event_date) AS date,
  COUNT(DISTINCT user_pseudo_id) AS purchasers
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20201130'
  AND event_name = 'purchase'
  AND user_pseudo_id IS NOT NULL
GROUP BY date
ORDER BY date;
