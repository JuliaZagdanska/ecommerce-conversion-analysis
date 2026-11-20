# Aggregate data exports

These files contain aggregate results from the public GA4 Google Merchandise Store sample for November 2020. They contain no event-level records or user identifiers.

| File | Source query | Grain |
| --- | --- | --- |
| `funnel_events_nov2020.csv` | [`event_exploration.sql`](../sql/event_exploration.sql) | One row per shopping event type |
| `daily_purchases_nov2020.csv` | [`daily_purchasers.sql`](../sql/daily_purchasers.sql) | One row per GA4 reporting date with purchase activity |
| `device_conversion_nov2020.csv` | [`device_conversion.sql`](../sql/device_conversion.sql) | One row per device category (mobile and desktop) |

The event activity file keeps its original export name. Its rows are independent counts of distinct users by event. The notebook displays them in the order view, add to cart, begin checkout, and purchase.

## Export from BigQuery

1. Open each source query in BigQuery Studio and run it using GoogleSQL.
2. Open **Results**, choose **Save results**, and download a local CSV with column headers.
3. Save the file in this directory with the exact name in the table. Keep `event_name,users` as the header for the notebook input.
4. Run [`view_to_purchase.sql`](../sql/view_to_purchase.sql) for the one-row headline metrics. Compare that result with the main README.

Publish only the aggregate exports from the public sample. Use a local directory outside the repository for raw events and account files. [BigQuery export documentation](https://cloud.google.com/bigquery/docs/export-file)
