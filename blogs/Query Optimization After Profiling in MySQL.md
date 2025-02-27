# Query Optimization After Profiling in MySQL

After **query profiling**, you may notice **slow queries, high CPU/memory consumption, or frequent table locks**. The next step is to **optimize these queries** for better performance.

✅ **Goals of Query Optimization:**  
- Reduce **query execution time**.  
- Avoid **unnecessary full table scans**.  
- Improve **index usage**.  
- Reduce **locking and deadlocks**.  
- Optimize **joins, subqueries, and sorting operations**.

---

## 1️⃣ Use `EXPLAIN` to Understand Query Execution Plan

```sql
EXPLAIN SELECT * FROM orders WHERE customer_id = 123;
```

✅ **Look for:**  
- **`type` column**: If it shows `ALL`, it’s doing a **full table scan** (bad!).  
- **`possible_keys` column**: Suggests which indexes could be used.  
- **`rows` column**: Shows how many rows MySQL needs to scan.  

---

## 2️⃣ Optimize WHERE Conditions to Use Indexes

❌ **Bad Query:**  
```sql
SELECT * FROM orders WHERE YEAR(order_date) = 2024;
```

✅ **Optimized Query:**  
```sql
SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';
```

---

## 3️⃣ Use Indexes to Speed Up Joins

❌ **Bad Query:**  
```sql
SELECT * FROM customers c JOIN orders o ON c.name = o.customer_name;
```

✅ **Optimized Query:**  
```sql
ALTER TABLE customers ADD INDEX idx_customer_id (customer_id);
SELECT * FROM customers c JOIN orders o ON c.customer_id = o.customer_id;
```

---

## 4️⃣ Avoid `SELECT *` (Only Retrieve Required Columns)

❌ **Bad Query:**  
```sql
SELECT * FROM employees WHERE department = 'IT';
```

✅ **Optimized Query:**  
```sql
SELECT employee_id, name, email FROM employees WHERE department = 'IT';
```

---

## 5️⃣ Use LIMIT to Speed Up Queries

❌ **Bad Query:**  
```sql
SELECT * FROM logs ORDER BY created_at DESC;
```

✅ **Optimized Query:**  
```sql
SELECT * FROM logs ORDER BY created_at DESC LIMIT 100;
```

---

## 6️⃣ Optimize Sorting and Grouping

❌ **Bad Query:**  
```sql
SELECT department, COUNT(*) FROM employees GROUP BY department ORDER BY COUNT(*) DESC;
```

✅ **Optimized Query:**  
```sql
CREATE INDEX idx_department ON employees(department);
SELECT department, COUNT(*) FROM employees GROUP BY department ORDER BY COUNT(*) DESC;
```

---

## 7️⃣ Optimize Subqueries with JOINs

❌ **Bad Query:**  
```sql
SELECT name FROM employees WHERE id IN (SELECT employee_id FROM salaries WHERE salary > 50000);
```

✅ **Optimized Query:**  
```sql
SELECT e.name FROM employees e JOIN salaries s ON e.id = s.employee_id WHERE s.salary > 50000;
```

---

## 8️⃣ Reduce Lock Contention

Convert `MyISAM` to `InnoDB`:
```sql
ALTER TABLE orders ENGINE=InnoDB;
```

Keep transactions **short**:
```sql
START TRANSACTION;
UPDATE inventory SET stock = stock - 1 WHERE product_id = 101;
COMMIT;
```

Batch updates:
```sql
UPDATE orders SET status = 'Shipped' WHERE status = 'Processing' LIMIT 1000;
```

---

## 9️⃣ Use Query Caching for Repeated Queries

Enable MySQL Query Cache (For older MySQL versions):
```ini
[mysqld]
query_cache_type=1
query_cache_size=64M
```

Use **Redis or Memcached** for frequent queries.

---

## 🔍 10️⃣ Summary of Query Optimization Techniques

| Optimization | Before | After |
|-------------|--------|-------|
| **Use Indexes** | `WHERE YEAR(date_column) = 2024` | `WHERE date_column BETWEEN '2024-01-01' AND '2024-12-31'` |
| **Optimize Joins** | `JOIN ON name` | `JOIN ON indexed_id` |
| **Avoid `SELECT *`** | `SELECT * FROM users` | `SELECT id, name FROM users` |
| **Use LIMIT** | `SELECT * FROM logs` | `SELECT * FROM logs LIMIT 100` |
| **Optimize Sorting** | `ORDER BY COUNT(*)` | `CREATE INDEX + ORDER BY` |
| **Use JOINs Instead of Subqueries** | `WHERE id IN (SELECT ...)` | `JOIN ON indexed columns` |
| **Shorter Transactions** | Holding locks too long | `COMMIT` faster |
| **Batch Updates** | Many small queries | `UPDATE ... LIMIT 1000` |
| **Use Caching** | Running same query multiple times | Redis or MySQL query cache |

🚀 **By applying these techniques, you can significantly improve MySQL query performance!**

---
