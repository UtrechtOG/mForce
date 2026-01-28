#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;203m"
INFO="\033[38;5;39m"
OK="\033[38;5;82m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
NC="\033[0m"

clear
echo -e "${ACCENT}Subdomain Enumeration${NC}"
echo -e "${MUTED}Certificate Transparency + DNS checks${NC}"
echo

read -p "Enter domain (example.com): " DOMAIN
echo

[[ -z "$DOMAIN" ]] && exit 0

echo -e "${INFO}Querying certificate transparency...${NC}"
echo

SUBS=$(curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" \
  | jq -r '.[].name_value' 2>/dev/null \
  | sed 's/\*\.//' \
  | sort -u)

[[ -z "$SUBS" ]] && {
  echo -e "${WARN}[!] No subdomains found${NC}"
  exit 0
}

while read -r SUB; do
  if getent hosts "$SUB" > /dev/null; then
    echo -e "${OK}[+]${NC} $SUB"
  else
    echo -e "${MUTED}[-]${NC} $SUB"
  fi
done <<< "$SUBS"

echo
echo -e "${OK}[*] Enumeration complete${NC}"
