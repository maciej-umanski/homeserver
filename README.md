# Services Included

### Docker
* [No-ip](https://github.com/maciej-umanski/docker-no-ip)
* [Pi-hole](https://github.com/pi-hole/docker-pi-hole)
* [OpenVPN](https://github.com/dockovpn/dockovpn)
* [Samba](https://github.com/dperson/samba)
* [Gitea](https://github.com/go-gitea/gitea)
* [Unbound](https://github.com/MatthewVance/unbound-docker-rpi)

# Installation
```shell
sudo apt install git -y \
 && git clone https://github.com/maciej-umanski/homeserver.git \
 && sh ./homeserver/bootstrap full
```

# OpenVPN client retrieve
```shell
docker exec openvpn wget -q --output-document - localhost:8080 | tee client.ovpn > /dev/null
```