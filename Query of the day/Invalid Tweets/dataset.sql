-- DDL: Create the Tweets table
CREATE TABLE Tweets (
    tweet_id INT PRIMARY KEY,
    content VARCHAR(255) NOT NULL
);

-- DML: Insert example data into the Tweets table
INSERT INTO Tweets (tweet_id, content)
VALUES
    (1, 'Let us Code'),
    (2, 'More than fifteen chars are here!');
