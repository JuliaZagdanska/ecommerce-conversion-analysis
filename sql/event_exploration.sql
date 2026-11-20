-- Count distinct pseudonymous users for each event independently.
SELECT
  event_name,
  COUNT(DISTINCT user_pseudo_id) AS users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20201130'
  AND event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
  AND user_pseudo_id IS NOT NULL
GROUP BY event_name
ORDER BY CASE event_name
  WHEN 'view_item' THEN 1
  WHEN 'add_to_cart' THEN 2
  WHEN 'begin_checkout' THEN 3
  WHEN 'purchase' THEN 4
END;
