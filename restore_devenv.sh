#!/bin/bash
# restore_devenv.sh
# Launches and arranges your 5 dev apps.
# Auto-detects screen resolution and uses the correct layout profile.
# Run with: bash ~/development/claude/restore_devenv.sh

# Detect current screen width to pick the right profile
SCREEN_W=$(osascript -e 'tell application "Finder" to item 3 of (bounds of window of desktop)' 2>/dev/null)
SCREEN_H=$(osascript -e 'tell application "Finder" to item 4 of (bounds of window of desktop)' 2>/dev/null)

if [[ "$SCREEN_W" -ge 2560 ]]; then
    PROFILE="4k"
    LAYOUT_FILE="$HOME/.devenv_layout_4k.conf"
else
    PROFILE="1080"
    LAYOUT_FILE="$HOME/.devenv_layout_1080.conf"
    # Auto-generate fullscreen layout for 1080p if it doesn't exist
    if [[ ! -f "$LAYOUT_FILE" ]]; then
        MENU_BAR=25
        cat > "$LAYOUT_FILE" <<EOF
atlas=0,${MENU_BAR},${SCREEN_W},${SCREEN_H}
chrome=0,${MENU_BAR},${SCREEN_W},${SCREEN_H}
terminal=0,${MENU_BAR},${SCREEN_W},${SCREEN_H}
codex=0,${MENU_BAR},${SCREEN_W},${SCREEN_H}
vscode=0,${MENU_BAR},${SCREEN_W},${SCREEN_H}
EOF
        echo "Generated fullscreen layout for ${SCREEN_W}x${SCREEN_H}."
    fi
fi

if [[ ! -f "$LAYOUT_FILE" ]]; then
    echo "Layout file not found: $LAYOUT_FILE"
    echo "Please run capture_layout.sh first."
    exit 1
fi

echo "Launching dev environment ($PROFILE)..."

# Launch all apps at once
open '/Applications/ChatGPT Atlas.app'
open -a 'Google Chrome'
open -a 'Terminal'
open -a 'Codex'
open -a 'Visual Studio Code'

# Read saved bounds
read_bounds() {
    grep "^$1=" "$LAYOUT_FILE" | cut -d= -f2
}

ATLAS=$(read_bounds atlas)
CHROME=$(read_bounds chrome)
TERMINAL=$(read_bounds terminal)
CODEX=$(read_bounds codex)
VSCODE=$(read_bounds vscode)

osascript <<EOF
on parseBounds(b)
    set AppleScript's text item delimiters to ","
    set parts to text items of b
    set AppleScript's text item delimiters to ""
    set x1 to (item 1 of parts) as integer
    set y1 to (item 2 of parts) as integer
    set x2 to (item 3 of parts) as integer
    set y2 to (item 4 of parts) as integer
    return {{x1, y1}, {x2 - x1, y2 - y1}}
end parseBounds

on waitForProcess(pName, maxWait)
    set attempts to 0
    repeat while attempts < maxWait
        try
            tell application "System Events"
                if (count of windows of process pName) > 0 then exit repeat
            end tell
        end try
        delay 1
        set attempts to attempts + 1
    end repeat
end waitForProcess

on applyLayout(pName, pos, sz)
    repeat 2 times
        try
            tell application "System Events"
                set theWin to first window of process pName
                set size of theWin to sz
                set position of theWin to pos
                set size of theWin to sz
            end tell
        end try
        delay 0.5
    end repeat
end applyLayout

my waitForProcess("ChatGPT Atlas", 30)
my waitForProcess("Google Chrome", 20)
my waitForProcess("Terminal", 15)
my waitForProcess("Codex", 20)
my waitForProcess("Electron", 20)

delay 1

set atlasData    to my parseBounds("$ATLAS")
set chromeData   to my parseBounds("$CHROME")
set termData     to my parseBounds("$TERMINAL")
set codexData    to my parseBounds("$CODEX")
set vscodeData   to my parseBounds("$VSCODE")

my applyLayout("ChatGPT Atlas", item 1 of atlasData,  item 2 of atlasData)
my applyLayout("Google Chrome", item 1 of chromeData, item 2 of chromeData)
my applyLayout("Terminal",      item 1 of termData,   item 2 of termData)
my applyLayout("Codex",         item 1 of codexData,  item 2 of codexData)
my applyLayout("Electron",      item 1 of vscodeData, item 2 of vscodeData)
EOF

echo "Done."
