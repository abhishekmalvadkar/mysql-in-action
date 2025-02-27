# 🚀 Automate Disaster Alerts & MySQL Monitoring (PMM & Zabbix)  

Monitoring **MySQL performance, failures, and security threats** is **critical** to detect problems **before they escalate**.  

✅ **Why Automate MySQL Monitoring?**  
- **Prevents unexpected downtime** by identifying slow queries, high CPU, or failing replication.  
- **Instant alerts** for disk space, CPU, memory, and query failures.  
- **Detects security threats** (brute-force attacks, unauthorized access).  
- **Helps with root cause analysis** after an outage.  

---

## 1️⃣ Monitoring MySQL with Percona Monitoring & Management (PMM)  

### 🔹 Install PMM Server  
```bash
docker run -d -p 80:80 --name pmm-server --restart always percona/pmm-server
```

### 🔹 Install PMM Client on MySQL Server  
```bash
sudo apt install pmm2-client -y
pmm-admin config --server-insecure-tls --server-url=http://admin:password@<pmm-server-ip>
pmm-admin add mysql --username=root --password=yourpassword
```

### 🔹 Set Up CPU Usage Alert  
1️⃣ Go to **PMM Dashboard → Alerts**  
2️⃣ Click **New Alert Rule**  
3️⃣ Set **Condition:** `CPU Usage > 80% for 5 minutes`  
4️⃣ Choose **Email, Slack, or PagerDuty notifications**  

✅ **Now, if MySQL CPU spikes over 80%, you get an instant alert!**  

---

## 2️⃣ Monitoring MySQL with Zabbix  

### 🔹 Install Zabbix Server & Agent  
```bash
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-agent
```

### 🔹 Configure Zabbix Agent on MySQL Server  
Edit `/etc/zabbix/zabbix_agentd.conf`:
```ini
Server=<Zabbix_Server_IP>
ListenPort=10050
```
Restart:
```bash
sudo systemctl restart zabbix-agent
```

### 🔹 Create a Low Disk Space Alert  
1️⃣ Go to **Zabbix → Configuration → Hosts**  
2️⃣ Select **MySQL Server** → Click **Triggers**  
3️⃣ Click **Create Trigger**  
4️⃣ Set **Expression:**  
```sql
{MySQL:system.disk.space.used[/,free].last()}<10G
```

---

## 3️⃣ Alert Notifications (Email, Slack, Telegram)  

### 🔹 Send Alerts to Slack  
- Get **Slack Webhook URL** from **Slack → Apps → Incoming Webhooks**.  
- Add webhook in **PMM or Zabbix notification settings**.  

✅ **Now, alerts are sent to Slack instantly!**  

---

## 🔥 Summary: Best Practices for Automated MySQL Monitoring  

| **Feature** | **PMM** | **Zabbix** |
|------------|--------|--------|
| **Slow Query Analysis** | ✅ Yes | ❌ No |
| **Replication Monitoring** | ✅ Yes | ✅ Yes |
| **CPU, Memory, Disk Alerts** | ✅ Yes | ✅ Yes |
| **Email/Slack Notifications** | ✅ Yes | ✅ Yes |
| **Best For** | Query performance & slow query detection | System-wide monitoring & alerting |

🚀 **Using PMM & Zabbix together ensures full MySQL performance & disaster recovery monitoring!**  

---
