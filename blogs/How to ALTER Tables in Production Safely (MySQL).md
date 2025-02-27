# How to ALTER Tables in Production Safely (MySQL)

Altering tables in a **production database** is risky because it can cause **downtime, locking, performance issues, or even data loss**. To safely modify tables in **MySQL**, you need to follow best practices to ensure **zero-downtime schema changes**.

---

## 🔥 Why is ALTER Risky in Production?
- **Locks the table** (blocking reads/writes).
- **Slows down queries** and affects performance.
- **Can cause downtime** if applied to a large dataset.
- **May fail due to insufficient disk space or indexing issues**.

---

## ✅ Best Practices for Safe ALTER in Production

### 1️⃣ Always Backup Before ALTER
Before making any structural change, take a backup:

```bash
mysqldump -u root -p --single-transaction mydatabase > mydatabase_backup.sql
```

This ensures you can **restore the table** if something goes wrong.

---

### 2️⃣ Use `pt-online-schema-change` (Recommended)
For large tables, use **Percona’s pt-online-schema-change** to modify tables **without locking**:

```bash
pt-online-schema-change --alter "ADD COLUMN new_col INT" --execute D=mydatabase,t=my_table
```

✅ **How It Works:**
- Creates a **shadow table** with the new schema.
- Copies data **row by row** without locking.
- Swaps the new table in **without downtime**.

📌 **Use this if ALTER would lock a big table.**

---

### 3️⃣ Use `gh-ost` for Online Schema Changes
GitHub’s `gh-ost` is an alternative tool:

```bash
gh-ost --alter="ADD COLUMN new_col INT" --database=mydatabase --table=my_table --execute
```

📌 **Best for cloud-based MySQL and replication setups**.

---

### 4️⃣ Add New Columns with `NULL` Default First
Adding a column to a large table?  
First, **add it as NULL** (non-blocking), then update values.

```sql
ALTER TABLE my_table ADD COLUMN new_col INT NULL;
UPDATE my_table SET new_col = 0 WHERE new_col IS NULL;
ALTER TABLE my_table MODIFY COLUMN new_col INT NOT NULL;
```

✅ **This prevents table locks** because setting `NOT NULL` immediately can lock large tables.

---

### 5️⃣ Dropping Columns Safely
MySQL **does not free up disk space** when dropping columns. To properly reclaim space:
1. Create a **new table without the column**.
2. Copy data using `INSERT ... SELECT`.
3. Rename the table.

```sql
CREATE TABLE my_table_new AS SELECT id, col1, col2 FROM my_table;
DROP TABLE my_table;
RENAME TABLE my_table_new TO my_table;
```

---

### 6️⃣ Modifying Indexed Columns (Risky!)
**Changing the type of an indexed column?**
- First, **create a duplicate column** with the new type.
- **Copy the data**.
- **Switch the column safely**.

```sql
ALTER TABLE my_table ADD COLUMN new_col BIGINT;
UPDATE my_table SET new_col = old_col;
ALTER TABLE my_table DROP COLUMN old_col;
RENAME COLUMN new_col TO old_col;
```

✅ **This avoids breaking queries that rely on the old column.**

---

### 7️⃣ Avoid `FOREIGN KEY` Changes in Large Tables
Foreign keys lock tables when altered.  
Instead of altering, **use soft references**:

1. Create a **new column**.
2. Fill it with foreign key values.
3. **Migrate applications** to use the new column.
4. Drop the foreign key later.

```sql
ALTER TABLE orders ADD COLUMN new_customer_id INT;
UPDATE orders SET new_customer_id = customer_id;
-- After testing, drop the old foreign key
ALTER TABLE orders DROP FOREIGN KEY fk_orders_customers;
ALTER TABLE orders DROP COLUMN customer_id;
```

📌 **Foreign keys slow down large-scale schema changes. Soft references are better for microservices.**

---

### 8️⃣ Add & Drop Indexes Without Blocking
**Creating or dropping an index** locks the table unless you use **ONLINE DDL**:

```sql
ALTER TABLE my_table ADD INDEX idx_col1 (col1), ALGORITHM=INPLACE, LOCK=NONE;
ALTER TABLE my_table DROP INDEX idx_col1, ALGORITHM=INPLACE, LOCK=NONE;
```

✅ **Ensures no downtime** while modifying indexes.

---

## 🚀 Final Checklist for ALTER in Production
✅ **Take a backup before changes**  
✅ **Use `pt-online-schema-change` or `gh-ost` for large tables**  
✅ **Modify columns in stages** (add NULL → update → make NOT NULL)  
✅ **Use `ALGORITHM=INPLACE, LOCK=NONE` for index changes**  
✅ **Drop foreign keys carefully (consider soft references)**  

---
