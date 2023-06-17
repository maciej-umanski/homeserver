## Description
This repository contains configuration of my terminal acting as secure gateway to my home network. Also act as DNS resolver and Ad blocker.

## Installation Guide
Please follow [this](/docs/GUIDE.md) guide.

## Tested Configuration
* Dell Wyse DX0D
  * CPU - AMD G-T48E
  * RAM - 2GB DDR3
  * ROM - 8GB FLASH
  * OS - Debian 11.7 Bullseye

## Bootstrap Script Content
* Turn off MOTD
* Enable contrib and non-free APT repositories
* [Debloat APT](https://dennislee.xyz/2020/debian-eliminate-dependency-bloat/)
* Install software from APT
  * hardware specific
    * firmware-linux-nonfree
    * amd-microcode
    * firmware-realtek
  * classic
    * git
    * net-tools
* Install Docker
* Configure static ip based on current DHCP connection using cloudflare dns resolver.
* Pull this repository
* Reboot system

## Docker Services
* [No-ip](https://github.com/maciej-umanski/docker-no-ip)
* [Pi-hole](https://github.com/pi-hole/docker-pi-hole)
* [Unbound](https://github.com/MatthewVance/unbound-docker-rpi)
* [OpenVPN](https://github.com/dockovpn/dockovpn)