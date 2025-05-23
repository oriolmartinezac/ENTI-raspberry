#!/bin/bash

# Interficie sortida a Internet, CANVIA entre Wi-Fi (wlp2s0) o Ethernet (eth0)
OUT_IF="wlp2s0"
#OUT_IF="eth0"

# Interficie cap a la Raspberry
RASPI_IF="enx00e04c2a4e30"

# Establir IP per a la connexio a traves de ssh amb la raspberry

echo "Setting IP for Raspberry..."
sudo iptables -t nat -A POSTROUTING -o $OUT_IF -j MASQUERADE
sudo iptables -A FORWARD -i $OUT_IF -o $RASPI_IF -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $RASPI_IF -o $OUT_IF -j ACCEPT

echo "IP forwarding..."

sudo sysctl -w net.ipv4.ip_forward=1

echo "Configurant regles iptables per NAT i trafic..."
sudo iptables -t nat -A POSTROUTING -o $OUT_IF -j MASQUERADE
sudo iptables -A FORWARD -i $OUT_IF -o $RASPI_IF -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $RASPI_IF -o $OUT_IF -j ACCEPT

echo "Afegint regles per DNS i HTTP/HTTPS..."
sudo iptables -A FORWARD -p udp --dport 53 -j ACCEPT
sudo iptables -A FORWARD -p tcp --dport 53 -j ACCEPT
sudo iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
sudo iptables -A FORWARD -p tcp --dport 443 -j ACCEPT

echo "Comparticio Internet configurada."
