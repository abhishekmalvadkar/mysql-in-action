select 2+2 as total;

select curdate(), utc_date();
select curtime(), utc_time();
select now(),current_timestamp(); 
select now(), current_timestamp(), utc_timestamp();

select date_add(curdate() , interval 1 day); 
select date_add(curdate() , interval 1 month); 
select date_add(curdate() , interval 1 year); 
select date_add('2025-11-11' , interval 1 year);

select date_sub(curdate(), interval 1 day); 
select date_sub(curdate(), interval 1 month); 
select date_sub(curdate(), interval 1 year); 
select date_sub('2024-10-11', interval 1 year);

select datediff('2024-11-11', '2023-11-10'); -- 367 days 
select datediff('2024-11-11', '2024-11-12'); -- -1

select date_format(curdate(), '%d/%m/%y'); -- 11/11/24
select date_format(curdate(), '%d %M, %y'); -- 11 November, 24
select date_format(curdate(), '%d %b, %y'); -- 11 Nov, 24
select date_format(curdate(), '%d %b, %Y'); -- 11 Nov, 2024
select date_format(curdate(), '%D %M, %y'); -- 11th November, 24

set @msg_sepretor = '|';
select concat_ws(@msg_sepretor,'Hello', 'Abhi'); -- Hello|Abhi

