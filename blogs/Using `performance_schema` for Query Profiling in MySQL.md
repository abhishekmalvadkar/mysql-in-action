# Using `performance_schema` for Query Profiling in MySQL

The **`performance_schema`** in MySQL helps monitor query execution, detect slow queries, and optimize performance.

✅ **Why Use `performance_schema`?**  
- Captures **query execution times** at a granular level.  
- Tracks **CPU, memory, and disk usage** per query.  
- Helps identify **slow queries and bottlenecks** in real-time.  

---

## 1️⃣ How to Enable `performance_schema`

### ✅ Step 1: Check if `performance_schema` is Enabled
```sql
SHOW VARIABLES LIKE 'performance_schema';
```
✅ **If `ON`**, it's already enabled.  
❌ **If `OFF`**, enable it.

### ✅ Step 2: Enable `performance_schema` (If Disabled)
Edit **MySQL config (`my.cnf` or `my.ini`)** and add:
```ini
[mysqld]
performance_schema=ON
```
Restart MySQL:
```bash
sudo systemctl restart mysql
```

---

## 2️⃣ Query Profiling Using `performance_schema`

### ✅ Step 1: Check Active Queries
```sql
SELECT * FROM performance_schema.events_statements_current;
```
🔹 **Key columns to check**:
- `SQL_TEXT` → The SQL query  
- `TIMER_WAIT` → Execution time in picoseconds  
- `LOCK_TIME` → Time spent waiting for locks  

---

### ✅ Step 2: Find the Slowest Queries
```sql
SELECT 
    SQL_TEXT, 
    TIMER_WAIT / 1000000000 AS time_ms
FROM performance_schema.events_statements_history
ORDER BY time_ms DESC
LIMIT 10;
```
✅ Shows **top 10 slowest queries**.

---

### ✅ Step 3: Check Table Locking Issues
```sql
SELECT 
    OBJECT_SCHEMA, OBJECT_NAME, INDEX_NAME, LOCK_TYPE, LOCK_STATUS
FROM performance_schema.data_locks;
```
✅ Detects **deadlocks and lock contention**.

---

### ✅ Step 4: Analyze Query Execution Time by User
```sql
SELECT 
    USER, 
    SUM(TIMER_WAIT) / 1000000000 AS total_time_ms 
FROM performance_schema.events_statements_summary_by_user_by_event_name
ORDER BY total_time_ms DESC;
```
✅ Identifies **inefficient queries per user**.

---

## 3️⃣ Optimizing Queries Based on Profiling

### ✅ 1. Add Indexes to Speed Up Queries
```sql
EXPLAIN SELECT * FROM orders WHERE customer_id = 123;
CREATE INDEX idx_customer_id ON orders(customer_id);
```

---

### ✅ 2. Rewrite Slow Queries
❌ Before (slow full table scan):
```sql
SELECT * FROM orders WHERE YEAR(order_date) = 2024;
```
✅ After (uses index efficiently):
```sql
SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';
```

---

### ✅ 3. Optimize Joins
❌ Before (joins on non-indexed column):
```sql
SELECT * FROM customers c JOIN orders o ON c.name = o.customer_name;
```
✅ After (uses indexed column):
```sql
ALTER TABLE orders ADD INDEX idx_customer_id (customer_id);
SELECT * FROM customers c JOIN orders o ON c.id = o.customer_id;
```

---

## 4️⃣ Summary

| Action | Query |
|--------|------|
| Check if `performance_schema` is enabled | `SHOW VARIABLES LIKE 'performance_schema';` |
| Find slowest queries | `SELECT SQL_TEXT, TIMER_WAIT FROM performance_schema.events_statements_history ORDER BY TIMER_WAIT DESC;` |
| Detect lock issues | `SELECT * FROM performance_schema.data_locks;` |
| Analyze user query execution time | `SELECT USER, SUM(TIMER_WAIT) FROM performance_schema.events_statements_summary_by_user_by_event_name;` |

🚀 **Use `performance_schema` to monitor and optimize MySQL queries for better performance!**  

---
