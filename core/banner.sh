#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"    
SECOND="\033[38;5;39m"    
MUTED="\033[38;5;240m"    
SUCCESS="\033[38;5;82m"   
BOLD="\033[1m"
NC="\033[0m"

banner() {
  clear
  echo
  echo -e "${BOLD}${ACCENT}mForce${NC} ${MUTED}• MultiForce Security Framework${NC}"
  echo -e "${MUTED}────────────────────────────────────────────────${NC}"
  echo -e "${SECOND}▸${NC} Platform : ${MUTED}Termux (Android)${NC}"
  echo -e "${SECOND}▸${NC} Language : ${MUTED}Shell${NC}"
  echo -e "${SECOND}▸${NC} Mode     : ${MUTED}OSINT / Recon${NC}"
  echo -e "${MUTED}────────────────────────────────────────────────${NC}"
  echo -e "${SUCCESS}Passive · Modular · Android-Native${NC}"
  echo
}
