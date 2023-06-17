# Installation guide
Following this tutorial will help you configure your own terminal

## IMPORTANT
If the bootstrap script fails before restarting the server. **DO NOT** run the bootstrap script again. You need to perform fresh installation of operating system.

## Preparation
* Perform clean installation of Debian 11 with these options:
    * Skip root account creation
    * Select **only** the "SSH Server" and "Standard System utilities" in tasksel
* Set Port Forwarding from 1194 UDP to your terminal (Might be needed to contact your ISP to change your ip from ipv6 to ipv4)
* **Optional but recommended** - Set DHCP IP Reservation of your terminal in Wi-Fi router
* Create account at [No-ip](https://www.noip.com) and create dynamic hostname targeting your WAN IP address

## Bootstrap
* Connect to terminal through ssh and execute below command. Script will reboot the terminal automatically.
  ```shell
  wget -qO - https://raw.githubusercontent.com/maciej-umanski/homeserver/master/install.sh | sudo bash -s "$USER"
  ```

## Services start-up
* Create and fill **.env** file based on **.env.example**
* execute `docker-compose up -d`
* check with `docker ps -a` if all services are running and are stable
* execute below script to obtain openvpn certificate
  ```shell
  docker exec openvpn wget -q --output-document - localhost:8080 | tee client.ovpn > /dev/null
  ```