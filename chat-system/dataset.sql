create schema chat_system_db;

use chat_system_db;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100),
    profile_picture VARCHAR(255),
    status VARCHAR(255),
    last_seen DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    contact_user_id INT,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (contact_user_id) REFERENCES Users(user_id),
    UNIQUE(user_id, contact_user_id)  -- Ensuring no duplicate contacts
);


CREATE TABLE Messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message_text TEXT,
    message_type ENUM('text', 'image', 'video', 'audio') NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('sent', 'delivered', 'read') DEFAULT 'sent',
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);


CREATE TABLE Groups (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(255) NOT NULL,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

CREATE TABLE Group_Members (
    group_member_id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT,
    user_id INT,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    UNIQUE(group_id, user_id)  -- Ensuring each user is only a member once
);

CREATE TABLE Group_Messages (
    group_message_id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT,
    sender_id INT,
    message_text TEXT,
    message_type ENUM('text', 'image', 'video', 'audio') NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (sender_id) REFERENCES Users(user_id)
);

-- Inserting users
INSERT INTO Users (name, phone_number, email, profile_picture, status)
VALUES ('Alice', '1234567890', 'alice@example.com', 'alice.jpg', 'Hey there!'),
       ('Bob', '0987654321', 'bob@example.com', 'bob.jpg', 'Busy right now'),
       ('Charlie', '1122334455', 'charlie@example.com', 'charlie.jpg', 'Available');

-- Inserting contacts
INSERT INTO Contacts (user_id, contact_user_id)
VALUES (1, 2), (1, 3), (2, 3);

-- Inserting messages
INSERT INTO Messages (sender_id, receiver_id, message_text, message_type)
VALUES (1, 2, 'Hello Bob!', 'text'),
       (2, 1, 'Hey Alice, how are you?', 'text'),
       (1, 2, 'I am good, thanks!', 'text');

-- Inserting groups
INSERT INTO Groups (group_name, created_by)
VALUES ('Family', 1), ('Friends', 2);

-- Inserting group members
INSERT INTO Group_Members (group_id, user_id)
VALUES (1, 1), (1, 2), (2, 2), (2, 3);

-- Inserting group messages
INSERT INTO Group_Messages (group_id, sender_id, message_text, message_type)
VALUES (1, 1, 'Hello everyone!', 'text'),
       (2, 2, 'Hey friends, what’s up?', 'text');

select * from users;
select * from contacts c ;
select * from messages m ;
select * from `groups` g ;
select * from group_members gm ;
select * from group_messages gm ;
