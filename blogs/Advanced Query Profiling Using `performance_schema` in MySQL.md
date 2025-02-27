# Advanced Query Profiling Using `performance_schema` in MySQL

The **`performance_schema`** allows you to **monitor, diagnose, and optimize** query performance by analyzing execution statistics, locks, wait events, and transaction delays.

✅ **Why Use `performance_schema` for Query Profiling?**  
- Detect **slow queries** and high CPU/memory-consuming queries.  
- Identify **table locks, row locks, or deadlocks**.  
- Monitor **transaction execution time and bottlenecks**.  
- Analyze **index usage and missing indexes**.  

---

## 1️⃣ How to Check if `performance_schema` is Enabled

```sql
SHOW VARIABLES LIKE 'performance_schema';
```
✅ **If `ON`**, it’s enabled.  
❌ **If `OFF`**, enable it in `my.cnf`:
```ini
[mysqld]
performance_schema=ON
```
Restart MySQL:
```bash
sudo systemctl restart mysql
```

---

## 2️⃣ Identifying Slow Queries

```sql
SELECT 
    EVENT_ID, SQL_TEXT, TIMER_WAIT / 1000000000 AS execution_time_ms
FROM performance_schema.events_statements_history
ORDER BY execution_time_ms DESC
LIMIT 10;
```

---

## 3️⃣ Detecting Locking Issues

```sql
SELECT 
    THREAD_ID, EVENT_NAME, OBJECT_NAME, LOCK_TYPE, LOCK_STATUS
FROM performance_schema.data_locks;
```

---

## 4️⃣ Checking Transaction Bottlenecks

```sql
SELECT 
    THREAD_ID, TIMER_WAIT / 1000000000 AS execution_time_ms, SQL_TEXT 
FROM performance_schema.events_transactions_history
ORDER BY execution_time_ms DESC
LIMIT 10;
```

---

## 5️⃣ Checking Index Usage

```sql
SELECT 
    SQL_TEXT, INDEX_USED, TIMER_WAIT / 1000000000 AS execution_time_ms
FROM performance_schema.events_statements_history
WHERE INDEX_USED IS NULL OR INDEX_USED = ''
ORDER BY execution_time_ms DESC
LIMIT 10;
```

---

## 6️⃣ Detecting High CPU and Memory Queries

```sql
SELECT 
    SQL_TEXT, CPU_TIME / 1000000000 AS cpu_time_ms, MEMORY_USED 
FROM performance_schema.events_statements_history
ORDER BY cpu_time_ms DESC
LIMIT 10;
```

---

## 🚀 Summary of Key Profiling Queries

| **Issue** | **Query to Run** |
|-----------|-----------------|
| **Find slow queries** | `SELECT SQL_TEXT, TIMER_WAIT FROM performance_schema.events_statements_history ORDER BY TIMER_WAIT DESC LIMIT 10;` |
| **Check active locks** | `SELECT * FROM performance_schema.data_locks;` |
| **Find queries holding locks** | `SELECT * FROM performance_schema.data_lock_waits ORDER BY TIMER_WAIT DESC;` |
| **Find long-running transactions** | `SELECT * FROM performance_schema.events_transactions_history ORDER BY TIMER_WAIT DESC;` |
| **Find queries not using indexes** | `SELECT SQL_TEXT FROM performance_schema.events_statements_history WHERE INDEX_USED IS NULL;` |
| **Find high CPU-consuming queries** | `SELECT SQL_TEXT, CPU_TIME FROM performance_schema.events_statements_history ORDER BY CPU_TIME DESC;` |

🚀 **By using `performance_schema`, you can identify and fix locking, slow queries, long transactions, and performance bottlenecks!**  

---
