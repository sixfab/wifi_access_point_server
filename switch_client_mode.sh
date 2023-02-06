#!/bin/bash

# Switch WIFI client mode

# Check if we are root
if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi


# Delete AP Configs
cp ./client_config_files/dhcpcd.conf /etc/dhcpcd.conf

# Add wifi credentials to wpa_supplicant config
cp ./client_config_files/wpa_supplicant-wlan0.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

# Stop AP mode services
systemctl stop hostapd dnsmasq

# Restart services
systemctl daemon-reload
systemctl restart systemd-resolved dhcpcd
systemctl enable wpa_supplicant@wlan0.service
systemctl start wpa_supplicant@wlan0.service



