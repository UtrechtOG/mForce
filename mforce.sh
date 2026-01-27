#!/data/data/com.termux/files/usr/bin/bash

source core/banner.sh

banner

echo "[1] WiFi OSINT"
echo "[0] Exit"
echo
read -p "mForce >> " choice

case $choice in
  1) bash modules/wifi_osint.sh ;;
  0) exit ;;
  *) echo "Invalid option" ;;
esac
