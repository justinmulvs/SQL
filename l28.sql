/* used to create a view for measuring customer engagement-- 
assigns each customer a score for # of days product was used in the last 28 */

CREATE VIEW customer_l28 AS (
select
  u.id,
  count(distinct date_trunc('day', e.collector_tstamp) AS l28
from
  atomic.users u join atomic.events e ON u.id=e.user_id
where
  date_trunc('day', e.collector_tstamp) > current_date - Interval '28 days' 
  AND u.plan_id!=1        
)        
