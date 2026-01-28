#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

clear
echo -e "${BOLD}${ACCENT}Domain OSINT${NC}"
echo -e "${MUTED}Passive domain & DNS intelligence${NC}"
echo

read -p "Enter domain (example.com): " DOMAIN
echo

[[ -z "$DOMAIN" ]] && {
  echo -e "${WARN}[!] No domain provided${NC}"
  exit 0
}

# Ensure dependencies
command -v curl >/dev/null 2>&1 || pkg install curl -y
command -v jq >/dev/null 2>&1 || pkg install jq -y

# -------- DNS LOOKUPS --------
DNS_JSON=$(curl -s "https://dns.google/resolve?name=$DOMAIN&type=ANY")

STATUS=$(echo "$DNS_JSON" | jq -r '.Status')
[[ "$STATUS" != "0" ]] && {
  echo -e "${WARN}[!] DNS lookup failed${NC}"
  exit 0
}

echo -e "${INFO}DNS Records${NC}"

A=$(echo "$DNS_JSON" | jq -r '.Answer[]? | select(.type==1) | .data')
AAAA=$(echo "$DNS_JSON" | jq -r '.Answer[]? | select(.type==28) | .data')
MX=$(echo "$DNS_JSON" | jq -r '.Answer[]? | select(.type==15) | .data')
NS=$(echo "$DNS_JSON" | jq -r '.Answer[]? | select(.type==2) | .data')

[[ -n "$A" ]] && echo -e "  A Records      :\n$(echo "$A" | sed 's/^/    - /')"
[[ -n "$AAAA" ]] && echo -e "  AAAA Records   :\n$(echo "$AAAA" | sed 's/^/    - /')"
[[ -n "$MX" ]] && echo -e "  MX Records     :\n$(echo "$MX" | sed 's/^/    - /')"
[[ -n "$NS" ]] && echo -e "  NS Records     :\n$(echo "$NS" | sed 's/^/    - /')"

echo

# -------- HTTPS / TLS --------
echo -e "${INFO}HTTPS / TLS${NC}"
HTTPS_STATUS=$(curl -Is "https://$DOMAIN" | head -n 1)

if echo "$HTTPS_STATUS" | grep -q "200"; then
  echo "  HTTPS Enabled  : Yes"
else
  echo "  HTTPS Enabled  : Unclear / Redirect"
fi

echo

# -------- TECH INFERENCE --------
echo -e "${INFO}Technology Indicators${NC}"

TECH="Unknown"

echo "$NS" | grep -qi "cloudflare" && TECH="Cloudflare CDN"
echo "$MX" | grep -qi "google" && TECH="Google Workspace"
echo "$MX" | grep -qi "outlook\|microsoft" && TECH="Microsoft 365"
echo "$NS" | grep -qi "aws" && TECH="AWS Hosted"
echo "$NS" | grep -qi "azure" && TECH="Azure Hosted"

echo "  Detected Tech  : $TECH"

echo

# -------- CONTEXT --------
CATEGORY="Standard Domain"
[[ "$TECH" != "Unknown" ]] && CATEGORY="Managed / Cloud-based"

echo -e "${SUCCESS}Context Summary${NC}"
echo -e "  Domain Type    : $CATEGORY"
echo -e "  Infrastructure : $TECH"
echo
echo -e "${SUCCESS}[*] Domain OSINT complete${NC}"
