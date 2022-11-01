# OpenVPN client retrieve
```shell
docker-compose exec openvpn wget -q --output-document - localhost:8080 | tee client.ovpn > /dev/null
```