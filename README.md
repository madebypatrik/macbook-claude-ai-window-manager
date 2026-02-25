# 🖥️ macOS Dev Environment Window Manager

[![macOS](https://img.shields.io/badge/macOS-Sequoia+-black.svg)](https://www.apple.com/macos/)
[![Shell](https://img.shields.io/badge/Shell-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **Save your perfect window layout once — restore it instantly, every time**

## 💡 For Non-Technical Users

**Think of this as a memory for your Mac. It remembers exactly where every window lives and puts them back in seconds.**

🔍 **The Problem**: Every morning you open your Mac and spend 5 minutes dragging windows around — resizing your browser, repositioning your terminal, getting VS Code back to where you like it. Every. Single. Day.

✨ **The Solution**: Set up your windows exactly how you want them once, save the layout, and from that point on a single command restores everything instantly.

**Perfect for**: Developers, designers, or anyone who opens the same set of apps every day and wants them exactly where they expect them.

## 🤖 Recommended: Use Claude Code

The easiest way to use this is with **[Claude Code](https://claude.ai/claude-code)** — an AI assistant that runs in your Terminal.

Instead of memorising commands, you just tell it what you want in plain English:

> *"Open my dev environment"*

> *"Save my current window layout"*

> *"I've moved my windows around, save the new layout"*

> *"Switch to my 1080p layout"*

Claude handles the rest — running the right scripts, saving changes, and keeping everything up to date. No commands to remember.

## ⚡ What This Does

- 🧠 **Remembers your layout** — Saves the exact position and size of every window
- ⚡ **One command restore** — Opens all your apps and arranges them automatically
- 📐 **Pixel-perfect positioning** — Windows land exactly where you saved them
- 🖥️ **Multiple screen profiles** — Different layouts for different resolutions, auto-detected
- 🍎 **Mac-native** — Uses built-in macOS tools, nothing extra to install

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

## 🚀 Quick Start

### What You Need
- A Mac running macOS
- Your apps already installed
- [Claude Code](https://claude.ai/claude-code) *(recommended)*

### Setup

**1. Download the scripts**
```bash
git clone https://github.com/madebypatrik/macbook-claude-ai-window-manager.git
cd macbook-claude-ai-window-manager
```

**2. Grant Accessibility permission** *(one-time only)*

Go to: `System Settings → Privacy & Security → Accessibility` → click `+` → add `Terminal.app` → toggle it on.

This allows the script to move and resize windows on your behalf.

**3. Open your apps and position them how you want, then save the layout**
```bash
bash capture_layout.sh
```

**4. Done! Restore anytime with:**
```bash
bash restore_devenv.sh
```

## 🎬 Day-to-Day Use

### With Claude Code *(recommended)*
Just tell Claude what you want:
- *"Open my dev environment"* → launches and arranges everything
- *"My windows are how I want them, save the layout"* → captures and saves automatically
- *"Add Slack to my environment"* → Claude edits the config and updates everything

### Without Claude Code
```bash
bash restore_devenv.sh    # open your environment
bash capture_layout.sh    # save a new layout
```

## 🛠️ Customising for Your Setup

To add or remove apps, edit **`applications_to_open.sh`** — that's the only file you need to touch. It has clear instructions inside.

Layout positions are saved in:
- `.devenv_layout_4k.conf` — for screens 2560px wide or more
- `.devenv_layout_1080.conf` — for smaller screens (auto-generated fullscreen if missing)

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
