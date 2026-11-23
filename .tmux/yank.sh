#!/usr/bin/env bash
# tmux copy-mode pipes the selection here. Delegate to the unified clip bridge so
# tmux shares ONE clipboard backend with nvim/vim/zsh. clip-copy (no flag) writes
# BOTH the PRIMARY and CLIPBOARD selections locally, or emits OSC 52 when remote.
exec ~/.scripts/clip-copy "$@"
