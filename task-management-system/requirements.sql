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

-- suppose user is on task list page
-- there is search bar, status dropdown, due date date picker
-- user didn't select any of them or select any of them in any order
-- we want to show title, first 20 chars of description and then ..., status , due date in 12 Mar, 2024 format
-- user want to see high priority task first in list
-- we will create dynamic query in JPA here you can assume commenet and uncomment part
select 
	t.title, 
	concat(trim(substring(t.description,1,20)), '....'),
	t.status ,
	date_format(t.due_date, '%d %b, %Y') 
	from tasks t
where 1=1
-- and concat(t.title, t.description, t.status, t.due_date) like '%discussion%' -- enable if user typed something in search bar
-- and t.status = 'Pending' -- enable if user selected any status from status dropdown
and t.due_date = '2024-11-09' 
order by t.due_date desc;
