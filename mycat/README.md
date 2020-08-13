
# 运行前注意事项
- 先执行 init.sh 初始化挂载目录
- 在挂载目录 volumes/conf 目录中，增加如下三个配置文件：
  - server.xml, 是 Mycat 服务器参数调整和用户授权的配置文件
  - rule.xml, 是分片规则的配置文件
  - schema.xml, 是逻辑库定义和表以及分片定义的配置文件
  - 以上配置请先学习官方文档：https://github.com/MyCATApache/Mycat-Server