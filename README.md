# Docker Common Images

Java 工程师常用镜像的 Dockerfile，方便快速搭建开发环境

# 镜像构建列表
- MySQL 8.0.21
  - MySQL Desktop GUI：Navicat for MySQ
- Redis 6.0.6
  - Reids Desktop GUI: https://tableplus.com
- Influxdb 1.8, 时序数据库
- Grafana 7.1.3, 美观、强大的可视化监控指标展示工具

# 国内常用镜像加速服务

```shell
cat << EOF >> /etc/docker/daemon.json
{
  "debug": true,
  "experimental": true,
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://mirror.ccs.tencentyun.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://reg-mirror.qiniu.com",
    "https://dockerhub.azk8s.cn"
  ]
}
EOF
```

1. 使用 docker info 命令，查看是否配置成功
2. macOS 在 Docker 控制面板中配置