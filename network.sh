#!/bin/bash

RASPI_IF="enx00e04c2a4e30"

sudo ip addr add 192.168.137.1/24 dev $RASPI_IF
sudo ip link set $RASPI_IF up