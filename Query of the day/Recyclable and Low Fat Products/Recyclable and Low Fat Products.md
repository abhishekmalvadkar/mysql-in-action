### Problem Statement

#### Table: `Products`

| Column Name | Type    |
|-------------|---------|
| product_id  | int     |
| low_fats    | char(1) |
| recyclable  | char(1) |

- `product_id` is the primary key (column with unique values) for this table.
- `low_fats` is a `CHAR(1)` where `'Y'` means this product is low fat and `'N'` means it is not.
- `recyclable` is a `CHAR(1)` where `'Y'` means this product is recyclable and `'N'` means it is not.

---

### Goal

Write a solution to find the IDs of products that are **both low fat and recyclable**.

Return the result table in any order.

---

### Example 1

#### Input: 
**Products table:**

| product_id  | low_fats | recyclable |
|-------------|----------|------------|
| 0           | Y        | N          |
| 1           | Y        | Y          |
| 2           | N        | Y          |
| 3           | Y        | Y          |
| 4           | N        | N          |

#### Output:
**Result table:**

| product_id  |
|-------------|
| 1           |
| 3           |

#### Explanation:
Only products `1` and `3` are both low fat and recyclable.
