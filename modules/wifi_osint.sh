#!/data/data/com.termux/files/usr/bin/bash

echo "[*] mForce WiFi OSINT (No-Root Mode)"
echo "[*] Using Android WiFi API"
echo

# Dependencies
if ! command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "[!] termux-api not installed"
  echo "[*] Install with: pkg install termux-api"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "[*] Installing dependency: jq"
  pkg install jq -y
fi

# Progress bar function
progress_bar() {
  for i in 10 20 30 40 50 60 70 80 90; do
    printf "\r[*] Scanning WiFi networks: [%-10s] %d%%" "##########" "$i"
    sleep 0.15
  done
}

echo
progress_bar &

# Run scan while progress bar animates
termux-wifi-scaninfo 2>/dev/null > /tmp/mforce_wifi.json

wait
printf "\r[*] Scanning WiFi networks: [##########] 100%% ✔\n\n"

RAW_OUTPUT=$(cat /tmp/mforce_wifi.json)
rm -f /tmp/mforce_wifi.json

# Validate JSON
if ! echo "$RAW_OUTPUT" | grep -q '\['; then
  echo "[!] Failed to retrieve WiFi data"
  echo "[!] Check WiFi + Termux:API permissions"
  exit 1
fi

# Output results
echo "$RAW_OUTPUT" | jq -r '
.[] |
"SSID: \(.ssid // "<hidden>")\nBSSID: \(.bssid)\nSignal: \(.level // "unknown") dBm\nSecurity: \(.capabilities)\n------------------------"
'
