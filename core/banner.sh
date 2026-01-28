#!/data/data/com.termux/files/usr/bin/bash

# Colors
CYAN="\033[38;5;51m"
GREEN="\033[38;5;82m"
GRAY="\033[38;5;245m"
BOLD="\033[1m"
NC="\033[0m"

banner() {
  clear
  echo
  echo -e "${BOLD}${CYAN}mForce${NC} ${GRAY}— MultiForce Security Framework${NC}"
  echo -e "${GRAY}Platform:${NC} Termux  ${GRAY}|${NC}  ${GRAY}Language:${NC} Shell  ${GRAY}|${NC}  ${GRAY}Mode:${NC} OSINT"
  echo -e "${GRAY}------------------------------------------------------------${NC}"
  echo -e "${GREEN}Passive. Modular. Android-native.${NC}"
  echo
}
