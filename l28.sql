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
);

/* creates a distribution for customer engagement over the last 28 days using the view */
  
select
  l28,
  count(id)
from
  customer_l28
group by 1
order by 1;
  
/* you can then use this to benchmark team accounts for customer success */
select
    t.name,
    count(case when l.l28>=10 then u.id end)/count(u.id)*100 AS perc_safe
    count(case when l.l28=0 then u.id end)/count(u.id)*100 AS perc_dead
from
    atomic.users u join customer_l28 l on u.id=l.id 
    join atomic.teams t on t.id=u.team_id
group by 1
order by 3 desc;
