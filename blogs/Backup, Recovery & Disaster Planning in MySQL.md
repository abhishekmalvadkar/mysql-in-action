# 🚀 Backup, Recovery & Disaster Planning in MySQL  

A **solid backup and recovery strategy** ensures data protection against failures, corruption, accidental deletions, and cyberattacks.  

---

## 1️⃣ Types of Backups in MySQL  

| Backup Type | Description | Pros | Cons |
|-------------|------------|------|------|
| **Logical Backup** | Uses SQL `mysqldump` to export data as queries. | Easy to restore on any MySQL version. | Slow for large databases. |
| **Physical Backup** | Copies raw database files (`xtrabackup`, `cp`, `tar`). | Fast and efficient for large DBs. | Restoring on a different MySQL version may cause issues. |
| **Incremental Backup** | Captures only **changed data** since the last backup. | Saves space and speeds up backup time. | Requires **full backup first**. |
| **Binary Log Backup** | Captures all **DB transactions** in `binlog`. | Allows **point-in-time recovery**. | Needs to be combined with other backups. |

---

## 2️⃣ Logical Backups (`mysqldump`)  

```bash
mysqldump -u root -p mydatabase > mydatabase_backup.sql
mysql -u root -p mydatabase < mydatabase_backup.sql
```

---

## 3️⃣ Physical Backups (`xtrabackup`)  

```bash
xtrabackup --backup --target-dir=/backup/mysql
xtrabackup --prepare --target-dir=/backup/mysql
xtrabackup --copy-back --target-dir=/backup/mysql
```

---

## 4️⃣ Incremental Backups (`xtrabackup`)  

```bash
xtrabackup --backup --target-dir=/backup/inc1 --incremental-basedir=/backup/full
xtrabackup --prepare --apply-log-only --target-dir=/backup/inc1
```

---

## 5️⃣ Binary Log Backups (Point-in-Time Recovery)  

```ini
[mysqld]
log-bin=mysql-bin
expire_logs_days=7
```
```bash
mysqlbinlog mysql-bin.000001 | mysql -u root -p mydatabase
```

---

## 6️⃣ Disaster Recovery Planning (DRP)  

| Disaster Type | Prevention | Recovery |
|--------------|-----------|----------|
| **Hardware Failure** | RAID, Cloud Storage | Restore latest backup on new hardware |
| **Accidental Deletion** | Binary Logs, Read-Only Roles | Use binlog recovery to undo changes |
| **Corrupted Database** | Replication, Redundant Backups | Restore last working backup |
| **Ransomware Attack** | Encrypted Offsite Backups | Restore **from offline backup** |
| **Data Center Crash** | Cloud Replication | Failover to secondary DB |

---

## 7️⃣ High Availability & Failover  

```sql
CHANGE MASTER TO MASTER_HOST='192.168.1.100', MASTER_USER='replica', MASTER_PASSWORD='password';
START SLAVE;
```

---

## 8️⃣ Automating Backups  

```bash
0 2 * * * mysqldump -u root -p mydatabase > /backup/$(date +\%F)-backup.sql
```

---

## 🔥 Summary of MySQL Backup & Disaster Recovery  

| Backup Type | Best Use Case | Command |
|-------------|--------------|---------|
| **Full Backup** | Small DBs, portable | `mysqldump -u root -p --all-databases > full_backup.sql` |
| **Physical Backup** | Large DBs | `xtrabackup --backup --target-dir=/backup/mysql` |
| **Incremental Backup** | Large DBs with frequent changes | `xtrabackup --backup --incremental-basedir=/backup/full` |
| **Binary Logs** | Point-in-time recovery | `mysqlbinlog mysql-bin.000001 | mysql -u root -p mydatabase` |
| **Replication** | High Availability | `CHANGE MASTER TO MASTER_HOST='192.168.1.100'` |

🚀 **A strong backup strategy ensures fast recovery & minimal downtime!**  

---


