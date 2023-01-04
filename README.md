# Hardware
* Lenovo M900 Tiny (i5-6500T, 16GB RAM)
* Minimal Debian 11

# Bootstrap actions
### base (suitable for guest)
* Turn off MOTD
* [Debloat APT](https://dennislee.xyz/2020/debian-eliminate-dependency-bloat/)
* Docker with configuration
* openssh-server
* vim
### full (hardware specific - host)
* all the **base** section
* add contrib and non-free repos to APT
* firmware-linux-nonfree 
* intel-microcode 
* KVM (libvirt) with configuration
  * systemd service to allow bridged networking with docker

# Manual steps after bootstrap:
* system
  * configure static ip
* docker
  * fill up .env file and compose services
* kvm
  * set-up bridge in ip configuration ([example](./system/configuration/br0_interface))
  * download [Debian 11](https://www.debian.org) ISO
  * provide iso and storage locations to the debian kickstart script

# What's included?
### Docker Services
* [No-ip](https://github.com/maciej-umanski/docker-no-ip)
* [Pi-hole](https://github.com/pi-hole/docker-pi-hole)
* [OpenVPN](https://github.com/dockovpn/dockovpn)
* [Samba](https://github.com/dperson/samba)
* [Gitea](https://github.com/go-gitea/gitea)
* [Unbound](https://github.com/MatthewVance/unbound-docker-rpi)
### KVM
* [Debian 11](https://www.debian.org)

# Misc
### OpenVPN
* Forward UDP port 1194 to your box
* Retrieve client configuration: 
```shell
docker exec openvpn wget -q --output-document - localhost:8080 | tee client.ovpn > /dev/null
```

# Todo
* Add bootstrap docker-compose up and docker-compose down