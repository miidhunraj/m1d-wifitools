# M1D WIFI TOOLKIT

```
███╗   ███╗ ██╗ ██████╗
████╗ ████║ ██║ ██╔══██╗
██╔████╔██║ ██║ ██║  ██║   M 1 D   W I F I   T O O L K I T
██║╚██╔╝██║ ██║ ██║  ██║   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
██║ ╚═╝ ██║ ██║ ██████╔╝   WIFI TOOLKIT  ·  AUTO EDITION
╚═╝     ╚═╝ ╚═╝ ╚═════╝
```

> **AUTHORIZED PENETRATION TESTING ONLY**  
> Use only on networks you own or have explicit written permission to test.

---

## Overview

**M1D Wifi Toolkit** is a styled, menu-driven Bash toolkit for wireless penetration testing on Kali Linux. Built for auto operators who want a clean, fast, and professional terminal UI.

**Creator:** M1D  
**Admin:** [@miidhunee](https://github.com/miidhunraj)  
**Platform:** Kali Linux  
**Build:** M1D PRIVATE EDITION

---

## Features

| Category     | Tools                                              |
|--------------|----------------------------------------------------|
| Interface    | Monitor mode, MAC spoofing, interface info         |
| Recon        | Network scan, client scan, passive discovery       |
| Capture      | WPA handshake, PMKID, deauth frames                |
| Crack        | aircrack-ng, hashcat (WPA / PMKID)                 |
| Misc         | WPS attack (reaver), process management            |

---

## Requirements

```bash
sudo apt update && sudo apt install -y \
  aircrack-ng hcxdumptool hcxtools hashcat \
  macchanger reaver netdiscover iw wireless-tools
```

> A wireless adapter that supports **packet injection** is required (e.g. Alfa AWUS036ACH).

---

## Installation

```bash
# 1. Clone the repo
git clone https://github.com/miidhunraj/m1d-wifitools.git
cd m1d-wifitools

# 2. Source the toolkit
source .m1d-wifitools

# 3. Launch
_wifitools_menu
```

**Auto-load on every terminal:**
```bash
echo "source ~/.m1d-wifitools" >> ~/.bashrc
echo "alias wi='_wifitools_menu'" >> ~/.bashrc
source ~/.bashrc
```

Then just type `wi` anywhere.

---

## Usage

```
  ── INTERFACE ──────────────────────────────────────
  [1]  Enable monitor mode
  [2]  Disable monitor mode
  [3]  Change MAC address
  [4]  Restore real MAC
  [5]  Show interface info

  ── RECON ───────────────────────────────────────────
  [6]  Scan nearby networks
  [7]  Scan clients on network
  [8]  Passive discovery

  ── CAPTURE ─────────────────────────────────────────
  [9]  Capture WPA handshake
  [10] Capture PMKID
  [11] Deauth clients

  ── CRACK ───────────────────────────────────────────
  [12] Crack with aircrack-ng
  [13] Crack WPA with hashcat
  [14] Crack PMKID with hashcat

  ── MISC ────────────────────────────────────────────
  [15] WPS attack (reaver)
  [16] Kill interfering processes
  [17] Restart NetworkManager
```

---

## Disclaimer

This tool is intended **exclusively** for:
- Networks you personally own
- Authorized penetration testing engagements (written permission required)
- Controlled lab/CTF environments

Unauthorized use against networks you do not own is **illegal** under computer fraud and abuse laws in most jurisdictions. The author assumes **zero liability** for misuse.

---

## License

MIT License — see [LICENSE](LICENSE) for details.

---

<p align="center">
  <b>M1D · WIFI TOOLKIT · AUTO EDITION</b><br>
  <i>Initializing wireless operations environment...</i>
</p>
