#!/bin/bash

# Check if we are root
if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Check installation by checking .orig files
if [ -f /etc/dhcpcd.conf.orig ]; then
    echo "Already installed. Please uninstall first."
    exit 1
fi

# if ./ap_config_files or ./client_config_files exists, then exit with error
if [ -d ./ap_config_files ] || [ -d ./client_config_files ]; then
    echo "Already installed. Please uninstall first."
    exit 1
fi


# Give execution permissions to scripts
chmod +x ./switch_client_mode.sh
chmod +x ./switch_ap_mode.sh

# Install dependencies
apt-get update
apt-get install -y hostapd dnsmasq

# Disable services as default
systemctl unmask hostapd
systemctl disable hostapd dnsmasq
systemctl stop hostapd dnsmasq

# Get the current configs from the system
cp /etc/dhcpcd.conf /etc/dhcpcd.conf.orig
cp /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
cp /etc/hosts /etc/hosts.orig
cp /home/sixfab/.core/configs/config.yaml /home/sixfab/.core/configs/config.yaml.orig

mkdir client_config_files
cp /etc/dhcpcd.conf.orig ./client_config_files/dhcpcd.conf
cp /etc/dnsmasq.conf.orig ./client_config_files/dnsmasq.conf
cp /etc/hosts.orig ./client_config_files/hosts
cp /home/sixfab/.core/configs/config.yaml.orig ./client_config_files/core_config.yaml
touch ./client_config_files/wpa_supplicant-wlan0.conf

mkdir ap_config_files
cp /etc/dhcpcd.conf.orig  ./ap_config_files/dhcpcd.conf
cp /etc/dnsmasq.conf.orig ./ap_config_files/dnsmasq.conf
touch ./ap_config_files/hostapd.conf
cp /etc/hosts.orig ./ap_config_files/hosts
cp /home/sixfab/.core/configs/config.yaml.orig ./ap_config_files/core_config.yaml

# Add confgurations for AP mode to the files
cat ./source_configs/dhcpcd.conf >> ./ap_config_files/dhcpcd.conf
cat ./source_configs/dnsmasq.conf >> ./ap_config_files/dnsmasq.conf
cat ./source_configs/hostapd.conf >> ./ap_config_files/hostapd.conf
cat ./source_configs/hosts >> ./ap_config_files/hosts
cat ./source_configs/wpa_supplicant-wlan0.conf >> ./client_config_files/wpa_supplicant-wlan0.conf
cat ./source_configs/core_config.yaml >> ./ap_config_files/core_config.yaml
