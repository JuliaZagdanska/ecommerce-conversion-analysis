# E-commerce Conversion Analysis

An analysis of shopping behavior at the **Google Merchandise Store** in November 2020. It uses Google's public, obfuscated GA4 sample dataset. The results describe this store and period.

[Open the Looker Studio dashboard](https://datastudio.google.com/reporting/cbaa9ff4-41ed-47cd-8f8d-b98d650fef40/page/OB2DG) · [Read the business insights](insights/business_insights.md)

## Business questions

- How many users viewed products, added items to their cart, began checkout, or purchased?
- What share of product viewers recorded a first purchase after their first product view during the month?
- How did daily purchaser counts and view-to-purchase rates vary across desktop and mobile?

## Dataset and tools

The source is `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`. The analysis uses the daily tables from **November 1–30, 2020**, inclusive. The repository includes three aggregate CSV exports used in the dashboard. [Google's sample dataset documentation](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset)

**Tools** · BigQuery (GoogleSQL) for aggregation, Python and Matplotlib for CSV validation and visualization, and Looker Studio for the dashboard.

## Methodology

1. **Shopping event activity.** Count distinct non-null `user_pseudo_id` values separately for `view_item`, `add_to_cart`, `begin_checkout`, and `purchase`. A user may appear in multiple rows.
2. **View-to-purchase rate.** For each user, take the first `event_timestamp` for `view_item` and the first for `purchase` within November. Count the user in the numerator only when the first view timestamp is strictly earlier than the first purchase timestamp. Divide by all distinct product viewers.
3. **Daily purchasers.** Count distinct purchasing users per GA4 `event_date`. A user can appear on multiple dates, so adding daily counts can overstate the monthly unique count.
4. **Conversion by device.** Apply the timestamp comparison within each user and device category pair for mobile and desktop. The denominator is the number of distinct viewers in that category. A user can contribute to both categories.

## Results

| November 2020 metric | Result |
| --- | ---: |
| Product viewers | 21,440 |
| Users who added to cart | 2,060 |
| Users who began checkout | 4,219 |
| Purchasers | 1,532 |
| Users with both a product view and a purchase | 1,524 |
| Users whose first view preceded their first purchase | 1,516 |
| View-to-purchase rate | **7.07%** |

`1,516 ÷ 21,440 × 100 = 7.07%` (rounded). The numerator uses the event-order rule and the denominator includes every November product viewer.

### Key findings

- **Event activity is measured independently.** Checkout had 4,219 users and add-to-cart had 2,060. These totals cannot establish step-to-step drop-off.
- **Device rates were close.** Mobile recorded 7.43% (638 of 8,588 viewers) and desktop 6.83% (853 of 12,497). The observed gap was 0.60 percentage points at displayed precision.
- **Ordering affects the numerator.** Of the 1,524 users with both events, 1,516 met the first-view-before-first-purchase rule.

## Dashboard

The dashboard pairs three KPI cards with shopping event activity, daily purchasers, and conversion by device. The 7.07% KPI is a fixed display of the November result. [Open the dashboard](https://datastudio.google.com/reporting/cbaa9ff4-41ed-47cd-8f8d-b98d650fef40/page/OB2DG)

![November 2020 Looker Studio report showing three KPI cards, shopping event activity, conversion by device, and daily purchasers](dashboard/dashboard.png)

## Limitations

- The view-to-purchase rate uses pseudonymous users. It does not measure conversion per session or confirm a purchase of the product that was viewed.
- The four event totals do not prove a sequential shopping funnel. The timestamp rule examines two event types and does not verify the cart or checkout steps.
- November boundaries can exclude earlier views or later purchases. Equal timestamps fail the strict ordering rule.
- Device comparisons are descriptive. Differences in traffic mix and other factors can affect the observed rates.
- Google obfuscated the sample data. Placeholder values and limited internal consistency can affect interpretation. [Dataset limitations](https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset#limitations)

## Repository structure

| Path | Contents |
| --- | --- |
| [`sql/`](sql/) | Four BigQuery queries for event activity, overall conversion, daily purchasers, and device conversion |
| [`python/ecommerce_analysis.ipynb`](python/ecommerce_analysis.ipynb) | CSV checks and a chart of distinct users by event |
| [`data/`](data/) | Aggregate exports and instructions for regenerating them |
| [`dashboard/`](dashboard/) | Live report link and full-page preview |
| [`insights/`](insights/) | Observations, hypotheses, and recommended follow-up analyses |

## How to reproduce

1. Open a Google Cloud project with BigQuery available. Run the four files in [`sql/`](sql/) using GoogleSQL. The November suffix filter limits the daily tables scanned.
2. To refresh the notebook input or dashboard exports, save the corresponding query results as CSV using the [export instructions](data/README.md). The included exports also let you run the notebook without a BigQuery account.
3. From the repository root, install the notebook tools and open the notebook.

   ```bash
   python -m pip install jupyterlab matplotlib
   python -m jupyterlab python/ecommerce_analysis.ipynb
   ```

4. Run all cells. The notebook checks the CSV schema, missing values, duplicate event labels, and count validity before drawing the chart.

All four queries were checked in BigQuery. The headline results matched the reported metrics, and the event, daily, and device outputs matched all rows in the included exports. The notebook was run with the included activity CSV.
