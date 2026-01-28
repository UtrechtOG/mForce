#!/data/data/com.termux/files/usr/bin/bash

# Colors
ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
MUTED="\033[38;5;240m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
DANGER="\033[38;5;196m"
BOLD="\033[1m"
NC="\033[0m"

echo
echo -e "${BOLD}${ACCENT}Access Point Fingerprinting${NC}"
echo -e "${MUTED}Passive analysis of nearby wireless infrastructure${NC}"
echo

# Dependencies
command -v termux-wifi-scaninfo >/dev/null 2>&1 || { echo "[!] termux-api missing"; exit 1; }
command -v jq >/dev/null 2>&1 || pkg install jq -y

RAW=$(termux-wifi-scaninfo 2>/dev/null)
echo "$RAW" | grep -q '\[' || { echo "[!] WiFi scan failed"; exit 1; }

# jq does ALL grouping + formatting safely
echo "$RAW" | jq -r '
group_by(.ssid)[] |
[
  (.[0].ssid // "<hidden>"),
  length,
  (.[0].capabilities),
  (.[0].bssid)
] | @tsv
' | while IFS=$'\t' read -r SSID APS CAPS BSSID; do

  OUI=${BSSID:0:8}

  # Vendor detection
  VENDOR="Unknown / Generic"
  CATEGORY="Consumer"

  case "$OUI" in
    7C:FF:4D|7c:ff:4d|D4:24:DD)
      VENDOR="AVM (FRITZ!Box)"
      CATEGORY="Consumer"
      ;;
    18:6A:81|f0:86:20|60:8d:26)
      VENDOR="Telekom"
      CATEGORY="ISP Router"
      ;;
    50:E6:36|74:90:BC)
      VENDOR="Vodafone"
      CATEGORY="ISP Router"
      ;;
    00:1B:67|00:1F:90)
      VENDOR="Ubiquiti"
      CATEGORY="Enterprise"
      ;;
  esac

  # Security
  WPA="WPA2"
  [[ "$CAPS" == *"WPA3"* ]] && WPA="WPA3 / Mixed"

  WPS="No"
  [[ "$CAPS" == *"WPS"* ]] && WPS="Yes"

  TOPOLOGY="Single AP"
  [[ "$APS" -gt 1 ]] && TOPOLOGY="Mesh / Repeater"

  # Risk score
  RISK=0
  [[ "$WPA" == "WPA2" ]] && ((RISK+=2))
  [[ "$WPS" == "Yes" ]] && ((RISK+=3))
  [[ "$CATEGORY" == "ISP Router" ]] && ((RISK+=1))
  [[ "$TOPOLOGY" == "Mesh / Repeater" ]] && ((RISK+=1))
  [[ "$SSID" == "<hidden>" ]] && ((RISK+=1))
  [[ "$RISK" -gt 10 ]] && RISK=10

  LABEL="Low"
  COLOR=$SUCCESS
  [[ "$RISK" -ge 3 ]] && LABEL="Medium" && COLOR=$WARN
  [[ "$RISK" -ge 6 ]] && LABEL="High" && COLOR=$DANGER

  # Output
  echo -e "${ACCENT}SSID${NC}            : ${BOLD}$SSID${NC}"
  echo -e "${INFO}Vendor${NC}          : $VENDOR"
  echo -e "${INFO}Category${NC}        : $CATEGORY"
  echo -e "${INFO}Access Points${NC}   : $APS"
  echo -e "${INFO}Topology${NC}        : $TOPOLOGY"
  echo -e "${INFO}Security${NC}        : $WPA"
  echo -e "${INFO}WPS Enabled${NC}     : $WPS"
  echo -e "${INFO}Risk Score${NC}      : ${COLOR}$RISK / 10 ($LABEL)${NC}"
  echo -e "${MUTED}------------------------------------------------------------${NC}"

done

echo -e "${SUCCESS}[*] Access point fingerprinting completed${NC}"
