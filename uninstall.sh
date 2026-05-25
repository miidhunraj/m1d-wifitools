#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════╗
# ║       M1D WIFI TOOLKIT — UNINSTALLER                    ║
# ║       Creator: M1D  |  Admin: @miidhunee                ║
# ╚══════════════════════════════════════════════════════════╝

BBL='\033[1;34m'; BCY='\033[1;36m'; CY='\033[0;36m'
W='\033[1;37m';   DGR='\033[2;37m'; BR='\033[1;31m'
BG='\033[1;32m';  Y='\033[1;33m';   RESET='\033[0m'

TOOLKIT_FILE="$HOME/.m1d_wifitools"
SHELL_RC="$HOME/.bashrc"
INSTAGRAM="https://www.instagram.com/miidhunee"

# ── Open Instagram ────────────────────────────────────────────────────────────
open_instagram() {
  echo -e "\n  ${BCY}╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "  ${BCY}║                                                          ║${RESET}"
  echo -e "  ${BCY}║   ${Y}★  Follow the creator on Instagram!  ★${RESET}               ${BCY}║${RESET}"
  echo -e "  ${BCY}║   ${W}▶  instagram.com/miidhunee${RESET}                            ${BCY}║${RESET}"
  echo -e "  ${BCY}║                                                          ║${RESET}"
  echo -e "  ${BCY}╚══════════════════════════════════════════════════════════╝${RESET}\n"
  echo -e "  ${DGR}Opening Instagram...${RESET}\n"
  sleep 1

  if command -v xdg-open &>/dev/null; then
    xdg-open "$INSTAGRAM" 2>/dev/null &
  elif command -v termux-open-url &>/dev/null; then
    termux-open-url "$INSTAGRAM" 2>/dev/null &
  elif command -v open &>/dev/null; then
    open "$INSTAGRAM" 2>/dev/null &
  elif command -v sensible-browser &>/dev/null; then
    sensible-browser "$INSTAGRAM" 2>/dev/null &
  else
    echo -e "  ${Y}[!] Could not auto-open browser.${RESET}"
    echo -e "  ${DGR}    Visit manually: ${W}$INSTAGRAM${RESET}\n"
  fi
}

print_banner() {
  clear
  echo -e "${BR}"
  echo "  ╔══════════════════════════════════════════════════════════╗"
  echo "  ║  M1D WIFI TOOLKIT — UNINSTALLER                         ║"
  echo "  ║  Creator: M1D  ·  Admin: @miidhunee                     ║"
  echo "  ╚══════════════════════════════════════════════════════════╝"
  echo -e "${RESET}"
}

confirm() {
  echo -e "  ${Y}[!] This will remove the M1D Wifi Toolkit from your system.${RESET}"
  echo -ne "\n  ${W}Are you sure? (y/N): ${RESET}"
  read -r ans
  if [[ ! "$ans" =~ ^[Yy]$ ]]; then
    echo -e "\n  ${DGR}Uninstall cancelled.${RESET}\n"
    exit 0
  fi
  echo ""
}

remove_toolkit_file() {
  echo -e "  ${CY}[>>] Removing toolkit file...${RESET}"
  if [ -f "$TOOLKIT_FILE" ]; then
    rm -f "$TOOLKIT_FILE"
    echo -e "  ${BG}[✔]${RESET} Removed: ${W}$TOOLKIT_FILE${RESET}\n"
  else
    echo -e "  ${DGR}      Not found (already removed): $TOOLKIT_FILE${RESET}\n"
  fi
}

remove_shell_entries() {
  echo -e "  ${CY}[>>] Cleaning shell RC: ${W}$SHELL_RC${RESET}"
  if [ -f "$SHELL_RC" ]; then
    sed -i '/# M1D Wifi Toolkit/d' "$SHELL_RC" 2>/dev/null || true
    sed -i '/\.m1d_wifitools/d'   "$SHELL_RC" 2>/dev/null || true
    sed -i "/alias m1d-wifi=/d"   "$SHELL_RC" 2>/dev/null || true
    echo -e "  ${BG}[✔]${RESET} Shell entries removed from ${W}$SHELL_RC${RESET}\n"
  else
    echo -e "  ${DGR}      $SHELL_RC not found — skipping${RESET}\n"
  fi
}

remove_global_launcher() {
  echo -e "  ${CY}[>>] Removing global launcher...${RESET}"

  local removed=0

  # Linux
  if [ -f "/usr/local/bin/m1d-wifi" ]; then
    sudo rm -f "/usr/local/bin/m1d-wifi"
    echo -e "  ${BG}[✔]${RESET} Removed: ${W}/usr/local/bin/m1d-wifi${RESET}"
    removed=1
  fi

  # Termux
  if [ -n "$PREFIX" ] && [ -f "$PREFIX/bin/m1d-wifi" ]; then
    rm -f "$PREFIX/bin/m1d-wifi"
    echo -e "  ${BG}[✔]${RESET} Removed: ${W}$PREFIX/bin/m1d-wifi${RESET}"
    removed=1
  fi

  if [ "$removed" -eq 0 ]; then
    echo -e "  ${DGR}      Global launcher not found — already removed or never installed${RESET}"
  fi
  echo ""
}

print_summary() {
  echo -e "${BR}  ╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BR}  ║  ${W}M1D WIFI TOOLKIT — UNINSTALLED${BR}                          ║${RESET}"
  echo -e "${BR}  ╠══════════════════════════════════════════════════════════╣${RESET}"
  echo -e "${BR}  ║  ${DGR}Removed:${RESET}                                                ${BR}║${RESET}"
  echo -e "${BR}  ║    ${W}~/.m1d_wifitools${RESET}       ${DGR}← toolkit functions${RESET}           ${BR}║${RESET}"
  echo -e "${BR}  ║    ${W}~/.bashrc entries${RESET}      ${DGR}← source + alias lines${RESET}         ${BR}║${RESET}"
  echo -e "${BR}  ║    ${W}m1d-wifi${RESET} ${DGR}(global)      ← system launcher${RESET}             ${BR}║${RESET}"
  echo -e "${BR}  ╠══════════════════════════════════════════════════════════╣${RESET}"
  echo -e "${BR}  ║  ${DGR}Reload shell to apply changes:${RESET}                          ${BR}║${RESET}"
  echo -e "${BR}  ║    ${W}source ~/.bashrc${RESET}                                       ${BR}║${RESET}"
  echo -e "${BR}  ╠══════════════════════════════════════════════════════════╣${RESET}"
  echo -e "${BR}  ║  ${Y}Thanks for using M1D Wifi Toolkit — @miidhunee${RESET}          ${BR}║${RESET}"
  echo -e "${BR}  ╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
  print_banner
  open_instagram
  confirm

  echo -e "  ${BBL}── STEP 1: Remove Toolkit File${RESET}\n"
  remove_toolkit_file

  echo -e "  ${BBL}── STEP 2: Clean Shell RC${RESET}\n"
  remove_shell_entries

  echo -e "  ${BBL}── STEP 3: Remove Global Launcher${RESET}\n"
  remove_global_launcher

  print_summary
}

main "$@"
