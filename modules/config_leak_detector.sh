#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;82m"
INFO="\033[38;5;39m"
OK="\033[38;5;82m"
WARN="\033[38;5;214m"
DANGER="\033[38;5;196m"
MUTED="\033[38;5;240m"
NC="\033[0m"

clear
echo -e "${ACCENT}Configuration Leak Detector${NC}"
echo -e "${MUTED}Public configuration exposure check${NC}"
echo

read -p "Enter base URL (https://example.com): " URL
echo

[[ -z "$URL" ]] && exit 0

FILES=(
  "/.env"
  "/.git/config"
  "/config.php"
  "/wp-config.php"
  "/settings.py"
  "/docker-compose.yml"
  "/.htaccess"
  "/.htpasswd"
)

for FILE in "${FILES[@]}"; do
  CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL$FILE")

  if [[ "$CODE" == "200" ]]; then
    echo -e "${DANGER}[LEAK]${NC} $FILE (200 OK)"
  elif [[ "$CODE" == "403" ]]; then
    echo -e "${WARN}[PROTECTED]${NC} $FILE (403)"
  else
    echo -e "${MUTED}[-]${NC} $FILE"
  fi
done

echo
echo -e "${OK}[*] Configuration check complete${NC}"
