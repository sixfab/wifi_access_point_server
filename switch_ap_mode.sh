#!/bin/bash

# Switch to wifi AP mode

# Check if we are root
if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi


# Configure the dhcpcd to use the static IP address
cp ./ap_config_files/dhcpcd.conf /etc/dhcpcd.conf

# Configure the dnsmaq
cp ./ap_config_files/dnsmasq.conf /etc/dnsmasq.conf

# Configure the hostapd
cp ./ap_config_files/hostapd.conf /etc/hostapd/hostapd.conf

# Add new local host name to /etc/hosts
cp ./ap_config_files/hosts /etc/hosts

# Add exception for wlan0 to core configuration file
cp ./ap_config_files/core_config.yaml /home/pi/.core/configs/config.yaml

# Stop services
systemctl stop hostapd
systemctl stop dnsmasq

# Stop services conflicting with hostapd
systemctl stop systemd-resolved
systemctl stop wpa_supplicant

# Stop active wpa supplicant processes
pkill wpa_supplicant
rfkill block wifi
sleep 1
rfkill unblock wifi

# Restart dhcpcd, dnsmasq, hostapd, core_manager
systemctl daemon-reload
systemctl restart dhcpcd dnsmasq hostapd core_manager




