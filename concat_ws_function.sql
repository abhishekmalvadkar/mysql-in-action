The CONCAT_WS function in MySQL allows you to concatenate strings with a specified separator between them. 
It skips NULL values, making it useful for joining fields that may contain NULLs.

Syntax
CONCAT_WS(separator, str1, str2, ...)

separator: The string to use as a separator (e.g., a comma, space, or hyphen).
str1, str2, ...: The strings to concatenate.

Example Usage
  
Example 1: Simple Concatenation with Separator
Suppose we have a table called users:

sql
CREATE TABLE users (
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO users (first_name, middle_name, last_name) VALUES
('John', 'Michael', 'Doe'),
('Jane', NULL, 'Smith');

Query:

sql
SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS full_name
FROM users;

Result:

+----------------+
| full_name      |
+----------------+
| John Michael Doe |
| Jane Smith     |
+----------------+
In this example:

The space (' ') is used as a separator.
NULL values are skipped, so "Jane" and "Smith" are concatenated without a space for middle_name.
  
