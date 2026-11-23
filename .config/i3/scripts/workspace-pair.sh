#!/bin/bash
# workspace-pair.sh <workspace_name>
# Switches both primary (<name>) and side (s<name>) workspaces as a pair.
# Pressing the same workspace shortcut again returns to the previous pair.

WS_NAME="$1"
SIDE="s$WS_NAME"
STATE_FILE="/tmp/i3-workspace-prev"

# Get currently focused workspace name
CURRENT=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')

# Normalize: if on a side workspace, extract the base name
if [[ "$CURRENT" == s* ]]; then
    CURRENT_BASE="${CURRENT#s}"
else
    CURRENT_BASE="$CURRENT"
fi

if [ "$CURRENT_BASE" = "$WS_NAME" ]; then
    # Already on this workspace pair — go back to previous
    if [ -f "$STATE_FILE" ]; then
        PREV=$(cat "$STATE_FILE")
        if [ -n "$PREV" ] && [ "$PREV" != "$WS_NAME" ]; then
            echo "$WS_NAME" > "$STATE_FILE"
            i3-msg "workspace s${PREV}; workspace ${PREV}"
            exit 0
        fi
    fi
else
    # Save current base as previous, switch to new pair
    echo "$CURRENT_BASE" > "$STATE_FILE"
    i3-msg "workspace ${SIDE}; workspace ${WS_NAME}"
fi
