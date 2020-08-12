
# influxdb 1.8 官方文档
https://docs.influxdata.com/influxdb/v1.8/introduction/install/

- 详细配置文件：https://www.cnblogs.com/guyeshanrenshiwoshifu/p/9188368.html
- Influxdb API：https://docs.influxdata.com/influxdb/v1.8/guides/write_data/
- JMeter + InfluxDB + Grafana: 
  - https://blog.csdn.net/zuozewei/article/details/82911173
  - https://www.cnblogs.com/yjlch1016/p/12232722.html
  - https://www.cnblogs.com/yyhh/p/5990228.html

```bash

# 运行
./run.sh

# 生成默认的配置文件到挂载的目录
docker run --rm influxdb:1.8 influxd config > ./volumes/conf/influxdb.conf

# 重启

# 通过 API 测试
curl -i -XPOST 'http://localhost:9161/write?db=jmeterdb' --data-binary 'weather,altitude=1000,area=北 temperature=11,humidity=-4'

```

docker exec -it influxdb bash

./usr/bin/influx