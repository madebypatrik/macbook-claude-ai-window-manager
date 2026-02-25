# 🖥️ macOS Dev Environment Window Manager

[![macOS](https://img.shields.io/badge/macOS-Sequoia+-black.svg)](https://www.apple.com/macos/)
[![Shell](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **Save your perfect window layout once — restore it instantly, every time**

## 💡 For Non-Technical Users

**Think of this as a memory for your Mac. It remembers exactly where every window lives and puts them back in seconds.**

🔍 **The Problem**: Every morning you open your Mac and spend 5 minutes dragging windows around — resizing your browser, repositioning your terminal, getting VS Code back to where you like it. Every. Single. Day.

✨ **The Solution**: Set up your windows exactly how you want them once, save the layout, and from that point on a single command restores everything instantly.

### Real Example
- **You run**: `bash restore_devenv.sh`
- **What happens**: All 5 apps open automatically and snap into their exact saved positions — left side, right side, perfectly sized — in seconds
- **You get**: Your full dev environment ready to go, no manual rearranging

**Perfect for**: Developers, designers, or anyone who opens the same set of apps every day and wants them exactly where they expect them.

## ⚡ What This Does

- 🧠 **Remembers your layout** — Saves the exact position and size of every window
- ⚡ **One command restore** — Opens all 5 apps and arranges them automatically
- 📐 **Pixel-perfect positioning** — Windows land exactly where you saved them
- 🔄 **Update anytime** — Rearrange your windows and re-save whenever you want
- 🍎 **Mac-native** — Uses built-in macOS tools, nothing to install

## 🖥️ My Layouts

The script auto-detects your screen resolution and loads the right layout automatically.

### 3200x1800 (4K — split layout)

| App | Position |
|-----|----------|
| 🌐 ChatGPT Atlas | Left half |
| 🤖 Codex | Left half |
| 🌍 Google Chrome | Right half |
| 💻 Terminal | Right half |
| 📝 VS Code | Right half |

### 1920x1080 (fullscreen — all windows maximised)

All 5 apps open full size. Switch between them with `Cmd+Tab`.

Want different apps? See [Customising for Your Setup](#-customising-for-your-setup) below.

## 🚀 Quick Start

### What You Need
- A Mac running macOS
- Your apps already installed
- 5 minutes to set it up once

### Setup

**1. Download the scripts**
```bash
git clone https://github.com/madebypatrik/macbook-claude-ai-window-manager.git
cd macbook-claude-ai-window-manager
```

**2. Grant Accessibility permission** *(one-time only)*

Go to: `System Settings → Privacy & Security → Accessibility` → click `+` → add `Terminal.app` → toggle it on.

This allows the script to move and resize windows on your behalf.

**3. Open your apps and position them how you want**

Arrange all your windows exactly the way you like them.

**4. Save your layout**
```bash
bash capture_layout.sh
```

**5. Done! Restore anytime with:**
```bash
bash restore_devenv.sh
```

## 🎬 Day-to-Day Use

From now on, whenever you want your environment set up:

```bash
bash restore_devenv.sh
```

That's it. All apps open and snap into place.

**To save a new layout** (if you've rearranged things):
```bash
bash capture_layout.sh
```

## 🛠️ Customising for Your Setup

Layouts are saved in resolution-specific config files:

- `.devenv_layout_4k.conf` — used when screen width ≥ 2560px
- `.devenv_layout_1080.conf` — used for smaller screens (auto-generated fullscreen if missing)

Each line stores one app's window position as `x1,y1,x2,y2`:
```
atlas=-1,30,1600,1698
chrome=1600,30,3200,1698
```

To change which apps are managed, open `capture_layout.sh` and `restore_devenv.sh` and swap out the app names for your own.

## 🤝 Contributing

Got improvements or want to add support for more apps? Contributions welcome!
1. Fork the repository
2. Create your feature branch
3. Submit a pull request

## 📄 License

MIT License - Free to use and modify

---

⭐ **Star this repo if it saves you time every morning!**

*Built by [@madebypatrik](https://github.com/madebypatrik) - Built with [Claude Code](https://claude.ai/claude-code)*
