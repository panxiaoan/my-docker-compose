# 安装 node exporter，收集服务器资源

## CentOS 7 中安装

```bash
# 官网 下载 node exporter

# 解压
tar xvfz node_exporter-1.8.1.linux-amd64.tar.gz

# 重命名目录
mv node_exporter-1.8.1.linux-amd64 node_exporter

# 设置权限
sudo chmod +x node_exporter

# 新增开机自动启动 node_exporter 服务的配置文件
vim /etc/systemd/system/node_exporter.service

[Unit]
Description=node_exporter
After=network.target

[Service]
ExecStart=/home/apps/prometheus/node_exporter/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target

# 设置权限
sudo chmod +x /etc/systemd/system/node_exporter.service

# 加载配置
systemctl daemon-reload

# 配置开机启动
systemctl enable node_exporter.service
systemctl restart node_exporter.service
systemctl status node_exporter.service

# 配置端口
/sbin/iptables -L -n

firewall-cmd --zone=public --add-port=9100/tcp --permanent
firewall-cmd --reload

# 检查服务是否正常启动
http://192.168.1.250:9100/metrics
```

## CentOS 6 中安装

```bash
# 在 CentOS 6 中设置 node_exporter 开机自动启动

sudo vim /etc/init.d/node_exporter

#!/bin/bash
# chkconfig: 2345 90 10
# description: Node Exporter for Prometheus

DAEMON="/home/apps/prometheus/node_exporter/node_exporter"
PIDFILE="/var/run/node_exporter.pid"
ARGS=""

start() {
    echo "Starting Node Exporter..."
    nohup $DAEMON > node_exporter.log 2>&1 &
    echo $! > $PIDFILE
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch /var/lock/subsys/node_exporter
    return $RETVAL
}

stop() {
    echo "Stopping Node Exporter..."
    PID=$(cat $PIDFILE)
    kill $PID
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/node_exporter /var/run/node_exporter.pid
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
sudo chmod +x /etc/init.d/node_exporter
sudo chkconfig --add node_exporter
sudo chkconfig node_exporter on

# 启动
sudo service node_exporter start
sudo service node_exporter stop
sudo service node_exporter restart

# 配置防火墙
vim /etc/sysconfig/iptables
-A INPUT -m state --state NEW -m tcp -p tcp --dport 9100 -j ACCEPT

# 重启防火墙
service iptables restart

# 检查服务是否正常启动
http://192.168.1.251:9100/metrics

```