# Business insights

Google Merchandise Store · November 2020

## Observations

1. **7.07% of product viewers met the event-order rule.** Of 21,440 viewers, 1,516 recorded a first view before their first purchase. There were 1,524 users with both events regardless of order and 1,532 purchasers overall.
2. **Checkout reached more users than add-to-cart.** There were 4,219 distinct checkout users and 2,060 distinct add-to-cart users. Each count uses its own event population, so neither figure measures drop-off from the preceding step.
3. **The mobile rate was higher in this period.** Mobile recorded 7.43% (638 of 8,588 viewers) and desktop 6.83% (853 of 12,497), a gap of 0.60 percentage points at displayed precision.

## Hypotheses to test

1. **Some users may begin checkout without a recorded add-to-cart event.** For sessions with `begin_checkout`, check how often an earlier `add_to_cart` is present within the same session. Break down unmatched checkouts by device and entry page where those fields are available.
2. **Traffic mix may explain part of the device gap.** Compare mobile and desktop within comparable acquisition segments, using the same conversion rule and showing the viewer count in each group.

## Recommendations

- Audit the checkout event sequence before designing a funnel or prioritizing a cart change.
- Report the device numerator and denominator beside each rate. Use the segment comparison to identify where more investigation would be worthwhile.
- Carry the November date window and the user-level definition with the conversion KPI whenever it is reused.
