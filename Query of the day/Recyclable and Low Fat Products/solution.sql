select 
	p.product_id 
from products p 
where 
	p.low_fats = 'Y' and
	p.recyclable = 'Y'
;

-- Learning points
-- Think about to use char if you have fixed character count values like
-- Some question answer like 'Y' or 'N'
-- Gender like 'M' or 'F' or 'O'
