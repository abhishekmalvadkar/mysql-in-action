select 
	c.name
from customer c
where c.referee_id <> 2
or c.referee_id is null
;

/*
  Learning points

  If you use only the condition WHERE referee_id != 2, the query will exclude customers referred by 
  customer id = 2, but it will not include customers who have a NULL value in the referee_id column 
  (i.e., customers who were not referred by anyone).

  The query will exclude customers like Bill who have NULL in the referee_id column. 
  These customers were not referred by anyone, but they will not be returned in the 
  result because NULL is not treated as != 2 in SQL.

  To include customers who were not referred by anyone (i.e., referee_id IS NULL), you should use the above query:
/*
