mkdir -p ./volumes/prometheus/data
mkdir -p ./volumes/grafana/data
mkdir -p ./volumes/grafana/provisioning

firewall-cmd --zone=public --add-port=9090/tcp --permanent
firewall-cmd --zone=public --add-port=3000/tcp --permanent
firewall-cmd --zone=public --add-port=9100/tcp --permanent
firewall-cmd --zone=public --add-port=9080/tcp --permanent

firewall-cmd --reload