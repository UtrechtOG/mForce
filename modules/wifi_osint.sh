#!/data/data/com.termux/files/usr/bin/bash

echo "[*] mForce WiFi OSINT (No-Root Mode)"
echo "[*] Using Android WiFi API"
echo

if ! command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "[!] termux-api not installed"
  echo "[*] Install with: pkg install termux-api"
  echo "[*] Install the Termux:API app from Play Store or F-Droid"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "[*] Installing dependency: jq"
  pkg install jq -y
fi

echo "[*] Scanning nearby WiFi networks..."
echo

RAW_OUTPUT=$(termux-wifi-scaninfo 2>/dev/null)

if ! echo "$RAW_OUTPUT" | grep -q '^\['; then
  echo "[!] Failed to retrieve WiFi data"
  echo "[!] Make sure WiFi is enabled"
  echo "[!] Make sure Termux:API app is installed"
  exit 1
fi

echo "$RAW_OUTPUT" | jq -r '
.[] |
"SSID: \(.ssid // "Hidden")\nBSSID: \(.bssid)\nSignal: \(.level) dBm\nSecurity: \(.capabilities)\n------------------------"
'
