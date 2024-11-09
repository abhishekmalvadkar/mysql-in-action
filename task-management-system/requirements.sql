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
	t.id,
	t.title, 
	concat(trim(substring(t.description,1,20)), '....') as description,
	t.status ,
	date_format(t.due_date, '%d %b, %Y') as due_date
	from tasks t
where 1=1
-- and concat(t.title, t.description, t.status, t.due_date) like '%discussion%' -- enable if user typed something in search bar
-- and t.status = 'Pending' -- enable if user selected any status from status dropdown
and t.due_date = '2024-11-09' 
order by t.due_date desc
-- limit 0,2 -- skip 1st 0 row means page 1 with 2 per page
-- limit 2,2 -- skip 1st 2 row means page 2 with 2 per page
-- limit 4,2 -- skip 1st 4 row means page 3 with 2 per page
limit 6,2 -- skip 1st 6 row means page 4 with 2 per page
;

-- On My Report page, as a user I shuold able to see pending task count and completed task count
-- input : user id
-- Approach 1 but output should have pending_count and completed_count as column
select 
	status , 
	count(1) 
from tasks t 
where t.created_by = 3
group by status ;

-- Approach 2 
select 
	ifnull(sum(if(t.status = 'Pending', 1, 0)), 0) as pendingCount,
	ifnull(sum(if(t.status = 'Completed', 1, 0)), 0) as completedCount
from tasks t 
where t.created_by = 3;

-- As a admin, i should able to see user level pending count, completed count and total task count along with user name
select 
	u.name as userName,
	count(1) as totalCount,
	ifnull(sum(if(t.status = 'Pending', 1, 0)), 0) as pendingCount,
	ifnull(sum(if(t.status = 'Completed', 1, 0)), 0) as completedCount
from tasks t
join users u on u.id = t.created_by
group by u.name
order by u.name asc;

-- if you want append Task suffix from backend itself then
-- As a admin, i should able to see user level pending count, completed count and total task count along with user name
select 
	u.name as userName,
	concat(count(1), ' ' , 'Tasks') as totalCount,
	concat(ifnull(sum(if(t.status = 'Pending', 1, 0)), 0), ' ' , 'Tasks') as pendingCount,
	concat(ifnull(sum(if(t.status = 'Completed', 1, 0)), 0), ' ', 'Tasks') as completedCount
from tasks t
join users u on u.id = t.created_by
group by u.name
order by u.name asc;

-- As a UI developer, I will require unique number with each row so I can use them when check box will be select from table first row
select 
	row_number() over (order by u.name) as id,
	u.name as userName,
	count(1) as totalCount,
	ifnull(sum(if(t.status = 'Pending', 1, 0)), 0) as pendingCount,
	ifnull(sum(if(t.status = 'Completed', 1, 0)), 0) as completedCount
from tasks t
join users u on u.id = t.created_by
group by u.name
;






