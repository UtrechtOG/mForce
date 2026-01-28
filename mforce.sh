#!/data/data/com.termux/files/usr/bin/bash

HDR="\033[38;5;45m"
INFO="\033[38;5;39m"
OSINT="\033[38;5;81m"
DEF="\033[38;5;82m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

VERSION="v0.02.7-alpha"

clear

echo -e "${HDR}mForce${NC} • MultiForce Security Framework"
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo -e "${INFO}▸ Platform${NC} : Termux (Android)"
echo -e "${INFO}▸ Language${NC} : Shell"
echo -e "${INFO}▸ Mode${NC}     : OSINT / Recon"
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo -e "${INFO}▸ Framework${NC} : mForce ${VERSION}"
echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

# Exit
echo
echo -e "${WARN}[*]${NC} Exit"
echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo

# ================= OSINT =================
echo -e "${BOLD}${OSINT}OSINT${NC}"
echo

printf "${OSINT}[01]${NC} %-32s ${OSINT}[02]${NC} %-32s\n" \
  "WiFi OSINT" "Access Point Fingerprinting"

printf "${OSINT}[03]${NC} %-32s ${OSINT}[04]${NC} %-32s\n" \
  "BLE OSINT (exp)" "Device Presence Analysis"

printf "${OSINT}[05]${NC} %-32s ${OSINT}[07]${NC} %-32s\n" \
  "Vendor Intelligence" "IP / Network OSINT"

printf "${OSINT}[08]${NC} %-32s ${OSINT}[09]${NC} %-32s\n" \
  "Domain OSINT" "Username OSINT"

printf "${OSINT}[10]${NC} %-32s\n" \
  "Environment Type Detection"

echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

# ================= DEFENSIVE =================
echo -e "${BOLD}${DEF}Defensive${NC}"
echo
printf "${DEF}[06]${NC} %-32s ${DEF}[11]${NC} %-32s\n" \
  "Secure Password Generator" "Code Security Bot"

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
