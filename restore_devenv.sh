#!/bin/bash
# ─────────────────────────────────────────────────────────────
# restore_devenv.sh
#
# Run this to launch and arrange your dev environment.
# It auto-detects your screen resolution and restores
# the right window layout automatically.
#
# Usage: bash restore_devenv.sh
# ─────────────────────────────────────────────────────────────

source "$(dirname "$0")/applications_to_open.sh"

# Detect current screen size to pick the right profile
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
        for key in "${APP_KEY[@]}"; do
            echo "$key=0,${MENU_BAR},${SCREEN_W},${SCREEN_H}" >> "$LAYOUT_FILE"
        done
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
for launch_cmd in "${APP_LAUNCH[@]}"; do
    eval "$launch_cmd"
done

# Read bounds for each app from the layout file
read_bounds() {
    grep "^$1=" "$LAYOUT_FILE" | cut -d= -f2
}

# Build the dynamic parts of the AppleScript
WAIT_CALLS=""
PARSE_CALLS=""
APPLY_CALLS=""

for i in "${!APP_KEY[@]}"; do
    key="${APP_KEY[$i]}"
    process="${APP_PROCESS[$i]}"
    bounds=$(read_bounds "$key")

    WAIT_CALLS+="my waitForProcess(\"$process\", 30)"$'\n'
    PARSE_CALLS+="set ${key}Data to my parseBounds(\"$bounds\")"$'\n'
    APPLY_CALLS+="my applyLayout(\"$process\", item 1 of ${key}Data, item 2 of ${key}Data)"$'\n'
done

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

$WAIT_CALLS
delay 1
$PARSE_CALLS
$APPLY_CALLS
EOF

echo "Done."
