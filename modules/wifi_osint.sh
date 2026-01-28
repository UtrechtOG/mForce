#!/data/data/com.termux/files/usr/bin/bash

echo "[*] mForce WiFi OSINT (No-Root Mode)"
echo "[*] Using Android WiFi API"
echo

# Dependency checks
if ! command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "[!] termux-api not installed"
  echo "[*] Install with: pkg install termux-api"
  echo "[*] Install the Termux:API app from F-Droid"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "[*] Installing dependency: jq"
  pkg install jq -y
fi

# Spinner function
spinner() {
  local pid=$1
  local spin='-\|/'
  local i=0
  while kill -0 $pid 2>/dev/null; do
    i=$(( (i+1) %4 ))
    printf "\r[*] Scanning nearby WiFi networks... %s" "${spin:$i:1}"
    sleep 0.1
  done
  printf "\r[*] Scanning nearby WiFi networks... done ✔\n\n"
}

# Run scan in background
termux-wifi-scaninfo 2>/dev/null > /tmp/mforce_wifi.json &
SCAN_PID=$!

spinner $SCAN_PID

RAW_OUTPUT=$(cat /tmp/mforce_wifi.json)
rm -f /tmp/mforce_wifi.json

# Validate output
if ! echo "$RAW_OUTPUT" | grep -q '\['; then
  echo "[!] Failed to retrieve WiFi data"
  echo "[!] Make sure:"
  echo "    - WiFi is enabled"
  echo "    - Termux:API app is installed"
  echo "    - Location permission is granted"
  exit 1
fi

# Display results
echo "$RAW_OUTPUT" | jq -r '
.[] |
"SSID: \(.ssid // "<hidden>")\nBSSID: \(.bssid)\nSignal: \(.level // "unknown") dBm\nSecurity: \(.capabilities)\n------------------------"
'
