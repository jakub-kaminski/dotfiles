#!/usr/bin/env bash
# Start the voxtype daemon with the standalone USB MICROPHONE.
# Clears any stale lock/process from a previous unclean shutdown so the
# daemon can always acquire its lock on login or a manual re-run.

set -u

USB_MIC_CARD="MICROPHONE"   # matches arecord -l card name for the standalone USB mic
# PulseAudio source name for the standalone USB mic. Exporting PULSE_SOURCE
# pins voxtype (which uses cpal's "pulse" backend) to this exact device,
# regardless of the PipeWire default. Find with: pactl list sources short
# 2026-11-06: the source now follows the system default (pactl set-default-source); the old standalone
# mic below is only the fallback when no default is set. Override with VOXTYPE_SOURCE=<pulse source name>.
OLD_USB_MIC_PULSE_SOURCE="alsa_input.usb-USB_MICROPHONE_USB_MICROPHONE_20190809-00.analog-stereo"
USB_MIC_PULSE_SOURCE="$OLD_USB_MIC_PULSE_SOURCE"   # resolved in step 3
VOXTYPE_BIN="/usr/lib/voxtype/voxtype-vulkan"
LOG_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/voxtype/voxtype.log"
RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/voxtype"

mkdir -p "$(dirname "$LOG_FILE")" "$RUNTIME_DIR"

log() { printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*" | tee -a "$LOG_FILE" >&2; }

# 1. Stop any running voxtype instance so we start clean.
if pgrep -x voxtype-vulkan >/dev/null 2>&1 || pgrep -x voxtype >/dev/null 2>&1; then
    log "Found existing voxtype process(es); stopping them."
    pkill -TERM -x voxtype-vulkan 2>/dev/null || true
    pkill -TERM -x voxtype         2>/dev/null || true
    for _ in 1 2 3 4 5; do
        pgrep -x voxtype-vulkan >/dev/null 2>&1 || pgrep -x voxtype >/dev/null 2>&1 || break
        sleep 1
    done
    if pgrep -x voxtype-vulkan >/dev/null 2>&1 || pgrep -x voxtype >/dev/null 2>&1; then
        log "Process did not exit from SIGTERM; sending SIGKILL."
        pkill -KILL -x voxtype-vulkan 2>/dev/null || true
        pkill -KILL -x voxtype         2>/dev/null || true
        sleep 1
    fi
fi

# 2. Remove any stale lock files left behind by a killed process.
find "$RUNTIME_DIR" -maxdepth 1 -name '*.lock' -print -delete 2>/dev/null | while read -r f; do
    log "Removed stale lock: $f"
done

# 3. Wait for a USB microphone source to appear (up to ~15 seconds; login autostart can race with udev),
# then pin voxtype to the default source (or VOXTYPE_SOURCE).
for i in $(seq 1 30); do
    if pactl list short sources 2>/dev/null | awk '{print $2}' | grep -q '^alsa_input\.usb-'; then
        break
    fi
    if [ "$i" -eq 1 ]; then
        log "Waiting for a USB microphone source..."
    fi
    sleep 0.5
done
DEF_SRC=$(pactl get-default-source 2>/dev/null || true)
USB_MIC_PULSE_SOURCE="${VOXTYPE_SOURCE:-${DEF_SRC:-$OLD_USB_MIC_PULSE_SOURCE}}"
if ! pactl list short sources 2>/dev/null | awk '{print $2}' | grep -qx "$USB_MIC_PULSE_SOURCE"; then
    log "WARNING: source '$USB_MIC_PULSE_SOURCE' not found; voxtype will fall back to config default."
fi
export PULSE_SOURCE="$USB_MIC_PULSE_SOURCE"
log "Microphone source: $USB_MIC_PULSE_SOURCE"

# 4. Keep the PipeWire source permanently in RUNNING state via a silent
# parec consumer. WirePlumber's no-suspend rule already keeps it IDLE,
# but cpal's stream-open on F9 still triggers an IDLE->RUNNING transition
# that costs audible leading audio. A persistent consumer means the source
# is already RUNNING when voxtype's cpal client connects, so the first
# audio frame arrives effectively instantly.
HOLDER_PID_FILE="$RUNTIME_DIR/mic-holder.pid"
if [ -f "$HOLDER_PID_FILE" ]; then
    OLD_HOLDER_PID=$(cat "$HOLDER_PID_FILE" 2>/dev/null || true)
    if [ -n "${OLD_HOLDER_PID:-}" ] && kill -0 "$OLD_HOLDER_PID" 2>/dev/null; then
        log "Stopping previous mic holder (PID $OLD_HOLDER_PID)."
        kill "$OLD_HOLDER_PID" 2>/dev/null || true
    fi
    rm -f "$HOLDER_PID_FILE"
fi
# Also kill any stray holders from earlier sessions (matched by client name).
pkill -f 'parec.*--client-name=voxtype-mic-holder' 2>/dev/null || true

if command -v parec >/dev/null 2>&1; then
    setsid parec --device="$USB_MIC_PULSE_SOURCE" --raw \
        --client-name=voxtype-mic-holder \
        </dev/null >/dev/null 2>&1 &
    HOLDER_PID=$!
    echo "$HOLDER_PID" > "$HOLDER_PID_FILE"
    log "Started mic holder (PID $HOLDER_PID) to pin '$USB_MIC_PULSE_SOURCE' in RUNNING state."
else
    log "WARNING: parec not found; cannot pin source in RUNNING state."
fi

# 5. Launch the daemon. Use exec so systemd/desktop session tracks it as the
# single process, not a shell wrapper.
log "Starting voxtype daemon."
exec "$VOXTYPE_BIN" daemon >>"$LOG_FILE" 2>&1
