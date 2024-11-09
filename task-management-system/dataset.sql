-- create tms schema
create schema tms;

-- use tms schema
use tms;

-- create users table
create table users
(
    id bigint auto_increment primary key,
    name varchar(50) not null,
    email varchar(100) not null,
    password varchar(255) not null,
    active bit(1) not null default 1,
    last_login_time datetime null
);

-- create task table
create table tasks
(
	id bigint auto_increment primary key,
    title varchar(255) not null,
    description varchar(300) null,
    status varchar(20) not null default 'Pending',
    due_date date not null,
    created_by bigint not null,
    created_on datetime not null,
    updated_by bigint not null,
    updated_on datetime not null,
    foreign key(created_by) references users(id)
);

-- insert data in users table
insert into users(name, email, password) values
(1, 'Sachin Tendulkar', 'sachin@gmail.com', 'sachin123'),
(2, 'Rahul Dravid', 'rahul@gmail.com', 'rahul123'),
(3, 'Mahendra Singh Dhoni', 'dhoni@gmail.com', 'dhoni123'),
(4, 'Virat Kholi', 'virat@gmail.com', 'virat123');

-- insert data in tasks table
insert into tasks(title, description,due_date, status, created_by, created_on, updated_by, updated_on) values
('Daily meeting', 'Need to attend daily meetting on time', curdate(), 'Pending',1, utc_timestamp(), 1, utc_timestamp()),
('Play football', 'Need to play football for practice', curdate(), 'Completed',1, utc_timestamp(), 1, utc_timestamp()),
('Morning workout', 'Need to completed morning workout without fail', curdate(), 'Pending',2, utc_timestamp(), 2, utc_timestamp()),
('Motivate team', 'Need to motivate team', curdate(), 'Completed',2, utc_timestamp(), 2, utc_timestamp()),
('Team discussion', 'Need to discuss with team on plan', curdate(), 'Pending',3, utc_timestamp(), 3, utc_timestamp()),
('Play Table tenis', 'Need to play table tenis', curdate(), 'Pending',3, utc_timestamp(), 3, utc_timestamp()),
('Need to travle for T20', 'Need to travle for match', curdate(), 'Completed',3, utc_timestamp(), 3, utc_timestamp());

-- check tables with data
select * from users;
select * from tasks;


