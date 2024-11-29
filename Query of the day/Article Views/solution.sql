select 
    distinct author_id 
from views v
where v.author_id = v.viewer_id 
order by v.author_id
;
