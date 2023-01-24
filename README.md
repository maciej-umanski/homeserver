## Specification
* Dell Wyse DX0D (AMD G-T48E / 2GB RAM / 8GB FLASH)
* Debian 11 Bullseye - minimal installation

## Bootstrap
```shell
wget -qO - https://raw.githubusercontent.com/maciej-umanski/homeserver/master/install.sh | sudo bash -s "$USER"
```

## Install Script
* Turn off MOTD
* [Debloat APT](https://dennislee.xyz/2020/debian-eliminate-dependency-bloat/)
* Enable contrib and non-free APT repositories
* Install Software
  * Docker
  * Openssh server
  * Vim
  * firmware-linux-nonfree 
  * amd-microcode
  * git
* Pull this repository

## Docker Services
* [No-ip](https://github.com/maciej-umanski/docker-no-ip)
* [Pi-hole](https://github.com/pi-hole/docker-pi-hole) + [Unbound](https://github.com/MatthewVance/unbound-docker-rpi)
* [OpenVPN](https://github.com/dockovpn/dockovpn)
* [Samba](https://github.com/dperson/samba)

## Misc
### OpenVPN
* Forward UDP port 1194 to your box
* Retrieve client configuration: 
```shell
docker exec openvpn wget -q --output-document - localhost:8080 | tee client.ovpn > /dev/null
```