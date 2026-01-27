#!/data/data/com.termux/files/usr/bin/bash

echo "[*] mForce WiFi OSINT (No-Root Mode)"
echo "[*] Using Android WiFi API"
echo

# Check for termux-api
if ! command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "[!] termux-api not installed"
  echo "[*] Install with: pkg install termux-api"
  echo "[*] Also install the Termux:API app from F-Droid"
  exit 1
fi

# Check for jq
if ! command -v jq >/dev/null 2>&1; then
  echo "[*] Installing dependency: jq"
  pkg install jq -y
fi

echo "[*] Scanning nearby WiFi networks..."
echo

# Get raw output
RAW_OUTPUT=$(termux-wifi-scaninfo 2>/dev/null)

# Validate JSON presence
if ! echo "$RAW_OUTPUT" | grep -q '\['; then
  echo "[!] Failed to retrieve WiFi data"
  echo "[!] Make sure:"
  echo "    - WiFi is enabled"
  echo "    - Termux:API app is installed (F-Droid)"
  echo "    - Location permission is granted"
  exit 1
fi

# Parse and display results
echo "$RAW_OUTPUT" | jq -r '
.[] |
"SSID: \(.ssid // "Hidden")\nBSSID: \(.bssid)\nSignal: \(.level) dBm\nSecurity: \(.capabilities)\n------------------------"
'
