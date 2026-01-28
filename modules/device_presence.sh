#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
MUTED="\033[38;5;240m"
NC="\033[0m"
BOLD="\033[1m"

echo
echo -e "${BOLD}${ACCENT}Device Presence Analysis${NC}"
echo -e "${MUTED}Passive inference of nearby device environment${NC}"
echo

command -v termux-wifi-scaninfo >/dev/null 2>&1 || {
  echo -e "[!] WiFi scan unavailable"
  exit 0
}

RAW=$(termux-wifi-scaninfo)

TOTAL=$(echo "$RAW" | jq length)
REPEATERS=$(echo "$RAW" | jq '[.[] | select(.ssid | test("Repeater|Mesh|EXT"; "i"))] | length')
SMART=$(echo "$RAW" | jq '[.[] | select(.ssid | test("Home|FRITZ|WLAN|Magenta"; "i"))] | length')
IOT=$(echo "$RAW" | jq '[.[] | select(.ssid | test("TV|Cam|Plug|Light|ESP"; "i"))] | length')

echo -e "${INFO}Total Access Points${NC} : $TOTAL"
echo -e "${INFO}Home / ISP Routers${NC} : $SMART"
echo -e "${INFO}Repeaters / Mesh${NC} : $REPEATERS"
echo -e "${INFO}IoT Networks${NC} : $IOT"
echo

PROFILE="Mixed / Unknown"
[[ "$SMART" -ge 5 ]] && PROFILE="Residential Area"
[[ "$REPEATERS" -ge 3 ]] && PROFILE="Large Home / Weak Coverage"
[[ "$TOTAL" -ge 15 ]] && PROFILE="Dense Urban Environment"

echo -e "${SUCCESS}Presence Profile${NC}"
echo -e "Environment Type : ${PROFILE}"
