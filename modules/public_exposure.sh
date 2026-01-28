#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;203m"
INFO="\033[38;5;39m"
OK="\033[38;5;82m"
WARN="\033[38;5;214m"
DANGER="\033[38;5;196m"
MUTED="\033[38;5;240m"
NC="\033[0m"

clear
echo -e "${ACCENT}Public Exposure Scanner${NC}"
echo -e "${MUTED}Sensitive public endpoints discovery${NC}"
echo

read -p "Enter base URL (https://example.com): " URL
echo

[[ -z "$URL" ]] && exit 0

PATHS=(
  "/.git/config"
  "/.env"
  "/backup"
  "/old"
  "/test"
  "/admin"
  "/phpinfo.php"
  "/debug"
  "/.DS_Store"
)

for P in "${PATHS[@]}"; do
  CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL$P")

  if [[ "$CODE" == "200" ]]; then
    echo -e "${DANGER}[EXPOSED]${NC} $P (200)"
  elif [[ "$CODE" == "403" ]]; then
    echo -e "${WARN}[RESTRICTED]${NC} $P (403)"
  else
    echo -e "${MUTED}[-]${NC} $P"
  fi
done

echo
echo -e "${OK}[*] Scan complete${NC}"
