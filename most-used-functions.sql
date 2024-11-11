
1. String Functions

1.1 CONCAT
Joins multiple strings together.

sql
SELECT CONCAT('Hello', ' ', 'World') AS greeting;
 -- Output: "Hello World"


1.2 LENGTH
Returns the length of a string in bytes.

sql
SELECT LENGTH('Hello') AS length;
 -- Output: 5

1.3 SUBSTRING
Extracts a substring from a given string.

sql
SELECT SUBSTRING('Hello World', 1, 5) AS substring;
 -- Output: "Hello"

1.4 REPLACE
Replaces occurrences of a substring with another substring.

sql
SELECT REPLACE('Hello World', 'World', 'Mysql') AS replaced_text;
 -- Output: "Hello Mysql"


2. Numeric Functions
2.1 ROUND
Rounds a number to a specified number of decimal places.

sql
SELECT ROUND(123.456, 2) AS rounded_number;
 -- Output: 123.46


2.2 CEIL and FLOOR
CEIL rounds up, while FLOOR rounds down to the nearest integer.

sql
SELECT CEIL(123.45) AS ceiling, FLOOR(123.45) AS floor_value;
 -- Output: ceiling = 124, floor_value = 123


2.3 MOD
Returns the remainder of a division.

sql
SELECT MOD(10, 3) AS remainder;
 -- Output: 1

3. Date and Time Functions
  
3.1 CURDATE and NOW
CURDATE returns the current date, while NOW returns the current date and time.

sql
SELECT CURDATE() AS current_date, NOW() AS current_datetime;
 -- Output: current_date = '2024-11-11', current_datetime = '2024-11-11 10:30:00'

3.2 DATE_ADD
Adds a specific interval to a date.

sql
SELECT DATE_ADD('2024-11-11', INTERVAL 7 DAY) AS next_week;
 -- Output: '2024-11-18'

3.3 DATEDIFF
Calculates the difference in days between two dates.

sql
SELECT DATEDIFF('2024-12-01', '2024-11-01') AS days_diff;
 -- Output: 30

3.4 EXTRACT
Extracts part of a date, like the year, month, or day.

sql
SELECT EXTRACT(YEAR FROM '2024-11-11') AS year;
 -- Output: 2024

4. Aggregate Functions
  
4.1 COUNT
Counts the number of rows that match a condition.

sql
SELECT COUNT(*) AS total_employees FROM employees;
4.2 SUM
Calculates the total sum of a numeric column.

sql
SELECT SUM(salary) AS total_salary FROM employees;

4.3 AVG
Calculates the average value of a numeric column.

sql
SELECT AVG(salary) AS average_salary FROM employees;

4.4 MAX and MIN
Retrieves the maximum or minimum value from a column.

sql
SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary FROM employees;

5. Control Flow Functions
5.1 IF
Returns different results based on a condition.

sql
SELECT IF(salary > 80000, 'High', 'Low') AS salary_status FROM employees;

5.2 CASE
Allows multiple conditions, similar to an IF-ELSE structure.

sql
SELECT 
    name,
    CASE 
        WHEN salary > 90000 THEN 'Very High'
        WHEN salary > 80000 THEN 'High'
        ELSE 'Average'
    END AS salary_bracket
FROM employees;

6. JSON Functions
6.1 JSON_EXTRACT
Retrieves a specific part of a JSON document.

sql
SELECT JSON_EXTRACT(attributes, '$.specs.ram') AS ram FROM products;
6.2 JSON_CONTAINS
Checks if a JSON document contains a specified value.

sql
SELECT JSON_CONTAINS(attributes, '"Dell"', '$.brand') AS is_dell FROM products;

7. Encryption and Hashing Functions
  
7.1 MD5
Generates a hash based on the MD5 algorithm.

sql
SELECT MD5('password') AS hashed_password;
7.2 SHA1
Creates a hash using the SHA-1 algorithm.

sql
SELECT SHA1('password') AS hashed_password;
8. Utility Functions
8.1 COALESCE
Returns the first non-null value in a list of arguments.

sql
SELECT COALESCE(NULL, NULL, 'Fallback') AS result;
 -- Output: "Fallback"
8.2 IFNULL
Returns a specified value if the expression is NULL.

sql
SELECT IFNULL(salary, 0) AS salary FROM employees;

These functions can be combined to create complex queries that are efficient and insightful. Let me know if you would like examples tailored to specific datasets!
