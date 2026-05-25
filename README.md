# M1D WIFI TOOLKIT

```
███╗   ███╗ ██╗ ██████╗
████╗ ████║ ██║ ██╔══██╗
██╔████╔██║ ██║ ██║  ██║   M 1 D   W I F I   T O O L K I T
██║╚██╔╝██║ ██║ ██║  ██║   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
██║ ╚═╝ ██║ ██║ ██████╔╝   WIFI TOOLKIT  ·  GREY HAT EDITION
╚═╝     ╚═╝ ╚═╝ ╚═════╝
```

> **AUTHORIZED PENETRATION TESTING ONLY**  
> Use only on networks you own or have explicit written permission to test.

---

## Overview

**M1D Wifi Toolkit** is a styled, menu-driven Bash toolkit for wireless penetration testing on Kali Linux and Termux. Built for operators who want a clean, fast, and professional terminal UI.

**Creator:** M1D  
**Admin:** [@miidhunee](https://github.com/miidhunraj)  
**Platform:** Kali Linux · Termux (rooted)  
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

## Installation

### Quick Install (Linux & Termux)

```bash
git clone https://github.com/miidhunraj/m1d-wifitools.git
cd m1d-wifitools
chmod +x install.sh
./install.sh
```

The installer auto-detects your environment (Kali Linux or Termux) and:
- Installs required dependencies
- Copies the toolkit to `~/.m1d_wifitools`
- Adds `source` and `alias` lines to `~/.bashrc`
- Creates a global `m1d-wifi` command so you can launch from anywhere

After install, open a new terminal and run:

```bash
m1d-wifi
```

---

### Linux (Kali / Debian / Ubuntu) — Manual

**1. Install dependencies**

```bash
sudo apt update && sudo apt install -y \
  aircrack-ng hcxdumptool hcxtools hashcat \
  macchanger reaver netdiscover iw wireless-tools
```

> A wireless adapter with **packet injection** support is required (e.g. Alfa AWUS036ACH).

**2. Clone and source**

```bash
git clone https://github.com/miidhunraj/m1d-wifitools.git
cd m1d-wifitools
source .m1d_wifitools
```

**3. Enable globally (run from anywhere)**

```bash
echo "source ~/.m1d_wifitools" >> ~/.bashrc
echo "alias m1d-wifi='_wifitools_menu'" >> ~/.bashrc
source ~/.bashrc
```

Then just type `m1d-wifi` in any terminal.

---

### Termux (Android, Rooted) — Manual

> ⚠️ Monitor mode and packet injection require **root** and a compatible USB OTG WiFi adapter (e.g. Alfa AWUS036ACH via OTG).

**1. Update and install base packages**

```bash
pkg update && pkg install -y \
  aircrack-ng macchanger iw wireless-tools
```

> `hcxdumptool`, `reaver`, and `netdiscover` may not be available in Termux repos. For full tool support, use a **Kali NetHunter chroot** or **Kali Linux on a rooted device**.

**2. Clone and source**

```bash
git clone https://github.com/miidhunraj/m1d-wifitools.git
cd m1d-wifitools
source .m1d_wifitools
```

**3. Enable globally**

```bash
echo "source ~/.m1d_wifitools" >> ~/.bashrc
echo "alias m1d-wifi='_wifitools_menu'" >> ~/.bashrc
source ~/.bashrc
```

Or copy a launcher into Termux's bin:

```bash
echo -e '#!/usr/bin/env bash\nsource ~/.m1d_wifitools\n_wifitools_menu' > $PREFIX/bin/m1d-wifi
chmod +x $PREFIX/bin/m1d-wifi
```

Then run `m1d-wifi` from anywhere inside Termux.

---

## Usage

After install, launch with:

```
m1d-wifi
```

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

## Platform Support

| Feature                  | Kali Linux | Termux (rooted) | Termux (unrooted) |
|--------------------------|:----------:|:---------------:|:-----------------:|
| Interface info           | ✅          | ✅               | ✅                 |
| Monitor mode             | ✅          | ✅ (OTG adapter) | ❌                 |
| MAC spoofing             | ✅          | ✅ (root)        | ❌                 |
| Network scan             | ✅          | ✅ (root)        | ❌                 |
| Handshake / PMKID capture| ✅          | ✅ (root)        | ❌                 |
| Deauth                   | ✅          | ✅ (root)        | ❌                 |
| Crack (aircrack/hashcat) | ✅          | ✅               | ✅                 |
| WPS (reaver)             | ✅          | ⚠️ build needed  | ❌                 |

---
## Uninstall
```bash
chmod +x ./uninstall.sh
./uninstall.sh
```
## Requirements

- Bash 4+
- A WiFi adapter supporting **monitor mode** and **packet injection**
- Root / sudo privileges

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
  <b>M1D · WIFI TOOLKIT · GREY HAT EDITION</b><br>
  <i>Initializing wireless operations environment...</i>
</p>
