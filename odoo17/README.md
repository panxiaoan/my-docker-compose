
# Odoo ERP

## 安装说明

1. 首次使用，则执行 `init.sh` 完成相关目录初始化
2. 

## 常见错误

- 容器启动时，出现数据库初始化错误
> Database odoo not initialized, you can force it with `-i base`

```
# 进入容器命令行，执行初始化数据库命令
odoo -i base -d odoo17 --stop-after-init
```

## 参考资料
- Docker 官方镜像：https://github.com/docker-library/docs/tree/master/odoo
- Odoo 镜像构建脚本: https://github.com/odoo/docker/blob/5b67879040592cb5d37969d0309f49355ece7d05/README.md