#!/data/data/com.termux/files/usr/bin/bash

echo "[*] WiFi OSINT - Passive Recon"
echo

if ! command -v iw >/dev/null 2>&1; then
  echo "[*] Installing dependency: iw"
  pkg install iw -y
fi

interfaces=$(iw dev 2>/dev/null | grep Interface | awk '{print $2}')

if [ -z "$interfaces" ]; then
  echo "[!] No wireless interface found"
  echo "[!] Root or compatible device required"
  exit 1
fi

for iface in $interfaces; do
  echo "[+] Interface: $iface"
  iw dev "$iface" scan 2>/dev/null | \
  grep -E "BSS|SSID|signal" | sed 's/\t//g'
  echo "---------------------------"
done
