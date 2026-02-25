#!/bin/bash
# ─────────────────────────────────────────────────────────────
# applications_to_open.sh
#
# THIS IS THE ONLY FILE YOU NEED TO EDIT to change your apps.
#
# Add or remove apps by editing the three lists below.
# Just make sure each list has the same number of entries
# and that they stay in the same order.
#
# APP_LAUNCH   → how to open the app (the Terminal command)
# APP_PROCESS  → the app's internal name on macOS (used to move its window)
# APP_KEY      → a short nickname (used in the layout config files)
#
# Not sure what APP_PROCESS to use? Run this in Terminal:
#   osascript -e 'tell application "System Events" to get name of every process whose background only is false'
# ─────────────────────────────────────────────────────────────

APP_LAUNCH=(
    "open '/Applications/ChatGPT Atlas.app'"  # ChatGPT Atlas  (full path needed — space in name)
    "open -a 'Google Chrome'"                  # Google Chrome
    "open -a 'Terminal'"                       # Terminal
    "open -a 'Codex'"                          # Codex
    "open -a 'Visual Studio Code'"             # VS Code
)

APP_PROCESS=(
    "ChatGPT Atlas"   # ChatGPT Atlas
    "Google Chrome"   # Google Chrome
    "Terminal"        # Terminal
    "Codex"           # Codex
    "Electron"        # VS Code runs under the name "Electron" on macOS
)

APP_KEY=(
    "atlas"           # matches the key in .devenv_layout_*.conf
    "chrome"
    "terminal"
    "codex"
    "vscode"
)
