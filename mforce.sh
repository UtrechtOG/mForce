#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
ADV="\033[38;5;203m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

VERSION="v0.02.7-alpha"

clear

echo -e "${ACCENT}mForce${NC} • MultiForce Security Framework"
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo -e "${INFO}▸ Platform${NC} : Termux (Android)"
echo -e "${INFO}▸ Language${NC} : Shell"
echo -e "${INFO}▸ Mode${NC}     : OSINT / Recon"
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo -e "${SUCCESS}Passive · Modular · Android-Native${NC}"
echo
echo -e "${INFO}▸ Framework${NC} : mForce ${SUCCESS}${VERSION}${NC}"
echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

# -------- Exit (top, standalone) --------
echo
echo -e "${WARN}[*]${NC} Exit"
echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo

# -------- Core Modules (10 x 2) --------
echo -e "${BOLD}${INFO}Core Modules${NC}"
echo

printf "${INFO}[01]${NC} %-28s ${INFO}[02]${NC} %-28s\n" "WiFi OSINT" "Access Point Fingerprinting"
printf "${INFO}[03]${NC} %-28s ${INFO}[04]${NC} %-28s\n" "BLE OSINT (exp)" "Device Presence Analysis"
printf "${INFO}[05]${NC} %-28s ${INFO}[06]${NC} %-28s\n" "Vendor Intelligence" "Secure Password Generator"
printf "${INFO}[07]${NC} %-28s ${INFO}[08]${NC} %-28s\n" "IP / Network OSINT" "Domain OSINT"
printf "${INFO}[09]${NC} %-28s ${INFO}[10]${NC} %-28s\n" "Username OSINT" "Environment Type Detection"

echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

# -------- Advanced / Defensive --------
echo -e "${BOLD}${ADV}Advanced / Defensive${NC}"
echo
printf "${ADV}[11]${NC} %-28s\n" "Code Security Bot"

echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

read -p "mForce ▸ " OPTION
echo

case "$OPTION" in
  "*") exit 0 ;;
  1)  bash modules/wifi_osint.sh ;;
  2)  bash modules/ap_fingerprint.sh ;;
  3)  bash modules/ble_osint.sh ;;
  4)  bash modules/device_presence.sh ;;
  5)  bash modules/vendor_intel.sh ;;
  6)  bash modules/password_generator.sh ;;
  7)  bash modules/ip_osint.sh ;;
  8)  bash modules/domain_osint.sh ;;
  9)  bash modules/username_osint.sh ;;
  10) bash modules/environment_type.sh ;;
  11) bash modules/code_security.sh ;;
  *)  echo -e "${WARN}[!] Invalid option${NC}" ;;
esac
