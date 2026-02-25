#!/bin/bash
# capture_layout.sh
# Run this once with all your dev apps open and positioned exactly how you want them.
# Saves window bounds to ~/.devenv_layout.conf

LAYOUT_FILE="$HOME/.devenv_layout.conf"
> "$LAYOUT_FILE"

# For apps that support AppleScript directly (Atlas, Chrome, Terminal)
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

# For Electron apps that need System Events (Codex, VS Code)
# Stores as x1,y1,x2,y2 (same format as direct capture)
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
echo "Capturing dev environment layout..."
echo "Make sure all 5 apps are open and positioned the way you want."
echo ""

capture_sysevents "Atlas Browser"  "ChatGPT Atlas"   "atlas"
capture_direct    "Google Chrome"  "Google Chrome"   "chrome"
capture_direct    "Terminal"       "Terminal"         "terminal"
capture_sysevents "Codex"          "Codex"            "codex"
capture_sysevents "VS Code"        "Electron"         "vscode"

echo ""
echo "Saved to: $LAYOUT_FILE"
echo ""
echo "--- Saved layout ---"
cat "$LAYOUT_FILE"
echo ""
echo "Now run restore_devenv.sh to launch your environment."
