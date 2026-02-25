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

---

### Option 1 — With Claude Code *(recommended)*

**1. Install Claude Code**

Follow the instructions at [claude.ai/claude-code](https://claude.ai/claude-code), then open Terminal and start a Claude session in your projects folder.

**2. Grant Accessibility permission** *(one-time only)*

Go to: `System Settings → Privacy & Security → Accessibility` → click `+` → add `Terminal.app` → toggle it on.

**3. Just tell Claude what to do**

> *"Clone https://github.com/madebypatrik/macbook-claude-ai-window-manager.git and set up my window environment"*

Claude will clone the repo, run the setup, and save your layout. From that point on you can just say:

> *"Open my dev environment"*
> *"My windows are how I want them, save the new layout"*
> *"Add Slack to my apps"*

No commands to remember — Claude handles everything.

---

### Option 2 — Without AI

**1. Download the scripts**
```bash
git clone https://github.com/madebypatrik/macbook-claude-ai-window-manager.git
cd macbook-claude-ai-window-manager
```

**2. Grant Accessibility permission** *(one-time only)*

Go to: `System Settings → Privacy & Security → Accessibility` → click `+` → add `Terminal.app` → toggle it on.

**3. Open your apps, position them how you want, then save the layout**
```bash
bash capture_layout.sh
```

**4. Restore anytime with:**
```bash
bash restore_devenv.sh
```

## 🎬 Day-to-Day Use

### With Claude Code
- *"Open my dev environment"* → launches and arranges everything
- *"Save my current layout"* → captures your window positions
- *"Add Slack to my environment"* → Claude updates the config for you

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
