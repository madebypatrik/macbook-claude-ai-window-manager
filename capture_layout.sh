#!/bin/bash
# capture_layout.sh
# Run with all your dev apps open and positioned exactly how you want them.
# Auto-detects your screen resolution and saves to the correct layout profile.

# Detect current screen width to pick the right profile
SCREEN_W=$(osascript -e 'tell application "Finder" to item 3 of (bounds of window of desktop)' 2>/dev/null)

if [[ "$SCREEN_W" -ge 2560 ]]; then
    PROFILE="4k"
    LAYOUT_FILE="$HOME/.devenv_layout_4k.conf"
else
    PROFILE="1080"
    LAYOUT_FILE="$HOME/.devenv_layout_1080.conf"
fi

> "$LAYOUT_FILE"

capture_direct() {
    local label="$1"
    local app="$2"
    local key="$3"

    bounds=$(osascript 2>/dev/null <<EOF
try
    tell application "$app"
        set b to bounds of front window
        set x1 to item 1 of b
        set y1 to item 2 of b
        set x2 to item 3 of b
        set y2 to item 4 of b
        return (x1 as text) & "," & (y1 as text) & "," & (x2 as text) & "," & (y2 as text)
    end tell
on error
    return ""
end try
EOF
)

    if [[ -n "$bounds" && "$bounds" != "0,0,0,0" ]]; then
        echo "$key=$bounds" >> "$LAYOUT_FILE"
        echo "  ✓ $label: $bounds"
    else
        echo "  ✗ $label: not running or no window found — skipping"
    fi
}

capture_sysevents() {
    local label="$1"
    local process="$2"
    local key="$3"

    bounds=$(osascript 2>/dev/null <<EOF
try
    tell application "System Events"
        set w to first window of process "$process"
        set pos to position of w
        set sz to size of w
        set x1 to item 1 of pos
        set y1 to item 2 of pos
        set x2 to x1 + (item 1 of sz)
        set y2 to y1 + (item 2 of sz)
        return (x1 as text) & "," & (y1 as text) & "," & (x2 as text) & "," & (y2 as text)
    end tell
on error
    return ""
end try
EOF
)

    if [[ -n "$bounds" && "$bounds" != "0,0,0,0" ]]; then
        echo "$key=$bounds" >> "$LAYOUT_FILE"
        echo "  ✓ $label: $bounds"
    else
        echo "  ✗ $label: not running or no window found — skipping"
    fi
}

echo ""
echo "Detected screen width: ${SCREEN_W}px → using profile: $PROFILE"
echo "Make sure all 5 apps are open and positioned the way you want."
echo ""

capture_sysevents "Atlas Browser"  "ChatGPT Atlas"  "atlas"
capture_direct    "Google Chrome"  "Google Chrome"  "chrome"
capture_direct    "Terminal"       "Terminal"       "terminal"
capture_sysevents "Codex"          "Codex"          "codex"
capture_sysevents "VS Code"        "Electron"       "vscode"

echo ""
echo "Saved to: $LAYOUT_FILE"
echo ""
echo "--- Saved layout ($PROFILE) ---"
cat "$LAYOUT_FILE"
echo ""
echo "Run restore_devenv.sh to launch your environment."
