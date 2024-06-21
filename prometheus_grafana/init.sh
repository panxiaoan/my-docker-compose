mkdir -p ./volumes/prometheus/data
mkdir -p ./volumes/grafana/data
mkdir -p ./volumes/grafana/provisioning

sudo chmod -R 777 ./volumes/prometheus/data
sudo chmod -R 777 ./volumes/grafana/data
sudo chmod -R 777 ./volumes/grafana/provisioning

firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd --zone=public --add-port=3000/tcp --permanent
firewall-cmd --zone=public --add-port=9100/tcp --permanent
firewall-cmd --zone=public --add-port=9080/tcp --permanent

firewall-cmd --reload

/sbin/iptables -L -n