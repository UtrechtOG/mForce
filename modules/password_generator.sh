#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

clear
echo -e "${BOLD}${ACCENT}Secure Password Generator${NC}"
echo -e "${MUTED}Cryptographically strong password creation${NC}"
echo

read -p "Password length (recommended 16+): " LENGTH
[[ -z "$LENGTH" || "$LENGTH" -lt 8 ]] && LENGTH=16

echo
echo "Character set:"
echo "[1] Letters + Numbers"
echo "[2] Letters + Numbers + Symbols (recommended)"
read -p "> " MODE
echo

CHARSET='A-Za-z0-9'
[[ "$MODE" == "2" ]] && CHARSET='A-Za-z0-9!@#$%^&*()-_=+[]{}<>?'

PASSWORD=$(tr -dc "$CHARSET" < /dev/urandom | head -c "$LENGTH")

# Entropy estimation (rough but useful)
CHARSET_SIZE=$(echo "$CHARSET" | wc -c)
ENTROPY=$(awk "BEGIN { printf \"%.1f\", log($CHARSET_SIZE)/log(2) * $LENGTH }")

echo -e "${SUCCESS}Generated Password${NC}"
echo -e "${BOLD}$PASSWORD${NC}"
echo
echo -e "${INFO}Length${NC}   : $LENGTH"
echo -e "${INFO}Entropy${NC}  : ~$ENTROPY bits"
echo -e "${INFO}Strength${NC} : Strong"
echo
echo -e "${MUTED}Note:${NC} Password not stored or logged"
