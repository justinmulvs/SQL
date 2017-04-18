/* spinning up a view for different locations to segment on for user behavior, etc. */

CREATE VIEW segmentation AS (
select
    u.id,
    case when e.source=‘Platform’ then 1 else 0 end AS Website,
    case when e.source=‘Linkedin’ then 1 else 0 end AS LinkedIn,
    case when e.source=‘Gmail’ then 1 else 0 end AS Gmail

from
    atomic.users u join atomic.events e on u.id=e.user_id

group by 1
    );

/* selecting high-velocity orgs in the last week to empower sales to reach out when the time is right */
   
select
    o.company_name,
    count(u.id)
from
    users u join organizations o on u.org_id=o.id
where
    u.created_at > current_date - interval ’1 week'
group by 1
order by 2 desc
;
