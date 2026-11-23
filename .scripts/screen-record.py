#!/usr/bin/env python3
"""Screen recorder using ffmpeg. Toggled via i3 keybindings.

Usage:
    screen-record.py start   - Start recording (Ctrl+F9)
    screen-record.py stop    - Stop recording (Ctrl+Shift+F9)
    screen-record.py setup   - Choose which screen to record (left/right)
"""

import subprocess
import sys
import os
import re
import signal
from datetime import datetime
from pathlib import Path

PIDFILE = Path("/tmp/screen-record.pid")
RECORDINGS_DIR = Path.home() / "recordings"
CONFIG_FILE = Path.home() / ".config/screen-record.conf"


def notify(message, urgency="normal"):
    subprocess.Popen(["notify-send", "-u", urgency, "Screen Recorder", message])


def get_monitors():
    """Query xrandr and return a list of connected monitors sorted by X offset (left to right)."""
    result = subprocess.run(["xrandr", "--query"], capture_output=True, text=True)
    monitors = []
    for line in result.stdout.splitlines():
        match = re.match(r'^(\S+) connected (\d+)x(\d+)\+(\d+)\+(\d+)', line)
        if match:
            monitors.append({
                "name": match.group(1),
                "width": int(match.group(2)),
                "height": int(match.group(3)),
                "x": int(match.group(4)),
                "y": int(match.group(5)),
            })
    monitors.sort(key=lambda m: m["x"])
    return monitors


def get_recording_target():
    """Read config and return (video_size, x_offset, y_offset) for ffmpeg."""
    monitors = get_monitors()
    if not monitors:
        notify("No monitors detected!", "critical")
        sys.exit(1)

    side = "left"
    if CONFIG_FILE.exists():
        side = CONFIG_FILE.read_text().strip().lower()

    if side == "right" and len(monitors) >= 2:
        mon = monitors[-1]
    elif side == "left":
        mon = monitors[0]
    else:
        notify(f"Only one monitor found, recording it.", "low")
        mon = monitors[0]

    return f"{mon['width']}x{mon['height']}", mon["x"], mon["y"]


def start_recording():
    if PIDFILE.exists():
        try:
            pid = int(PIDFILE.read_text().strip())
            os.kill(pid, 0)  # check if process is alive
            notify("Already recording!", "critical")
            return
        except (ProcessLookupError, ValueError):
            PIDFILE.unlink(missing_ok=True)

    RECORDINGS_DIR.mkdir(exist_ok=True)
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output = RECORDINGS_DIR / f"{timestamp}.mkv"

    video_size, x_off, y_off = get_recording_target()

    # Pause all notifications during recording
    subprocess.run(["dunstctl", "set-paused", "true"])

    side = "left"
    if CONFIG_FILE.exists():
        side = CONFIG_FILE.read_text().strip().lower()
    notify(f"Recording {side} screen ({video_size} at +{x_off}+{y_off})")

    cmd = [
        "ffmpeg",
        "-f", "x11grab",
        "-framerate", "30",
        "-video_size", video_size,
        "-i", f":0.0+{x_off},{y_off}",
        "-c:v", "libx264",
        "-preset", "ultrafast",
        "-crf", "23",
        "-pix_fmt", "yuv420p",
        output,
    ]

    proc = subprocess.Popen(
        cmd,
        stdin=subprocess.DEVNULL,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    PIDFILE.write_text(str(proc.pid))


def stop_recording():
    if not PIDFILE.exists():
        notify("Not recording.", "low")
        return

    try:
        pid = int(PIDFILE.read_text().strip())
        os.kill(pid, signal.SIGINT)  # graceful stop — ffmpeg finalizes the file
    except (ProcessLookupError, ValueError):
        pass
    finally:
        PIDFILE.unlink(missing_ok=True)
        # Resume notifications after recording stops
        subprocess.run(["dunstctl", "set-paused", "false"])
        notify("Recording saved.")


def setup():
    """Show dmenu prompt to pick left/right, write choice to config."""
    monitors = get_monitors()
    if len(monitors) < 2:
        notify("Only one monitor detected, nothing to choose.", "low")
        CONFIG_FILE.parent.mkdir(parents=True, exist_ok=True)
        CONFIG_FILE.write_text("left\n")
        return

    options = "\n".join([
        f"left  ({monitors[0]['name']} {monitors[0]['width']}x{monitors[0]['height']})",
        f"right ({monitors[-1]['name']} {monitors[-1]['width']}x{monitors[-1]['height']})",
    ])
    result = subprocess.run(
        ["dmenu", "-i", "-p", "Record which screen?"],
        input=options,
        capture_output=True,
        text=True,
    )
    choice = result.stdout.strip()
    if not choice:
        return

    side = "left" if choice.startswith("left") else "right"
    CONFIG_FILE.parent.mkdir(parents=True, exist_ok=True)
    CONFIG_FILE.write_text(side + "\n")
    notify(f"Screen recording set to: {side}")


if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1] not in ("start", "stop", "setup"):
        print(f"Usage: {sys.argv[0]} start|stop|setup")
        sys.exit(1)

    if sys.argv[1] == "start":
        start_recording()
    elif sys.argv[1] == "stop":
        stop_recording()
    else:
        setup()
