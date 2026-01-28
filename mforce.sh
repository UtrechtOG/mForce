#!/data/data/com.termux/files/usr/bin/bash

source core/banner.sh
banner

echo -e "${ACCENT}[1]${NC} WiFi OSINT"
echo -e "${ACCENT}[2]${NC} Access Point Fingerprinting"
echo -e "${ACCENT}[0]${NC} Exit"
echo

read -p "mForce ▸ " choice

case $choice in
  1)
    bash modules/wifi_osint.sh
    ;;
  2)
    bash modules/ap_fingerprint.sh
    ;;
  0)
    exit
    ;;
  *)
    echo "[!] Invalid option"
    ;;
esac
