-- login user support query
select * from users u
where u.email = 'sachin@gmail.com'
and u.password = 'sachin123'
and u.active = true;

-- user profile page support query
select 
	upper(u.name) as username, 
  u.email as email, 
  ifnull(u.last_login_time, '-') as last_login_time 
from users u
where u.id = 3
and u.active = true;
