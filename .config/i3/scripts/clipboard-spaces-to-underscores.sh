#!/bin/bash

# ==========================================
# Clipboard: Whitespace -> Underscores
# ==========================================
# Transforms clipboard content by replacing all whitespace (spaces, newlines,
# tabs, etc.) with underscores. Consecutive whitespace characters are collapsed
# into a single underscore.
# Syncs result to: system clipboard, primary selection (Vim), and tmux buffer.

# DEPENDENCY CHECK
if ! command -v xclip &> /dev/null; then
    notify-send "Error" "xclip is not installed" -u critical
    exit 1
fi

# 1. Get current clipboard content
content=$(xclip -o -selection clipboard 2>/dev/null)

# 2. Check if clipboard is empty
if [ -z "$content" ]; then
    notify-send "Clipboard" "Clipboard is empty" -u normal
    exit 0
fi

# 3. Transform: replace all whitespace with underscores
#    - [:space:] matches: space, tab, newline, carriage return, form feed, vertical tab
#    - tr -s squeezes consecutive characters, so "a   b\n\nc" becomes "a_b_c"
transformed=$(printf '%s' "$content" | tr -s '[:space:]' '_')

# 4. Sync to all clipboards

# System clipboard (Ctrl+C/Ctrl+V)
printf '%s' "$transformed" | xclip -selection clipboard

# Primary selection (mouse middle-click, Vim default yank)
printf '%s' "$transformed" | xclip -selection primary

# Tmux buffer (if tmux is running)
if command -v tmux &> /dev/null && tmux list-sessions &> /dev/null; then
    printf '%s' "$transformed" | tmux load-buffer -
fi

# 5. Optional: notify user
notify-send "Clipboard" "Whitespace → Underscores" -t 1500
