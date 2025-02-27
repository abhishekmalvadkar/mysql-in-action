# How to Check Storage Engine to Avoid Table-Level Locking in MySQL

MySQL supports different storage engines, and **using the wrong engine can cause table-level locking issues**. To ensure **row-level locking and better concurrency**, you should use **InnoDB instead of MyISAM**.

---

## 🔍 1️⃣ How to Check Storage Engine for a Table
To check the storage engine of a specific table, run:

```sql
SHOW CREATE TABLE your_table_name;
```

Example output for an **InnoDB** table:
```sql
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```
✅ **If `ENGINE=InnoDB`, your table supports row-level locking.**  
❌ **If `ENGINE=MyISAM`, it causes table-level locking.**

---

## 🔍 2️⃣ Alternative Method: Check All Table Engines in a Database
To check storage engines for all tables in a database:

```sql
SELECT TABLE_NAME, ENGINE 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'your_database_name';
```

Example output:
| TABLE_NAME  | ENGINE  |
|------------|--------|
| orders     | InnoDB |
| customers  | MyISAM | ❌ (Bad for concurrency) |
| invoices   | InnoDB |

---

## 🔄 3️⃣ How to Convert MyISAM to InnoDB
If a table uses **MyISAM**, convert it to **InnoDB**:

```sql
ALTER TABLE your_table_name ENGINE=InnoDB;
```

Example:
```sql
ALTER TABLE orders ENGINE=InnoDB;
```

✅ **Why Convert to InnoDB?**  
- Supports **row-level locking** instead of table-level locking.  
- Allows **transactions and better concurrency**.  
- Prevents **performance issues in high-traffic systems**.  

---

## 🚀 4️⃣ Best Practices to Avoid Table-Level Locking
✔️ Always use **InnoDB** for tables with frequent inserts/updates.  
✔️ Avoid **MyISAM** unless dealing with read-heavy workloads.  
✔️ Check storage engines regularly using `information_schema.TABLES`.  
✔️ Convert old MyISAM tables to InnoDB for **better performance**.  

---
