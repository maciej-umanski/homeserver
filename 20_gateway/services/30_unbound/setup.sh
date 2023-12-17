#!/bin/bash
set -e # Stop script executing on any error code

cd "$(dirname "$0")"
sudo apt install unbound -y

wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
sudo cp resources/pi-hole.conf /etc/unbound/unbound.conf.d/
sudo cp resources/52-edns.conf /etc/dnsmasq.d/

sudo systemctl disable --now unbound-resolvconf.service
#sudo sed -Ei 's/^unbound_conf=/#unbound_conf=/' /etc/resolvconf.conf
#sudo rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf
sudo service unbound restart