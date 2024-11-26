# SQL Query to Find Customers Not Referred by Customer with ID = 2

## Problem Statement

You have a `Customer` table that stores customer details, including the `id`, `name`, and the `referee_id` (the `id` of the customer who referred them). Your task is to write a query to find the names of the customers who were **not referred by** the customer with `id = 2`.

### Table: Customer

| Column Name | Type    |
|-------------|---------|
| id          | int     |
| name        | varchar |
| referee_id  | int     |

The `id` column is the primary key for this table. Each row indicates the `id` of a customer, their `name`, and the `id` of the customer who referred them. If the `referee_id` is `NULL`, it means the customer was not referred by anyone.

### Example

#### Input

Customer table:

| id  | name | referee_id |
|-----|------|------------|
| 1   | Will | NULL       |
| 2   | Jane | NULL       |
| 3   | Alex | 2          |
| 4   | Bill | NULL       |
| 5   | Zack | 1          |
| 6   | Mark | 2          |

#### Output

| name |
|------|
| Will |
| Jane |
| Bill |
| Zack |
