#!/data/data/com.termux/files/usr/bin/bash

echo "[*] mForce WiFi OSINT (No-Root Mode)"
echo "[*] Using Android WiFi API"
echo

if ! command -v termux-wifi-scaninfo >/dev/null 2>&1; then
  echo "[!] termux-api not installed"
  echo "[*] Install with: pkg install termux-api"
  exit 1
fi

echo "[*] Scanning nearby WiFi networks..."
echo

termux-wifi-scaninfo | jq -r '
.[] |
"SSID: \(.ssid // "Hidden")\nBSSID: \(.bssid)\nSignal: \(.level) dBm\nSecurity: \(.capabilities)\n------------------------"
'
