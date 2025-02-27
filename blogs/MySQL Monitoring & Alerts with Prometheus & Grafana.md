# 🚀 MySQL Monitoring & Alerts with Prometheus & Grafana  

Monitor MySQL performance in **real-time** using **Prometheus & Grafana** with automated alerts.  

✅ **Why Use Prometheus & Grafana for MySQL Monitoring?**  
- **Collects real-time MySQL metrics** (CPU, queries, replication lag).  
- **Visual dashboards** for monitoring MySQL health.  
- **Set up alerts** via Slack, Telegram, Email.  

---

## 1️⃣ Install & Configure Prometheus  

```bash
wget https://github.com/prometheus/prometheus/releases/latest/download/prometheus-linux-amd64.tar.gz
tar -xvf prometheus-linux-amd64.tar.gz
cd prometheus-linux-amd64
```

Edit `prometheus.yml`:
```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'mysql'
    static_configs:
      - targets: ['localhost:9104']
```

Start Prometheus:
```bash
./prometheus --config.file=prometheus.yml
```

---

## 2️⃣ Install & Configure MySQL Exporter  

```bash
wget https://github.com/prometheus/mysqld_exporter/releases/latest/download/mysqld_exporter-linux-amd64.tar.gz
tar -xvf mysqld_exporter-linux-amd64.tar.gz
cd mysqld_exporter-linux-amd64
```

Create a MySQL user for monitoring:
```sql
CREATE USER 'exporter'@'localhost' IDENTIFIED BY 'password';
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'localhost';
FLUSH PRIVILEGES;
```

Start MySQL Exporter:
```bash
./mysqld_exporter --config.my-cnf=.my.cnf
```

---

## 3️⃣ Install & Configure Grafana  

```bash
sudo apt update && sudo apt install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

Go to **http://localhost:3000**, add **Prometheus as a Data Source** and set URL to:  
```plaintext
http://localhost:9090
```

Import **Dashboard ID: `7362`** to visualize MySQL metrics.  

---

## 4️⃣ Set Up Alerts for MySQL Failures  

### **CPU Usage Alert (>80%)**  
1️⃣ Go to **Grafana → Alerting → New Alert Rule**  
2️⃣ Query: `mysqld_exporter_cpu_usage`  
3️⃣ Condition: **WHEN avg() OF query() IS ABOVE 80**  
4️⃣ Add Slack or Email Notification  

### **Replication Lag Alert (>10s)**  
```yaml
- alert: "MySQL Replication Lag"
  expr: mysqld_exporter_replication_lag > 10
  for: 2m
  labels:
    severity: warning
  annotations:
    summary: "Replication lag detected"
```

---

## 5️⃣ Send Alerts via Slack, Telegram, Email  

### **Slack Notification**  
1️⃣ Go to **Slack → Apps → Incoming Webhooks**  
2️⃣ Get **Webhook URL**  
3️⃣ Add to **Grafana Alerting → Notification Channels**  

### **Telegram Notification**  
1️⃣ Create a **Telegram Bot** via `@BotFather`  
2️⃣ Get **Bot Token & Chat ID**  
3️⃣ Add Telegram API in Grafana  

✅ **Now, alerts will be sent to Slack/Telegram!**  

---

## 🔥 Summary: MySQL Monitoring & Alerts with Prometheus & Grafana  

| **Feature** | **Prometheus + Grafana** | **PMM** | **Zabbix** |
|------------|------------------|--------|--------|
| **Query Performance Monitoring** | ✅ Yes | ✅ Yes | ❌ No |
| **CPU, Memory, Disk Alerts** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Replication Monitoring** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Slow Query Analysis** | ✅ Yes | ✅ Yes | ❌ No |
| **Alerting (Slack, Email, Telegram)** | ✅ Yes | ✅ Yes | ✅ Yes |
| **Best For** | **Real-time monitoring & dashboards** | Query analysis & replication | **Full system-wide monitoring** |

🚀 **Prometheus + Grafana is the best choice for real-time MySQL performance monitoring & flexible alerting!**  

---
