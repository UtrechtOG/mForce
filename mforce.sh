#!/data/data/com.termux/files/usr/bin/bash

# ==============================
# mForce Version
# ==============================
MFORCE_VERSION="v0.02.7-alpha"

# Load core
source core/colors.sh 2>/dev/null
source core/banner.sh 2>/dev/null

# Fallback colors
ACCENT=${ACCENT:-"\033[38;5;45m"}
NC=${NC:-"\033[0m"}
GREEN=${GREEN:-"\033[38;5;82m"}
MUTED=${MUTED:-"\033[38;5;240m"}

clear
banner

echo -e "${MUTED}────────────────────────────────────────────────${NC}"
echo -e "${ACCENT}▸ Framework${NC} : mForce ${GREEN}${MFORCE_VERSION}${NC}"
echo -e "${ACCENT}▸ Platform ${NC}: Termux (Android)"
echo -e "${ACCENT}▸ Language ${NC}: Shell"
echo -e "${ACCENT}▸ Mode     ${NC}: OSINT / Recon"
echo -e "${MUTED}────────────────────────────────────────────────${NC}"
echo -e "${GREEN}Passive · Modular · Android-Native${NC}"
echo

echo -e "${ACCENT}[1]${NC} WiFi OSINT"
echo -e "${ACCENT}[2]${NC} Access Point Fingerprinting"
echo -e "${ACCENT}[3]${NC} BLE OSINT"
echo -e "${ACCENT}[0]${NC} Exit"
echo

read -p "mForce ▸ " choice
echo

case "$choice" in
  1)
    bash modules/wifi_osint.sh
    ;;
  2)
    bash modules/ap_fingerprint.sh
    ;;
  3)
    bash modules/ble_osint.sh
    ;;
  0)
    echo -e "${MUTED}Exiting mForce ${MFORCE_VERSION}...${NC}"
    exit 0
    ;;
  *)
    echo -e "[!] Invalid option"
    ;;
esac
