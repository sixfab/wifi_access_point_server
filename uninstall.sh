#!/bin/bash

# Check if we are root
if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Return original configs
mv /etc/dhcpcd.conf.orig /etc/dhcpcd.conf
mv /etc/hosts.orig /etc/hosts
mv /etc/dnsmasq.conf.orig /etc/dnsmasq.conf

# Remove services
systemctl stop hostapd dnsmasq
systemctl disable hostapd dnsmasq
apt purge hostapd dnsmasq -y

# Remove config files
rm -rf /etc/hostapd/hostapd.conf
rm -rf /etc/dnsmasq.conf
rm -rf ./ap_config_files
rm -rf ./client_config_files
