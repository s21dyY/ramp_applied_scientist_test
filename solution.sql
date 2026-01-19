WITH daily_totals AS (
  SELECT
    DATE(transaction_time) AS transaction_date,
    SUM(transaction_amount) AS daily_total
  FROM transactions
  GROUP BY 1
),
rolling_avg AS (
  SELECT
    transaction_date,
    AVG(daily_total) OVER (
      ORDER BY transaction_date
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3_day_avg
  FROM daily_totals
)
SELECT *
FROM rolling_avg
WHERE transaction_date = '2021-01-31';
