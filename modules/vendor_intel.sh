#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
MUTED="\033[38;5;240m"
NC="\033[0m"
BOLD="\033[1m"

echo
echo -e "${BOLD}${ACCENT}Vendor Intelligence${NC}"
echo -e "${MUTED}Passive vendor & infrastructure profiling${NC}"
echo

RAW=$(termux-wifi-scaninfo)

echo "$RAW" | jq -r '.[] | .ssid // ""' | while read -r SSID; do
  [[ -z "$SSID" ]] && continue

  VENDOR="Unknown"
  CATEGORY="Generic"

  [[ "$SSID" =~ FRITZ ]] && VENDOR="AVM" && CATEGORY="Consumer / SME"
  [[ "$SSID" =~ Magenta ]] && VENDOR="Telekom" && CATEGORY="ISP Managed"
  [[ "$SSID" =~ Vodafone ]] && VENDOR="Vodafone" && CATEGORY="ISP Managed"
  [[ "$SSID" =~ UniFi ]] && VENDOR="Ubiquiti" && CATEGORY="Prosumer / Enterprise"
  [[ "$SSID" =~ TP-Link ]] && VENDOR="TP-Link" && CATEGORY="Consumer"
  [[ "$SSID" =~ ASUS ]] && VENDOR="ASUS" && CATEGORY="Prosumer"

  echo -e "${INFO}SSID${NC}     : $SSID"
  echo -e "${INFO}Vendor${NC}   : $VENDOR"
  echo -e "${INFO}Category${NC} : $CATEGORY"
  echo -e "${MUTED}----------------------------------------${NC}"
done
