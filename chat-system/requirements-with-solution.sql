-- -- Find all contacts for a specific user (e.g., Alice)
select 
	u.name, 
	u.phone_number 
from contacts c
join users u on u.user_id = c.contact_user_id 
where c.user_id = 1; -- Alice's user_id

-- Get all messages between two users (e.g., Alice and Bob)
select 
	u.name as sender_name,
	u2.name as recives_name,
	m.message_text as message,
	m.`timestamp` as time
from messages m
join users u on u.user_id = m.sender_id 
join users u2 on u2.user_id = m.receiver_id 
where 
	m.sender_id in (1,2) 
	and m.receiver_id in (1,2)
order by m.`timestamp` 
;

-- Get the last 10 messages sent in a group
select 
	*
from group_messages gm 
where gm.gr = 1
order by `timestamp` desc limit 10;

--  List all users in a group (e.g., Family group)
select 
	g.group_name ,
	u.name 
from group_members gm 
join users u on u.user_id = gm.user_id 
join `groups` g on g.group_id = gm.group_id 
where gm.group_id  = 1 -- Family group
;

-- Count the number of unread messages for a user (e.g., Alice)
select 
	count(1) as unread_msg_count 
from messages m 
where m.receiver_id = 1
and m.status <> 'sent'
;

-- List users who are not part of a specific group (e.g., Family group)
select 
	u.name 
from users u 
where u.user_id not in (
	select 
	gm.user_id 
from group_members gm 
where gm.group_id = 1
);

-- Get the total number of messages sent by each user
select 
	u.user_id ,
	u.name,
	count(message_id) as total_msg_sent_count
from users u
left join messages m on m.sender_id = u.user_id
group by u.user_id , u.name 
;

-- Find the most recent status update of a user (e.g., Alice)
select
	u.status 
from users u 
where u.user_id = 1 -- Alice's user_id
;

-- Get the number of messages exchanged between users on a specific day.
select 
	sender_id ,
	receiver_id, 
	count(1),
	date_format(`timestamp`, '%d-%m-%Y') as a_day
from messages m 
group by a_day, m.sender_id , m.receiver_id 
;

-- Find users who are not part of a any group
select 
	*
from users u 
where u.user_id not in 
(
	select 
		distinct gm.user_id
	from group_members gm 
);

