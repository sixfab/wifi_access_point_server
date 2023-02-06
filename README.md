# Repo for switching AP mode and client mode of wifi

It is suitable for dhcpcd managed network on Raspberry Pi OS. 

Component of project are;
- dhcpcd
- dnsmasq
- hostapd
- wpa_supplicant

# Installation
```
sudo chmod +x ./install.sh
sudo ./install.sh
```

# Configuration
Change the configs on source_config file with your preferred values. You can get help from example values. 

# Usage
To switch to AP mode:
```
sudo ./switch_ap_mode.sh
```

To switch to client mode:
```
sudo ./switch_client_mode.sh
```

To run test_server
```
sudo python3 test_server.py
```

# Full Usage Scenario
- Change source_config files with your values
- Switch AP mode
- Run the test_server
- Connect the wifi access point by uisng another device
- Type static_ip_address or domain and view the test server on your device.



# Uninstallation
```
sudo chmod +x ./uninstall.sh
sudo ./uninstall.sh
```
