#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

clear
echo -e "${BOLD}${ACCENT}Environment Type Detection${NC}"
echo -e "${MUTED}Contextual analysis of local network environment${NC}"
echo

RAW=$(termux-wifi-scaninfo)

TOTAL=$(echo "$RAW" | jq length)
ISP=$(echo "$RAW" | jq '[.[] | select(.ssid | test("FRITZ|Magenta|Vodafone|Telekom";"i"))] | length')
ENTERPRISE=$(echo "$RAW" | jq '[.[] | select(.ssid | test("Corp|Office|UniFi|Enterprise";"i"))] | length')
PUBLIC=$(echo "$RAW" | jq '[.[] | select(.ssid | test("Free|Guest|Hotspot|WLAN";"i"))] | length')

TYPE="Unknown"
CONF="Medium"

if [[ "$ENTERPRISE" -ge 3 ]]; then
  TYPE="Office / SME"
elif [[ "$PUBLIC" -ge 3 ]]; then
  TYPE="Public Area / Hotspot"
elif [[ "$ISP" -ge 5 && "$TOTAL" -lt 12 ]]; then
  TYPE="Residential (House)"
elif [[ "$ISP" -ge 5 && "$TOTAL" -ge 12 ]]; then
  TYPE="Residential (Apartment)"
else
  TYPE="Mixed Environment"
fi

[[ "$TOTAL" -ge 15 ]] && CONF="High"

echo -e "${INFO}Detected Environment${NC}"
echo -e "  Type        : $TYPE"
echo -e "  Confidence  : $CONF"
echo
echo -e "${INFO}Indicators${NC}"
echo -e "  Total APs   : $TOTAL"
echo -e "  ISP Routers : $ISP"
echo -e "  Enterprise  : $ENTERPRISE"
echo -e "  Public SSID : $PUBLIC"
echo
echo -e "${SUCCESS}[*] Environment analysis complete${NC}"
