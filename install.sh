#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════╗
# ║       M1D WIFI TOOLKIT — INSTALLER                      ║
# ║       Creator: M1D  |  Admin: @miidhunee                ║
# ║       Supports: Kali Linux & Termux                     ║
# ╚══════════════════════════════════════════════════════════╝

set -e

BBL='\033[1;34m'; BCY='\033[1;36m'; CY='\033[0;36m'
W='\033[1;37m';   DGR='\033[2;37m'; BR='\033[1;31m'
BG='\033[1;32m';  Y='\033[1;33m';   RESET='\033[0m'

TOOLKIT_FILE="$HOME/.m1d_wifitools"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Detect environment ────────────────────────────────────────────────────────
detect_env() {
  if [ -d "/data/data/com.termux" ] || [ -n "$TERMUX_VERSION" ]; then
    ENV="termux"
    SHELL_RC="$HOME/.bashrc"
    PKG_MGR="pkg"
  elif grep -qi "kali" /etc/os-release 2>/dev/null || \
       grep -qi "debian\|ubuntu" /etc/os-release 2>/dev/null; then
    ENV="linux"
    SHELL_RC="$HOME/.bashrc"
    PKG_MGR="apt"
  else
    ENV="linux"
    SHELL_RC="$HOME/.bashrc"
    PKG_MGR="apt"
  fi
}

print_banner() {
  clear
  echo -e "${BBL}"
  echo "  ╔══════════════════════════════════════════════════════════╗"
  echo "  ║  M1D WIFI TOOLKIT — INSTALLER                           ║"
  echo "  ║  Creator: M1D  ·  Admin: @miidhunee                     ║"
  echo "  ╚══════════════════════════════════════════════════════════╝"
  echo -e "${RESET}"
  echo -e "  ${DGR}Detected environment: ${W}${ENV}${RESET}"
  echo ""
}

# ── Install dependencies ──────────────────────────────────────────────────────
install_deps_linux() {
  echo -e "  ${CY}[>>] Installing dependencies via apt...${RESET}\n"
  sudo apt update -qq
  sudo apt install -y \
    aircrack-ng hcxdumptool hcxtools hashcat \
    macchanger reaver netdiscover iw wireless-tools 2>/dev/null \
    && echo -e "  ${BG}[✔]${RESET} Dependencies installed\n" \
    || echo -e "  ${Y}[!] Some packages may have failed — install manually if needed${RESET}\n"
}

install_deps_termux() {
  echo -e "  ${CY}[>>] Installing dependencies via pkg...${RESET}\n"
  echo -e "  ${Y}[!] Note: Termux has limited wireless tool support.${RESET}"
  echo -e "  ${DGR}    Root required for monitor mode / injection tools.${RESET}\n"
  pkg update -y 2>/dev/null
  pkg install -y aircrack-ng macchanger iw wireless-tools 2>/dev/null \
    && echo -e "  ${BG}[✔]${RESET} Base packages installed\n" \
    || echo -e "  ${Y}[!] Some packages unavailable on Termux — use a rooted device or Kali chroot for full support${RESET}\n"
}

# ── Copy toolkit file ─────────────────────────────────────────────────────────
install_toolkit() {
  local src=""

  # Look for toolkit file next to installer first
  for candidate in \
    "$SCRIPT_DIR/m1d-wifitools.txt" \
    "$SCRIPT_DIR/.m1d_wifitools" \
    "$SCRIPT_DIR/m1d_wifitools.sh"
  do
    if [ -f "$candidate" ]; then
      src="$candidate"
      break
    fi
  done

  if [ -n "$src" ]; then
    echo -e "  ${CY}[>>] Installing toolkit from: ${W}$src${RESET}"
    # If it's the raw cat heredoc format, extract the content
    if grep -q "^cat > ~/.m1d_wifitools" "$src" 2>/dev/null; then
      bash "$src"
    else
      cp "$src" "$TOOLKIT_FILE"
    fi
  else
    echo -e "  ${Y}[!] Toolkit source file not found next to installer.${RESET}"
    echo -e "  ${DGR}    Make sure m1d-wifitools.txt (or .m1d_wifitools) is in the same folder as install.sh${RESET}\n"
    echo -e "  ${DGR}    Alternatively, clone the repo and run install.sh from inside it.${RESET}\n"
    exit 1
  fi

  chmod 644 "$TOOLKIT_FILE"
  echo -e "  ${BG}[✔]${RESET} Toolkit installed to ${W}$TOOLKIT_FILE${RESET}\n"
}

# ── Wire into shell RC ────────────────────────────────────────────────────────
setup_shell() {
  local source_line="source ~/.m1d_wifitools"
  local alias_line="alias m1d-wifi='_wifitools_menu'"

  # Remove old entries if present (idempotent)
  sed -i '/\.m1d_wifitools/d' "$SHELL_RC" 2>/dev/null || true
  sed -i "/alias m1d-wifi='/d" "$SHELL_RC" 2>/dev/null || true

  echo "" >> "$SHELL_RC"
  echo "# M1D Wifi Toolkit" >> "$SHELL_RC"
  echo "$source_line" >> "$SHELL_RC"
  echo "$alias_line" >> "$SHELL_RC"

  echo -e "  ${BG}[✔]${RESET} Added to ${W}$SHELL_RC${RESET}"
  echo -e "  ${DGR}      source line : $source_line${RESET}"
  echo -e "  ${DGR}      alias       : m1d-wifi → _wifitools_menu${RESET}\n"
}

# ── Create global launcher ────────────────────────────────────────────────────
setup_launcher() {
  local launcher_path=""

  if [ "$ENV" = "termux" ]; then
    launcher_path="$PREFIX/bin/m1d-wifi"
  elif [ -w "/usr/local/bin" ] || sudo true 2>/dev/null; then
    launcher_path="/usr/local/bin/m1d-wifi"
  fi

  if [ -n "$launcher_path" ]; then
    cat > /tmp/m1d_wifi_launcher << 'LAUNCHER'
#!/usr/bin/env bash
source ~/.m1d_wifitools
_wifitools_menu
LAUNCHER

    if [ "$ENV" = "termux" ]; then
      cp /tmp/m1d_wifi_launcher "$launcher_path"
      chmod +x "$launcher_path"
    else
      sudo cp /tmp/m1d_wifi_launcher "$launcher_path"
      sudo chmod +x "$launcher_path"
    fi

    echo -e "  ${BG}[✔]${RESET} Global command installed: ${W}m1d-wifi${RESET}"
    echo -e "  ${DGR}      Run from anywhere with: m1d-wifi${RESET}\n"
  fi
}

# ── Verify ────────────────────────────────────────────────────────────────────
verify() {
  if [ -f "$TOOLKIT_FILE" ]; then
    echo -e "  ${BG}[✔]${RESET} Toolkit file exists: ${W}$TOOLKIT_FILE${RESET}"
    local fn_count
    fn_count=$(grep -c "^_wt_\|^_wifitools_\|^_m1d_" "$TOOLKIT_FILE" 2>/dev/null || echo "?")
    echo -e "  ${DGR}      Functions loaded: ~$fn_count${RESET}\n"
  else
    echo -e "  ${BR}[✘] Toolkit file missing — installation may have failed${RESET}\n"
  fi
}

# ── Summary ───────────────────────────────────────────────────────────────────
print_summary() {
  echo -e "${BBL}  ╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BBL}  ║  ${BG}INSTALLATION COMPLETE${BBL}                                    ║${RESET}"
  echo -e "${BBL}  ╠══════════════════════════════════════════════════════════╣${RESET}"
  echo -e "${BBL}  ║  ${DGR}To start the toolkit:${RESET}                                   ${BBL}║${RESET}"
  echo -e "${BBL}  ║                                                          ║${RESET}"
  echo -e "${BBL}  ║    ${W}m1d-wifi${RESET}               ${DGR}← from anywhere (new terminal)${RESET}  ${BBL}║${RESET}"
  echo -e "${BBL}  ║    ${W}source ~/.bashrc${RESET}      ${DGR}← activate in current shell${RESET}    ${BBL}║${RESET}"
  echo -e "${BBL}  ║    ${W}_wifitools_menu${RESET}       ${DGR}← after sourcing manually${RESET}      ${BBL}║${RESET}"
  echo -e "${BBL}  ║                                                          ║${RESET}"
  echo -e "${BBL}  ╠══════════════════════════════════════════════════════════╣${RESET}"
  echo -e "${BBL}  ║  ${Y}AUTHORIZED PENETRATION TESTING ONLY${RESET}                     ${BBL}║${RESET}"
  echo -e "${BBL}  ╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
  detect_env
  print_banner

  echo -e "  ${BBL}── STEP 1: Dependencies${RESET}\n"
  if [ "$ENV" = "termux" ]; then
    install_deps_termux
  else
    install_deps_linux
  fi

  echo -e "  ${BBL}── STEP 2: Install Toolkit${RESET}\n"
  install_toolkit

  echo -e "  ${BBL}── STEP 3: Shell Integration${RESET}\n"
  setup_shell

  echo -e "  ${BBL}── STEP 4: Global Launcher${RESET}\n"
  setup_launcher

  echo -e "  ${BBL}── STEP 5: Verify${RESET}\n"
  verify

  print_summary
}

main "$@"
