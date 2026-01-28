#!/data/data/com.termux/files/usr/bin/bash

# ===============================
# mForce Core
# MultiForce Security Framework
# ===============================

# -------- Colors --------
ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

VERSION="v0.02.7-alpha"

clear

# -------- Header --------
echo -e "${ACCENT}mForce${NC} • MultiForce Security Framework"
echo -e "${MUTED}────────────────────────────────────────────────${NC}"
echo -e "${INFO}▸ Platform${NC} : Termux (Android)"
echo -e "${INFO}▸ Language${NC} : Shell"
echo -e "${INFO}▸ Mode${NC}     : OSINT / Recon"
echo -e "${MUTED}────────────────────────────────────────────────${NC}"
echo -e "${SUCCESS}Passive · Modular · Android-Native${NC}"
echo
echo -e "${MUTED}────────────────────────────────────────────────${NC}"
echo -e "${INFO}▸ Framework${NC} : mForce ${SUCCESS}${VERSION}${NC}"
echo -e "${MUTED}────────────────────────────────────────────────${NC}"
echo

# -------- Menu --------
echo -e "${INFO}[1]${NC} WiFi OSINT"
echo -e "${INFO}[2]${NC} Access Point Fingerprinting"
echo -e "${INFO}[3]${NC} BLE OSINT ${MUTED}(experimental)${NC}"
echo -e "${INFO}[4]${NC} Device Presence Analysis"
echo -e "${INFO}[5]${NC} Vendor Intelligence"
echo -e "${INFO}[6]${NC} Secure Password Generator"
echo -e "${INFO}[7]${NC} IP / Network OSINT"
echo -e "${INFO}[8]${NC} Domain OSINT"
echo -e "${INFO}[0]${NC} Exit"
echo

read -p "mForce ▸ " OPTION
echo

# -------- Router --------
case "$OPTION" in
  1)
    bash modules/wifi_osint.sh
    ;;
  2)
    bash modules/ap_fingerprint.sh
    ;;
  3)
    bash modules/ble_osint.sh
    ;;
  4)
    bash modules/device_presence.sh
    ;;
  5)
    bash modules/vendor_intel.sh
    ;;
  6)
    bash modules/password_generator.sh
    ;;
  7)
    bash modules/ip_osint.sh
    ;;
  8)
    bash modules/domain_osint.sh
    ;;
  0)
    echo -e "${MUTED}Exiting mForce...${NC}"
    exit 0
    ;;
  *)
    echo -e "${WARN}[!] Invalid option${NC}"
    ;;
esac
