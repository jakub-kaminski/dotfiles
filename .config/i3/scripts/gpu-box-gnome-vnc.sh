#!/usr/bin/env bash
# Auto-connect the gpu-box :0 GNOME desktop as a 4K VNC viewer at i3 login.
# A matching i3 for_window rule places the "supermicro:0 - TigerVNC" window on
# workspace s2 (HDMI-0), fullscreen. See ~/.config/i3/config.
#
# :0  = the real Ubuntu GNOME session, shared by x11vnc-physical on port 5900,
#       forced to 3840x2160 via xorg.conf (persistent across gpu-box reboots).
#       (The XFCE virtual desktop on :1 / 5901 is deliberately NOT used here.)

HOST=192.168.1.142
PORT=5900
PASSWD="$HOME/.vnc/passwd"

# Idempotent: don't stack a second viewer if one is already up on :0.
pgrep -f "xtigervncviewer.*${HOST}:0" >/dev/null 2>&1 && exit 0

[ -f "$PASSWD" ] || exit 0   # no stored VNC password -> nothing to do

# FullscreenSystemKeys=0 stops the fullscreen viewer from grabbing system keys,
# so i3's keybindings (e.g. $mod+h = focus left) win locally instead of being
# forwarded to the remote GNOME session. Only keys i3 does NOT bind reach GNOME.
VNC_OPTS=(-RemoteResize=0 -FullscreenSystemKeys=0)

# The gpu-box (or the LAN) may still be coming up at login. Wait up to ~60s for
# the VNC port before launching, so we don't pop a connection-failed dialog.
for _ in $(seq 1 30); do
    if timeout 2 bash -c "cat < /dev/null > /dev/tcp/${HOST}/${PORT}" 2>/dev/null; then
        exec xtigervncviewer "${VNC_OPTS[@]}" -passwd "$PASSWD" "${HOST}:0"
    fi
    sleep 2
done

exit 0
