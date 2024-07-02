# 安装 MySQL Exporter，收集 MySQL 资源

## CentOS 7 中安装

```bash

# 新增 mysqld_exporter.cnf 配置文件
echo "[client]
user=root
password=1qazXSW@-pl,
host=localhost
port=3306
" | sudo tee /home/apps/prometheus/mysqld_exporter/mysqld_exporter.cnf

# 新增开机自动启动 mysqld_exporter 服务的配置文件
sudo tee /etc/systemd/system/mysqld_exporter.service <<EOF
[Unit]
Description=mysqld_exporter
After=network.target

[Service]
User=root
ExecStart=/home/apps/prometheus/mysqld_exporter/mysqld_exporter --config.my-cnf=/home/apps/prometheus/mysqld_exporter/mysqld_exporter.cnf
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 设置权限
sudo chmod +x /etc/systemd/system/mysqld_exporter.service

# 加载配置
systemctl daemon-reload

# 配置开机启动
systemctl enable mysqld_exporter.service
systemctl start mysqld_exporter.service
systemctl stop mysqld_exporter.service
systemctl restart mysqld_exporter.service
systemctl status mysqld_exporter.service

# 配置端口
/sbin/iptables -L -n

firewall-cmd --zone=public --add-port=9104/tcp --permanent
firewall-cmd --reload

# 验证
http://localhost:9104/metrics
```

## CentOS 6 中安装

```bash
# 在 CentOS 6 中设置 mysqld_exporter 开机自动启动

sudo vim /etc/init.d/mysqld_exporter

#!/bin/bash
# chkconfig: 345 90 10
# description: mysqld_exporter for Prometheus

DAEMON="/home/apps/prometheus/mysqld_exporter/mysqld_exporter"
ARGS="--config.my-cnf=/home/apps/prometheus/mysqld_exporter/mysqld_exporter.cnf"
PIDFILE="/var/run/mysqld_exporter.pid"

start() {
    echo "Starting mysqld_exporter..."
    nohup $DAEMON $ARGS > mysqld_exporter.log 2>&1 &
    echo $! > $PIDFILE
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch /var/lock/subsys/mysqld_exporter
    return $RETVAL
}

stop() {
    echo "Stopping mysqld_exporter..."
    PID=$(cat $PIDFILE)
    kill $PID
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f /var/lock/subsys/mysqld_exporter /var/run/mysqld_exporter.pid
    return $RETVAL
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        status $DAEMON
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0

# 设置权限和并添加开机启动服务
sudo chmod +x /etc/init.d/mysqld_exporter
sudo chkconfig --add mysqld_exporter
sudo chkconfig mysqld_exporter on

# 配置防火墙
vim /etc/sysconfig/iptables
-A INPUT -m state --state NEW -m tcp -p tcp --dport 9104 -j ACCEPT
service iptables restart

# 启动
sudo service mysqld_exporter start
sudo service mysqld_exporter stop
sudo service mysqld_exporter restart

# 验证
http://192.168.1.251:9104/metrics
```