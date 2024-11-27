select 
	w.name,
	w.population,
	w.area
from world w
where w.population >= 25000000
or w.area >= 3000000
;

-- Learning point
-- When someone tell "at least" then take >= in your query
