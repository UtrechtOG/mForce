#!/data/data/com.termux/files/usr/bin/bash

# Colors
ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
MUTED="\033[38;5;240m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
BOLD="\033[1m"
NC="\033[0m"

echo
echo -e "${BOLD}${ACCENT}BLE OSINT${NC}"
echo -e "${MUTED}Passive Bluetooth Low Energy reconnaissance${NC}"
echo

# Deps
command -v termux-bluetooth-scaninfo >/dev/null 2>&1 || {
  echo "[!] termux-api missing"; exit 1;
}
command -v jq >/dev/null 2>&1 || pkg install jq -y

RAW=$(termux-bluetooth-scaninfo 2>/dev/null)
echo "$RAW" | grep -q '\[' || { echo "[!] BLE scan failed"; exit 1; }

# Counters
TOTAL=0
PHONES=0
AUDIO=0
WATCH=0
BEACON=0
UNKNOWN=0

echo "$RAW" | jq -r '
.[] |
[
  (.name // ""),
  (.deviceClass // ""),
  (.rssi // -999),
  (.manufacturerData // "")
] | @tsv
' | while IFS=$'\t' read -r NAME CLASS RSSI MFG; do
  ((TOTAL++))

  # Signal bucket
  SIGNAL="Weak"
  [[ "$RSSI" -ge -60 ]] && SIGNAL="Strong"
  [[ "$RSSI" -lt -60 && "$RSSI" -ge -80 ]] && SIGNAL="Medium"

  # Type heuristic
  TYPE="Unknown"
  [[ "$CLASS" == *"phone"* || "$NAME" == *"iPhone"* || "$NAME" == *"Android"* ]] && TYPE="Smartphone"
  [[ "$CLASS" == *"audio"* || "$NAME" == *"JBL"* || "$NAME" == *"Sony"* ]] && TYPE="Audio Device"
  [[ "$CLASS" == *"watch"* || "$NAME" == *"Watch"* ]] && TYPE="Smartwatch"
  [[ "$NAME" == *"Beacon"* || "$MFG" != "" ]] && TYPE="Beacon / IoT"

  case "$TYPE" in
    Smartphone) ((PHONES++)) ;;
    "Audio Device") ((AUDIO++)) ;;
    Smartwatch) ((WATCH++)) ;;
    "Beacon / IoT") ((BEACON++)) ;;
    *) ((UNKNOWN++)) ;;
  esac

  # Vendor heuristic
  VENDOR="Unknown"
  [[ "$NAME" == *"iPhone"* || "$MFG" == *"Apple"* ]] && VENDOR="Apple"
  [[ "$NAME" == *"Samsung"* ]] && VENDOR="Samsung"
  [[ "$NAME" == *"Xiaomi"* ]] && VENDOR="Xiaomi"
  [[ "$NAME" == *"JBL"* ]] && VENDOR="JBL"
  [[ "$NAME" == *"Sony"* ]] && VENDOR="Sony"

  echo -e "${ACCENT}Type${NC}        : $TYPE"
  echo -e "${INFO}Vendor${NC}      : $VENDOR"
  echo -e "${INFO}Signal${NC}      : $SIGNAL"
  echo -e "${INFO}Advertising${NC} : Active"
  echo -e "${MUTED}----------------------------------------${NC}"
done

echo -e "${SUCCESS}Summary${NC}"
echo -e "${INFO}Devices Detected${NC} : $TOTAL"
echo -e "${INFO}Smartphones${NC}      : $PHONES"
echo -e "${INFO}Audio Devices${NC}    : $AUDIO"
echo -e "${INFO}Smartwatches${NC}     : $WATCH"
echo -e "${INFO}Beacons / IoT${NC}    : $BEACON"
echo -e "${INFO}Unknown${NC}          : $UNKNOWN"
