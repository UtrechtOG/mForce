<div align="center">

# mForce  
### MultiForce Security Framework for Termux

![Platform](https://img.shields.io/badge/platform-termux-black?style=for-the-badge&logo=android)
![Language](https://img.shields.io/badge/language-shell-4EAA25?style=for-the-badge&logo=gnu-bash)
![Status](https://img.shields.io/badge/status-active-success?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

---

**mForce** is a modular **OSINT & security framework** built specifically for **Termux on Android**.  
Designed to be **clean, powerful, realistic and GitHub-safe**.

</div>

---

## ✨ Features

- 📡 WiFi OSINT (passive, no-root)
- 🧩 Modular architecture
- 🛡️ Defensive & educational focus
- 📱 Android & Termux optimized
- 🔄 Easy to extend and maintain

---

## 🛠️ Modules

### WiFi OSINT
- Passive wireless reconnaissance
- SSID, BSSID, security & signal analysis
- Hidden networks detection
- Table-style, readable output
- No packet injection, no attacks

More modules coming soon.

---

## 🚀 Installation

> **Important:**  
> Termux **must be installed via F-Droid**.  
> Play Store versions are **not supported**.

```bash
pkg update -y && pkg upgrade -y
pkg install git termux-api jq -y

git clone https://github.com/UtrechtOG/mForce
cd mForce
chmod +x mforce.sh core/*.sh modules/*.sh
bash mforce.sh
