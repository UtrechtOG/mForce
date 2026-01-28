#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

clear
echo -e "${BOLD}${ACCENT}IP / Network OSINT${NC}"
echo -e "${MUTED}Passive internet-based reconnaissance${NC}"
echo

read -p "Enter IP address or domain: " TARGET
echo

[[ -z "$TARGET" ]] && {
  echo -e "${WARN}[!] No target provided${NC}"
  exit 0
}

# Resolve domain → IP if needed
IP="$TARGET"
if [[ "$TARGET" =~ [a-zA-Z] ]]; then
  IP=$(getent hosts "$TARGET" | awk '{print $1}' | head -n1)
  if [[ -z "$IP" ]]; then
    echo -e "${WARN}[!] Failed to resolve domain${NC}"
    exit 0
  fi
fi

# Query public OSINT API (no key needed)
DATA=$(curl -s "http://ip-api.com/json/$IP?fields=status,message,continent,country,regionName,city,zip,lat,lon,isp,org,as,reverse,mobile,proxy,hosting")

STATUS=$(echo "$DATA" | jq -r '.status')
[[ "$STATUS" != "success" ]] && {
  echo -e "${WARN}[!] Lookup failed${NC}"
  exit 0
}

# Extract
COUNTRY=$(echo "$DATA" | jq -r '.country')
REGION=$(echo "$DATA" | jq -r '.regionName')
CITY=$(echo "$DATA" | jq -r '.city')
ISP=$(echo "$DATA" | jq -r '.isp')
ORG=$(echo "$DATA" | jq -r '.org')
ASN=$(echo "$DATA" | jq -r '.as')
REVERSE=$(echo "$DATA" | jq -r '.reverse')
MOBILE=$(echo "$DATA" | jq -r '.mobile')
PROXY=$(echo "$DATA" | jq -r '.proxy')
HOSTING=$(echo "$DATA" | jq -r '.hosting')

# Context inference
TYPE="Residential / ISP"
[[ "$HOSTING" == "true" ]] && TYPE="Datacenter / Hosting"
[[ "$MOBILE" == "true" ]] && TYPE="Mobile Network"
[[ "$PROXY" == "true" ]] && TYPE="Proxy / VPN Suspected"

# Output
echo -e "${ACCENT}Target${NC}        : $TARGET"
echo -e "${ACCENT}Resolved IP${NC}   : $IP"
echo
echo -e "${INFO}Location${NC}"
echo -e "  Country          : $COUNTRY"
echo -e "  Region           : $REGION"
echo -e "  City             : $CITY"
echo
echo -e "${INFO}Network${NC}"
echo -e "  ISP              : $ISP"
echo -e "  Organization     : $ORG"
echo -e "  ASN              : $ASN"
echo
echo -e "${INFO}Technical${NC}"
echo -e "  Reverse DNS      : $REVERSE"
echo -e "  Network Type     : $TYPE"
echo
echo -e "${SUCCESS}[*] IP OSINT lookup complete${NC}"
