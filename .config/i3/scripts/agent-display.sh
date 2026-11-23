#!/bin/bash
# agent-display.sh <workspace_number> [width] [height]
# Starts a virtual display (Xvfb) for the given workspace, with a VNC viewer
# window that is auto-moved to the side workspace by i3 for_window rules.
#
# Display number = 100 + workspace number (e.g., workspace 5 → :105)
# VNC viewer title = "Agent s<N>" (matched by i3 for_window rules)
#
# Architecture:
#   Xvfb :105        ← always renders, agent screenshots here
#   i3 (nested)      ← window manager inside Xvfb
#   x11vnc           ← serves the Xvfb framebuffer over VNC
#   vncviewer        ← window on workspace s5 (observation + mouse interaction)
#
# Usage:
#   agent-display.sh 5           # starts :105, 1920x1080
#   agent-display.sh 5 1280 720  # starts :105, 1280x720
#   agent-display.sh 5 stop      # stops display :105

NUM="$1"
WIDTH="${2:-1920}"
HEIGHT="${3:-1080}"

if [ -z "$NUM" ]; then
    echo "Usage: agent-display.sh <workspace_number> [width] [height]"
    echo "       agent-display.sh <workspace_number> stop"
    exit 1
fi

DISPLAY_NUM=$((100 + NUM))
TITLE="agent s${NUM}"
VNC_PORT=$((5900 + DISPLAY_NUM))
PIDFILE="/tmp/agent-display-${NUM}.pids"

# Stop mode
if [ "$2" = "stop" ]; then
    if [ -f "$PIDFILE" ]; then
        while read -r pid; do
            kill "$pid" 2>/dev/null
        done < "$PIDFILE"
        rm -f "$PIDFILE"
        echo "Stopped agent display :${DISPLAY_NUM}"
    else
        echo "No agent display :${DISPLAY_NUM} running"
    fi
    exit 0
fi

# Check if already running
if [ -e "/tmp/.X11-unix/X${DISPLAY_NUM}" ]; then
    echo "Display :${DISPLAY_NUM} already running"
    exit 0
fi

# Start Xvfb (headless X server — always renders)
Xvfb ":${DISPLAY_NUM}" -screen 0 "${WIDTH}x${HEIGHT}x24" &
XVFB_PID=$!
sleep 0.5

# Start i3 inside the virtual display with separate config and IPC socket
I3_AGENT_SOCK="/tmp/i3-agent-${NUM}.sock"
rm -f "$I3_AGENT_SOCK"
DISPLAY=":${DISPLAY_NUM}" I3SOCK="$I3_AGENT_SOCK" i3 -c ~/.config/i3/agent-config --shmlog-size=0 &
I3_PID=$!
sleep 0.5

# Start x11vnc to serve the Xvfb framebuffer (-desktop sets the VNC viewer title)
x11vnc -display ":${DISPLAY_NUM}" -rfbport "${VNC_PORT}" -localhost -nopw -quiet -forever -desktop "${TITLE}" &
X11VNC_PID=$!
sleep 0.5

# Start VNC viewer as observation window (mouse clicks pass through, keyboard stays with i3)
vncviewer -FullscreenSystemKeys=0 -FullScreen=0 -MenuKey= "localhost::${VNC_PORT}" &
VIEWER_PID=$!
sleep 1

# Rename the VNC viewer window to remove " - TigerVNC" suffix
WID=$(xdotool search --name "${TITLE} - TigerVNC" 2>/dev/null | head -1)
if [ -n "$WID" ]; then
    xdotool set_window --name "${TITLE}" "$WID"
fi

# Save PIDs for cleanup
echo -e "${XVFB_PID}\n${I3_PID}\n${X11VNC_PID}\n${VIEWER_PID}" > "$PIDFILE"

echo "Started agent display :${DISPLAY_NUM} (${WIDTH}x${HEIGHT}) → workspace s${NUM}"
echo "  Xvfb PID: ${XVFB_PID}, i3 PID: ${I3_PID}, x11vnc PID: ${X11VNC_PID}, viewer PID: ${VIEWER_PID}"
