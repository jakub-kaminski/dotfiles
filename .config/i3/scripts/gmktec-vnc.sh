#!/usr/bin/env bash
# Auto-connect the gmktec box's virtual 4K desktop as a VNC viewer at i3 login.
# A matching i3 for_window rule places the "WHB04B-6 demo - TigerVNC" window on
# workspace s18 (HDMI-0), fullscreen. See ~/.config/i3/config.
#
# :1 / port 5901 = Xvnc (TigerVNC 1.14, ~pathpilot/.local/opt) virtual screen,
#     3840x2160, -SecurityTypes None (no password), desktop name "WHB04B-6 demo".
#     It is an ad-hoc process on gmktec (no systemd unit) — if it's down, this
#     script waits ~60s then exits silently.
#
# gmktec's DHCP IP has drifted before (.120 -> .161); prefer the mDNS name and
# fall back to the last known IP.

HOST=gmktec.local
FALLBACK_IP=192.168.1.161
PORT=5901

getent hosts "$HOST" >/dev/null 2>&1 || HOST="$FALLBACK_IP"

# Idempotent: don't stack a second viewer on the gmktec display.
pgrep -f "xtigervncviewer.*(gmktec|${FALLBACK_IP}):1" >/dev/null 2>&1 && exit 0

# FullscreenSystemKeys=0 stops the fullscreen viewer from grabbing system keys,
# so i3's keybindings ($mod+h / $mod+l = focus left/right) win locally instead
# of being forwarded to the remote session.
VNC_OPTS=(-RemoteResize=0 -FullscreenSystemKeys=0 -SecurityTypes None)

# The box (or the LAN) may still be coming up at login. Wait up to ~60s for the
# VNC port before launching, so we don't pop a connection-failed dialog.
for _ in $(seq 1 30); do
    if timeout 2 bash -c "cat < /dev/null > /dev/tcp/${HOST}/${PORT}" 2>/dev/null; then
        exec xtigervncviewer "${VNC_OPTS[@]}" "${HOST}:1"
    fi
    sleep 2
done

exit 0
