#!/data/data/com.termux/files/usr/bin/bash

ACCENT="\033[38;5;45m"
INFO="\033[38;5;39m"
SUCCESS="\033[38;5;82m"
WARN="\033[38;5;214m"
MUTED="\033[38;5;240m"
BOLD="\033[1m"
NC="\033[0m"

clear
echo -e "${BOLD}${ACCENT}Username OSINT${NC}"
echo -e "${MUTED}Passive multi-platform username presence check${NC}"
echo

read -p "Enter username: " USER
echo

[[ -z "$USER" ]] && {
  echo -e "${WARN}[!] No username provided${NC}"
  exit 0
}

# -------- Platforms --------
PLATFORMS=(
  "GitHub|https://github.com/$USER"
  "GitLab|https://gitlab.com/$USER"
  "Bitbucket|https://bitbucket.org/$USER"
  "Twitter/X|https://x.com/$USER"
  "Instagram|https://www.instagram.com/$USER"
  "Facebook|https://www.facebook.com/$USER"
  "Reddit|https://www.reddit.com/user/$USER"
  "YouTube|https://www.youtube.com/@$USER"
  "Snapchat|https://www.snapchat.com/add/$USER"
  "TikTok|https://www.tiktok.com/@$USER"
  "Twitch|https://www.twitch.tv/$USER"
  "Steam|https://steamcommunity.com/id/$USER"
  "Pinterest|https://www.pinterest.com/$USER"
  "SoundCloud|https://soundcloud.com/$USER"
  "Spotify|https://open.spotify.com/user/$USER"
  "Medium|https://medium.com/@$USER"
  "Vimeo|https://vimeo.com/$USER"
  "DeviantArt|https://www.deviantart.com/$USER"
  "Flickr|https://www.flickr.com/people/$USER"
  "Pastebin|https://pastebin.com/u/$USER"
  "Keybase|https://keybase.io/$USER"
  "About.me|https://about.me/$USER"
  "ProductHunt|https://www.producthunt.com/@$USER"
  "HackerOne|https://hackerone.com/$USER"
  "Bugcrowd|https://bugcrowd.com/$USER"
)

check_site () {
  NAME="$1"
  URL="$2"
  CODE=$(curl -s -o /dev/null -w "%{http_code}" -L "$URL")

  if [[ "$CODE" == "200" ]]; then
    printf "${SUCCESS}%-12s${NC}: FOUND     " "$NAME"
  else
    printf "${MUTED}%-12s${NC}: Not found " "$NAME"
  fi
}

echo -e "${INFO}Checking platforms...${NC}"
echo

COUNT=0
for ENTRY in "${PLATFORMS[@]}"; do
  NAME="${ENTRY%%|*}"
  URL="${ENTRY##*|}"

  check_site "$NAME" "$URL"
  COUNT=$((COUNT+1))

  # Two-column layout
  if (( COUNT % 2 == 0 )); then
    echo
  fi
done

# Newline if odd count
(( COUNT % 2 != 0 )) && echo

echo
echo -e "${SUCCESS}[*] Username OSINT complete${NC}"
echo -e "${MUTED}Note:${NC} Results based on public HTTP responses only"
