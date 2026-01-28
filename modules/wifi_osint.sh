#!/data/data/com.termux/files/usr/bin/bash

# Colors (safe, no dependencies)
BOLD="\033[1m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
NC="\033[0m"

echo
echo -e "${BOLD}${CYAN}==============================================${NC}"
echo -e "${BOLD}${CYAN}        mForce | WiFi OSINT Scanner${NC}"
echo -e "${CYAN}   Passive Wireless Recon (No-Root)${NC}"
echo -e "${BOLD}${CYAN}==============================================${NC}"
echo

# Dependency checks
if ! command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "[!] termux-api not installed"
  echo "[*] Install with: pkg install termux-api"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "[*] Installing dependency: jq"
  pkg install jq -y
fi

echo -e "${YELLOW}[*] Scanning nearby WiFi networks...${NC}"
echo

RAW_OUTPUT=$(termux-wifi-scaninfo 2>/dev/null)

if ! echo "$RAW_OUTPUT" | grep -q '\['; then
  echo "[!] Failed to retrieve WiFi data"
  echo "[!] Check WiFi & permissions"
  exit 1
fi

# Table header
printf "${BOLD}%-4s %-22s %-19s %-10s %-25s${NC}\n" \
"ID" "SSID" "BSSID" "SIGNAL" "SECURITY"
printf "%-4s %-22s %-19s %-10s %-25s\n" \
"----" "----------------------" "-------------------" "----------" "-------------------------"

# Table rows
echo "$RAW_OUTPUT" | jq -r '
.[] |
[
  (.ssid // "<hidden>"),
  .bssid,
  (.level // "N/A"),
  .capabilities
] | @tsv
' | nl -w2 -s'. ' | while IFS=$'\t' read -r id ssid bssid level sec; do
  printf "%-4s %-22.22s %-19s %-10s %-25.25s\n" \
  "$id" "$ssid" "$bssid" "$level dBm" "$sec"
done

# Footer
COUNT=$(echo "$RAW_OUTPUT" | jq length)
echo
echo -e "${GREEN}[*] Networks found:${NC} $COUNT"
