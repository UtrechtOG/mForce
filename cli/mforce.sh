#!/data/data/com.termux/files/usr/bin/bash

# ===== Path handling (VERY IMPORTANT) =====
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MODULES_DIR="$BASE_DIR/modules"

# ===== Colors =====
HDR="\033[38;5;45m"
INFO="\033[38;5;39m"
OSINT="\033[38;5;81m"
DEF="\033[38;5;82m"
OFF="\033[38;5;203m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

VERSION="v0.02.8-alpha"

clear

echo -e "${HDR}mForce${NC} • MultiForce Security Framework"
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo -e "${INFO}▸ Platform${NC} : Termux (Android)"
echo -e "${INFO}▸ Language${NC} : Shell"
echo -e "${INFO}▸ Mode${NC}     : OSINT / Defense / Offensive"
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"
echo -e "${INFO}▸ Framework${NC} : mForce ${VERSION}"
echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

# ===== Exit =====
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
printf "${DEF}[12]${NC} %-32s ${DEF}[13]${NC} %-32s\n" \
  "Password Strength Analyzer" "HTTP Security Header Checker"
printf "${DEF}[16]${NC} %-32s\n" \
  "Configuration Leak Detector"

echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

# ================= OFFENSIVE =================
echo -e "${BOLD}${OFF}Offensive (Legal Recon)${NC}"
echo
printf "${OFF}[14]${NC} %-32s ${OFF}[15]${NC} %-32s\n" \
  "Subdomain Enumeration" "Public Exposure Scanner"

echo
echo -e "${MUTED}────────────────────────────────────────────────────────────────────────${NC}"

read -p "mForce ▸ " OPTION
echo

case "$OPTION" in
  "*") exit 0 ;;

  1)  bash "$MODULES_DIR/wifi_osint.sh" ;;
  2)  bash "$MODULES_DIR/ap_fingerprint.sh" ;;
  3)  bash "$MODULES_DIR/ble_osint.sh" ;;
  4)  bash "$MODULES_DIR/device_presence.sh" ;;
  5)  bash "$MODULES_DIR/vendor_intel.sh" ;;
  6)  bash "$MODULES_DIR/password_generator.sh" ;;
  7)  bash "$MODULES_DIR/ip_osint.sh" ;;
  8)  bash "$MODULES_DIR/domain_osint.sh" ;;
  9)  bash "$MODULES_DIR/username_osint.sh" ;;
  10) bash "$MODULES_DIR/environment_type.sh" ;;
  11) bash "$MODULES_DIR/code_security.sh" ;;
  12) bash "$MODULES_DIR/password_analyzer.sh" ;;
  13) bash "$MODULES_DIR/http_headers.sh" ;;
  14) bash "$MODULES_DIR/subdomain_enum.sh" ;;
  15) bash "$MODULES_DIR/public_exposure.sh" ;;
  16) bash "$MODULES_DIR/config_leak_detector.sh" ;;

  *)  echo -e "${WARN}[!] Invalid option${NC}" ;;
esac
