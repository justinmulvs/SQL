CREATE VIEW segmentation AS (
select
    u.id,
    case when e.source=‘Platform’ then 1 else 0 end AS Website
    case when e.source=‘Linkedin’ then 1 else 0 end AS LinkedIn
    case when e.source=‘Gmail’ then 1 else 0 end AS Gmail

from
    atomic.users u join atomic.events e on u.id=e.user_id
    )
