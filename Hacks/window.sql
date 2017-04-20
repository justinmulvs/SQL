/* Window function for determining max or minimum values for attributes partitioned by users */

select *
from (
    select 
        s.member_id, 
        s.member_type, 
        m.company_id, 
        rank() over (partition by s.member_id order by s.effective_date desc)
    from 
        member_states s join members m ON s.member_id=m.id
) segment
where segment.rank=1
