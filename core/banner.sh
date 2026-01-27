#!/data/data/com.termux/files/usr/bin/bash

source core/colors.sh

banner() {
  clear
  echo -e "${CYAN}"
  echo "███╗     ███╗██████╗  ██████╗ █████╗     ██████╗  ███████╗"
  echo "████╗  ████║██╔════██╔═   ██╔█══  █╗   ██╔════╝ ██╔════╝"
  echo "██╔████╔██║█████╗  ██║     ██║█  ██║    ██║          █████╗  "
  echo "██║╚██╔╝██║██╔══╝  ██║     ██║█  ██║     ██║         ██╔══╝  "
  echo "██║ ╚═╝  ██  ██╗        ╚██████╗█     █╔     ██████╗  ███████╗"
  echo "╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝╚══════╝"
  echo -e "${NC}"
  echo -e "${YELLOW}MultiForce Security Framework for Termux${NC}"
  echo
}
