#!/data/data/com.termux/files/usr/bin/bash

source core/banner.sh
banner

echo -e "${CYAN}[1]${NC} WiFi OSINT"
echo -e "${CYAN}[0]${NC} Exit"
echo

read -p "mForce >> " choice

case $choice in
  1) bash modules/wifi_osint.sh ;;
  0) exit ;;
  *) echo "[!] Invalid option" ;;
esac
