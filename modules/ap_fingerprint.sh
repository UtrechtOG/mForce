#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
MUTED="\033[38;5;240m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
BOLD="\033[1m"
NC="\033[0m"

echo
echo -e "${BOLD}${ACCENT}Access Point Fingerprinting${NC}"
echo -e "${MUTED}Analyzing nearby wireless infrastructure${NC}"
echo

# Dependencies
if ! command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "[!] termux-api not installed"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  pkg install jq -y
fi

# Run WiFi scan
RAW=$(termux-wifi-scaninfo 2>/dev/null)

if ! echo "$RAW" | grep -q '\['; then
  echo "[!] WiFi scan failed"
  exit 1
fi

# Group by SSID
echo "$RAW" | jq -r '
group_by(.ssid)[] |
{
  ssid: (.[0].ssid // "<hidden>"),
  count: length,
  caps: (.[0].capabilities),
  bssid: (.[0].bssid)
}
' | while read -r line; do

  SSID=$(echo "$line" | jq -r '.ssid')
  COUNT=$(echo "$line" | jq -r '.count')
  CAPS=$(echo "$line" | jq -r '.caps')
  BSSID=$(echo "$line" | jq -r '.bssid')

  # Vendor heuristic
  VENDOR="Unknown"
  case "${BSSID:0:8}" in
    7C:FF:4D|7c:ff:4d) VENDOR="AVM (FRITZ!Box)" ;;
    18:6A:81|18:6a:81) VENDOR="Telekom" ;;
    F0:86:20|f0:86:20) VENDOR="Telekom / ISP" ;;
    50:E6:36|50:e6:36) VENDOR="Vodafone" ;;
  esac

  # Security analysis
  SECURITY="WPA2"
  [[ "$CAPS" == *"WPA3"* ]] && SECURITY="WPA3 / Mixed"
  [[ "$CAPS" == *"WPS"* ]] && SECURITY="$SECURITY + WPS"

  # Topology
  TOPOLOGY="Single AP"
  [[ "$COUNT" -gt 1 ]] && TOPOLOGY="Mesh / Repeater"

  # Risk score
  RISK="Low"
  [[ "$SECURITY" == *"WPS"* ]] && RISK="Medium"
  [[ "$SECURITY" == "WPA2" ]] && RISK="Medium"

  echo -e "${ACCENT}SSID${NC}            : $SSID"
  echo -e "${ACCENT}Vendor${NC}          : $VENDOR"
  echo -e "${ACCENT}Access Points${NC}   : $COUNT"
  echo -e "${ACCENT}Topology${NC}        : $TOPOLOGY"
  echo -e "${ACCENT}Security${NC}        : $SECURITY"
  echo -e "${ACCENT}Risk Indicator${NC}  : $RISK"
  echo -e "${MUTED}--------------------------------------------${NC}"

done

echo -e "${SUCCESS}[*] Fingerprinting complete${NC}"
