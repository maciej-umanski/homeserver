# Services Included

* [No-ip](https://github.com/maciej-umanski/docker-no-ip)
* [Pi-hole](https://github.com/pi-hole/docker-pi-hole)
* [OpenVPN](https://github.com/dockovpn/dockovpn)
* [Watchtower](https://github.com/containrrr/watchtower)
* [Samba](https://github.com/dperson/samba)
* [Gitea](https://github.com/go-gitea/gitea)
* [Unbound](https://github.com/MatthewVance/unbound-docker-rpi)

# OpenVPN client retrieve
```shell
docker-compose exec openvpn wget -q --output-document - localhost:8080 | tee client.ovpn > /dev/null
```