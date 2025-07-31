# 普隆米修斯 Prometheus 简介

![架构](../asserts/prometheus.png)

Prometheus 是由 SoundCloud 开发的开源监控报警系统和时序列数据库(TSDB)。

- 官网：https://prometheus.io
- Prometheus 使用 Go 语言开发，是 Google BorgMon 监控系统的开源版本。
- 2016 年由 Google 发起 Linux 基金会旗下的原生云基金会(Cloud Native Computing Foundation), 将 Prometheus 纳入其下第二大开源项目。
- Prometheus 和 Heapster(Heapster 是 K8S 的一个子项目，用于获取集群的性能数据。)相比功能更完善、更全面。Prometheus 性能也足够支撑上万台规模的集群。

# Prometheus 的特点

- 多维度数据模型。
- 灵活的查询语言。
- 不依赖分布式存储，单个服务器节点是自主的。
- 通过基于 HTTP 的 pull 方式采集时序数据。
- 可以通过中间网关进行时序列数据推送。
- 通过服务发现或者静态配置来发现目标服务对象。
- 支持多种多样的图表和界面展示，比如 Grafana 等。

# 基本原理

- Prometheus 的基本原理是通过 HTTP 协议周期性抓取被监控组件的状态
- 任意组件只要提供对应的 HTTP 接口就可以接入监控。不需要任何 SDK 或者其他的集成过程。这样做非常适合做虚拟化环境监控系统，比如 VM、Docker、Kubernetes 等。
- 输出被监控组件信息的 HTTP 接口被叫做 exporter。
- 目前互联网公司常用的组件大部分都有 exporter 可以直接使用，比如 Varnish、Haproxy、Nginx、MySQL、Linux 系统信息(包括磁盘、内存、CPU、网络等等)。

# 服务过程

- Prometheus Daemon 负责定时去目标上抓取 metrics (指标)数据，每个抓取目标需要暴露一个 http 服务的接口给它定时抓取。
- Prometheus 支持通过配置文件、文本文件、Zookeeper、Consul、DNS SRV Lookup 等方式指定抓取目标。
- Prometheus 采用 PULL 的方式进行监控，即服务器可以直接通过目标 PULL 数据或者间接地通过中间网关来 Push 数据。
- Prometheus 在本地存储抓取的所有数据，并通过一定规则进行清理和整理数据，并把得到的结果存储到新的时间序列中。
- Prometheus 通过 PromQL 和其他 API 可视化地展示收集的数据。Prometheus 支持很多方式的图表可视化，例如 Grafana、自带的 P romdash 以及自身提供的模版引擎等等。
- Prometheus 还提供 HTTP API 的查询方式，自定义所需要的输出。
- PushGateway 支持 Client 主动推送 metrics 到 PushGateway，而 Prometheus 只是定时去 Gateway 上抓取数据。
- Alertmanager 是独立于 Prometheus 的一个组件，可以支持 Prometheus 的查询语句，提供十分灵活的报警方式。

# 主要模块

Server，Exporters，Pushgateway，PromQL，Alertmanager，WebUI等，主要逻辑如下：

- Prometheus server 定期从静态配置的 targets 或者服务发现的 targets 拉取数据。
- 当新拉取的数据大于配置内存缓存区时，Prometheus 会将数据持久化到磁盘（如果使用 remote storage 将持久化到云端）。
- Prometheus 配置 rules，然后定时查询数据，当条件触发时，会将 alert 推送到配置的 Alertmanager。
- Alertmanager 收到警告时，会根据配置，聚合、去重、降噪等操作，最后发送警告。
- 可以使用 API，Prometheus Console 或者 Grafana 查询和聚合数据。

# Grafana

官方 Dashboard：https://grafana.com/grafana/dashboards

## 常用 Dashbord

- 服务器：https://grafana.com/grafana/dashboards/16098-node-exporter-dashboard-20240520-job/
- Springboot：https://grafana.com/grafana/dashboards/12900-springboot-apm-dashboard/
- MySQL: https://grafana.com/grafana/dashboards/17320-1-mysqld-exporter-dashboard/
- Docker: https://grafana.com/grafana/dashboards/193-docker-monitoring/

# Spring Boot 2.6 加入 Prometheus 监控

## 引入对应的 Starter

```xml
    <!-- Prometheus 监控 -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    <!-- https://mvnrepository.com/artifact/io.micrometer/micrometer-registry-prometheus -->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-registry-prometheus</artifactId>
        <version>1.6.13</version>
    </dependency>
```

### 配置 yml 配置文件
```yml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  metrics:
    export:
      prometheus:
        enabled: true
    tags:
      application: ${spring.application.name}
```

### 配置 prometheus.yml
```yml
  ######################## Spring Boot App #############################
  - job_name: 'wms-app'
    static_configs:
      - targets: ['192.168.1.253:8086']
    metrics_path: '/wms/actuator/prometheus'

  - job_name: 'wms-ga-app'
    static_configs:
      - targets: ['192.168.1.253:8085']
    metrics_path: '/wmsga/actuator/prometheus'

  - job_name: 'wms-med-app'
    static_configs:
      - targets: ['192.168.1.253:8088']
    metrics_path: '/wmsmed/actuator/prometheus'

  - job_name: 'wes-app'
    static_configs:
      - targets: ['192.168.1.253:8010']
    metrics_path: '/wes/actuator/prometheus'

  - job_name: 'wcs-app'
    static_configs:
      - targets: ['192.168.1.253:8089']
    metrics_path: '/wcs/actuator/prometheus'

  - job_name: 'les-app'
    static_configs:
      - targets: ['192.168.1.253:8087']
    metrics_path: '/les/actuator/prometheus'

  - job_name: 'pfep-app'
    static_configs:
      - targets: ['192.168.1.253:8084']
    metrics_path: '/pfep/actuator/prometheus'
```

# Nginx 配置

```nginx
location /grafana/ {
    proxy_pass http://192.168.1.253:3000/grafana;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    #proxy_cookie_path / /grafana/;
    #rewrite ^/grafana/(.*)$ /$1 break;
}
```

## CentOS 6 中配置 mysqld_exporter 随机自动启动

- 创建 mysqld_exporter 服务脚本:`vim /etc/init.d/mysqld_exporter`

```bash
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
```

- 授权：`chmod +x /etc/init.d/mysqld_exporter`
- 添加服务到 chkconfig: `chkconfig --add mysqld_exporter`
- 设置开机自动启动：`chkconfig mysqld_exporter on`
- 启动服务：`service mysqld_exporter start | stop | restart`
- 检查服务状态：`service mysqld_exporter status`