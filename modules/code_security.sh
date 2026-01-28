#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
DANGER="\033[38;5;196m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

clear
echo -e "${BOLD}${ACCENT}Code Security Bot${NC}"
echo -e "${MUTED}Static security analysis (defensive)${NC}"
echo

echo "Select language:"
echo "[1] HTML"
echo "[2] JavaScript"
echo "[3] CSS"
read -p "> " LANG
echo

echo -e "${INFO}Paste your code below."
echo -e "${MUTED}Finish with CTRL+D${NC}"
echo

CODE=$(cat)

[[ -z "$CODE" ]] && {
  echo -e "${WARN}[!] No code provided${NC}"
  exit 0
}

ISSUES=0

check () {
  PATTERN="$1"
  MESSAGE="$2"
  SEVERITY="$3"

  if echo "$CODE" | grep -qiE "$PATTERN"; then
    ((ISSUES++))
    if [[ "$SEVERITY" == "high" ]]; then
      echo -e "${DANGER}[HIGH]${NC} $MESSAGE"
    else
      echo -e "${WARN}[MEDIUM]${NC} $MESSAGE"
    fi
  fi
}

echo -e "${INFO}Scanning...${NC}"
echo

case "$LANG" in
  1)
    check "innerHTML" "Use of innerHTML can lead to XSS" high
    check "onclick=" "Inline JS handlers increase XSS risk" medium
    check "<iframe" "Iframe detected — consider sandbox attribute" medium
    check "<form" "Form detected — ensure POST & CSRF protection" medium
    ;;
  2)
    check "eval\(" "eval() enables code injection" high
    check "document.write" "document.write is unsafe" high
    check "innerHTML" "innerHTML can lead to DOM-XSS" high
    check "setTimeout\(\"" "setTimeout with string is dangerous" medium
    check "fetch\(" "Ensure proper input validation & CORS handling" medium
    ;;
  3)
    check "expression\(" "CSS expressions allow code execution (legacy)" high
    check "@import" "External CSS imports may leak data" medium
    check "javascript:" "javascript: URLs enable XSS" high
    ;;
  *)
    echo -e "${WARN}[!] Invalid language selection${NC}"
    exit 0
    ;;
esac

echo
if [[ "$ISSUES" -eq 0 ]]; then
  echo -e "${SUCCESS}[✓] No obvious security issues detected${NC}"
else
  echo -e "${DANGER}[!] Issues found:${NC} $ISSUES"
fi

echo
echo -e "${MUTED}Note:${NC} Static analysis only — manual review still recommended"
