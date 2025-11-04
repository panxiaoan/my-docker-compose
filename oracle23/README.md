# 相关资料

- [Oracle Github](https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/README.md)
- [Oracle 官方镜像仓库](https://container-registry.oracle.com/)

**注意：Oracle 23.5 之前的版本不支持 Apple Silicon M 系列芯片**

## 容器外部连接 Oracle 23 Free Lite

**推荐使用 [DBeaver 客户端](https://dbeaver.io/)**

```bash
# DBeaver
host: localhost
port: 15210
database(Service Name): FREEPDB1
auth: oracle database native
username: system
passwd: Oracle123

# JDBC
1. 进入容器或使用 DBeaver 连接 Oracle 后创建 Schema (其实就是用户名和密码)
2. 授权


```

## Oracle x86

```json
services:
  oracle18c:
    # https://container-registry.oracle.com/
    image: container-registry.oracle.com/database/express:18.4.0-xe
    container_name: oracle18c
    hostname: oracle18c
    # network_mode: host # 设置网络模式为主机模式(端口映射无效)
    restart: no # always | no | on-failure
    privileged: false
    ports:
      - 15210:1521
      - 15211:5500
      - 15212:8080
    environment:
      # 密码规范：8个字符，至少包含1个大写字母、1个小写字母和1个数字[0-9]
      ORACLE_PWD: Oracle123
      ORACLE_CHARACTERSET: AL32UTF8
    volumes:
      - ../../my-docker-volumes/oracle18c/data:/opt/oracle/oradata
    logging:
      driver: "json-file"
      options:
        max-size: "20m"
        max-file: "3"
    networks:
      default: 
        aliases:
          - oracle18c_net
networks:
  default:
    name: docker_default_net
    external: true
```