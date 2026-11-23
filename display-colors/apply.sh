#!/bin/bash
# ===========================================================================
# apply.sh — Apply Jakub's complete display color settings
#
# This script deterministically reproduces the exact display appearance
# from the original Dell laptop (Ubuntu 22.04, NVIDIA Quadro P3200, HDMI-0)
# on any X11 machine with an NVIDIA GPU.
#
# Usage:
#   bash apply.sh          # apply everything
#   bash apply.sh --check  # dry run, show what would change
# ===========================================================================

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

CHECK_ONLY=false
[[ "${1:-}" == "--check" ]] && CHECK_ONLY=true

info()  { echo -e "\033[1;34m[INFO]\033[0m $*"; }
ok()    { echo -e "\033[1;32m[OK]\033[0m   $*"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m $*"; }
err()   { echo -e "\033[1;31m[ERR]\033[0m  $*"; }
apply() { if $CHECK_ONLY; then echo "       (would apply)"; else "$@"; fi; }

echo "============================================"
echo "  Jakub's Display Color Settings Installer"
echo "============================================"
echo ""

# -------------------------------------------------------
# 1. Prerequisites
# -------------------------------------------------------
info "Checking prerequisites..."

for cmd in xrandr xrdb python3 gsettings; do
    if command -v "$cmd" &>/dev/null; then
        ok "$cmd found"
    else
        err "$cmd not found — install it first"
        exit 1
    fi
done

# Check X11 libraries for the gamma script
python3 -c "
import ctypes
ctypes.cdll.LoadLibrary('libX11.so.6')
ctypes.cdll.LoadLibrary('libXrandr.so.2')
" 2>/dev/null && ok "libX11 + libXrandr available" || { err "libX11.so.6 or libXrandr.so.2 not found"; exit 1; }

# Check for connected display
DISPLAY_OUTPUT=$(xrandr --current 2>/dev/null | grep " connected" | head -1 | awk '{print $1}')
if [[ -z "$DISPLAY_OUTPUT" ]]; then
    err "No connected display found"
    exit 1
fi
ok "Display: $DISPLAY_OUTPUT"
echo ""

# -------------------------------------------------------
# 2. DPI (220 for 4K at ~27")
# -------------------------------------------------------
info "Setting DPI to 220..."
apply xrandr --dpi 220
ok "DPI set to 220"

# -------------------------------------------------------
# 3. Xresources (colors, fonts, cursor)
# -------------------------------------------------------
info "Loading Xresources..."
if [[ -f "$HOME/.Xresources" ]]; then
    apply xrdb -merge "$HOME/.Xresources"
    ok "Xresources merged from ~/.Xresources"
elif [[ -f "$SCRIPT_DIR/../.Xresources" ]]; then
    apply xrdb -merge "$SCRIPT_DIR/../.Xresources"
    ok "Xresources merged from dotfiles"
else
    warn "No .Xresources found — ANSI palette not applied"
fi

# -------------------------------------------------------
# 4. Cursor theme (DMZ-White, 64px)
# -------------------------------------------------------
info "Setting cursor: DMZ-White, 64px..."
if [[ -d /usr/share/icons/DMZ-White ]]; then
    apply gsettings set org.gnome.desktop.interface cursor-theme 'DMZ-White'
    apply gsettings set org.gnome.desktop.interface cursor-size 64
    ok "Cursor: DMZ-White 64px"
else
    warn "DMZ-White cursor theme not installed (apt install dmz-cursor-theme)"
fi

# -------------------------------------------------------
# 5. Gamma ramp (3900K + gamma 1.0:1.2:1.4 + full brightness)
#    This is the most critical step for visual appearance.
# -------------------------------------------------------
info "Applying gamma ramp: 3900K, gamma 1.0:1.2:1.4, brightness 1.0..."

# Kill any running redshift that would conflict
if pgrep -x redshift &>/dev/null; then
    warn "Killing running redshift (conflicts with gamma ramp)"
    $CHECK_ONLY || pkill redshift 2>/dev/null || true
    sleep 0.3
fi

# Reset any existing redshift/xrandr gamma
$CHECK_ONLY || { redshift -x 2>/dev/null || true; }
sleep 0.2

apply python3 "$SCRIPT_DIR/set_gamma_ramp.py" 3900 1.0 1.2 1.4 1.0
ok "Gamma ramp applied"

# -------------------------------------------------------
# 6. Wallpaper
# -------------------------------------------------------
info "Checking wallpaper..."
if [[ -f "$HOME/.wallpapers/wallpaper-3.jpg" ]]; then
    if command -v feh &>/dev/null; then
        apply feh --bg-scale "$HOME/.wallpapers/wallpaper-3.jpg"
        ok "Wallpaper set via feh"
    else
        warn "feh not installed — wallpaper not set"
    fi
else
    warn "~/.wallpapers/wallpaper-3.jpg not found — copy it from old machine"
fi

# -------------------------------------------------------
# 7. Reload tmux (if running)
# -------------------------------------------------------
if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null 2>&1; then
    info "Reloading tmux config..."
    apply tmux source-file "$HOME/.tmux.conf"
    ok "Tmux reloaded"
fi

# -------------------------------------------------------
# 8. NVIDIA checks
# -------------------------------------------------------
info "Checking NVIDIA color settings..."
if command -v nvidia-settings &>/dev/null; then
    for output in $(xrandr --current 2>/dev/null | grep " connected" | awk '{print $1}'); do
        CS=$(nvidia-settings -q "[dpy:$output]/CurrentColorSpace" -t 2>/dev/null || echo "N/A")
        CR=$(nvidia-settings -q "[dpy:$output]/CurrentColorRange" -t 2>/dev/null || echo "N/A")
        if [[ "$CS" == "0" && "$CR" == "0" ]]; then
            ok "NVIDIA $output: RGB Full Range"
        else
            warn "NVIDIA $output: ColorSpace=$CS ColorRange=$CR (expected 0,0 = RGB Full)"
        fi
    done
else
    warn "nvidia-settings not found — cannot verify color range"
fi

# -------------------------------------------------------
# Summary
# -------------------------------------------------------
echo ""
echo "============================================"
echo "  Settings applied. Current state:"
echo "============================================"
xrandr --verbose 2>/dev/null | grep -E "(connected [0-9]|Gamma|Brightness)" | head -4
echo ""
echo "To reset to neutral: python3 $SCRIPT_DIR/set_gamma_ramp.py reset"
echo "To change temp:      python3 $SCRIPT_DIR/set_gamma_ramp.py <TEMP_K> 1.0 1.2 1.4 1.0"
