#!/usr/bin/env python3
"""Snapshot every tmux session/window/pane on this machine and write a restore script.

For panes running Claude Code it records the lane (claude-lane mode), the launch flags and the
current session id (from <config dir>/sessions/<pid>.json), so the restore script can bring the
conversation back with `claude-lane <lane> <flags> --resume <session-id>` in the same directory.
Other panes get their working directory back; their foreground command (python3, nvim, ...) is
recorded and replayed only with --with-commands.

Usage:
  tmux-claude-snapshot.py [--out DIR]          # writes DIR/snapshot.json + DIR/restore.sh
Restore after a reboot:
  DIR/restore.sh                 # dry run: prints what it would do
  DIR/restore.sh --go            # create the sessions, start Claude panes (throttled)
  DIR/restore.sh --go --only 'deck15/*'   # only matching session names (shell glob)
  DIR/restore.sh --go --with-commands     # also re-run recorded non-Claude commands
  DIR/restore.sh --go --delay 8           # seconds between Claude launches (default 6)
"""

import argparse
import json
import os
import subprocess
import time
from pathlib import Path

HOME = Path.home()
SHELLS = {"zsh", "bash", "sh", "fish"}
STRIP_FLAGS = {"--resume", "-r", "--continue", "-c", "--session-id"}


def tmux(*args):
    return subprocess.run(
        ["tmux", *args], capture_output=True, text=True, check=True
    ).stdout


def children(pid):
    try:
        out = subprocess.run(
            ["pgrep", "-P", str(pid)], capture_output=True, text=True
        ).stdout
    except OSError:
        return []
    return [int(x) for x in out.split()]


def cmdline(pid):
    try:
        return [a for a in Path(f"/proc/{pid}/cmdline").read_bytes().split(b"\0") if a]
    except OSError:
        return []


def environ(pid):
    try:
        raw = Path(f"/proc/{pid}/environ").read_bytes().split(b"\0")
    except OSError:
        return {}
    env = {}
    for kv in raw:
        if b"=" in kv:
            k, v = kv.split(b"=", 1)
            env[k.decode(errors="replace")] = v.decode(errors="replace")
    return env


def find_proc(root, name, depth=4):
    """Breadth-first search for a descendant whose argv[0] basename is `name`."""
    level = [root]
    for _ in range(depth):
        nxt = []
        for p in level:
            for c in children(p):
                argv = cmdline(c)
                if argv and os.path.basename(argv[0].decode(errors="replace")) == name:
                    return c
                nxt.append(c)
        level = nxt
    return None


def strip_resume(args):
    out, skip = [], False
    for a in args:
        if skip:
            skip = False
            continue
        if a in STRIP_FLAGS:
            skip = a in {"--resume", "-r", "--session-id"}
            continue
        if a.startswith("--resume=") or a.startswith("--session-id="):
            continue
        out.append(a)
    # a bare --resume/-r followed by a flag means "pick interactively": skip only removed the flag
    return out


def claude_info(pane_pid):
    cl = find_proc(pane_pid, "claude")
    if cl is None:
        return None
    env = environ(cl)
    cfg = env.get("CLAUDE_CONFIG_DIR", str(HOME / ".claude"))
    info = {
        "pid": cl,
        "config_dir": cfg,
        "claude_args": [a.decode() for a in cmdline(cl)[1:]],
    }
    # the launcher: parent chain bash claude-lane <mode> ...
    par = int(Path(f"/proc/{cl}/stat").read_text().split(") ")[1].split()[1])
    pargv = [a.decode() for a in cmdline(par)]
    lane_idx = next(
        (i for i, a in enumerate(pargv) if os.path.basename(a) == "claude-lane"), None
    )
    if lane_idx is not None:
        info["launcher"] = "claude-lane"
        info["launcher_args"] = pargv[lane_idx + 1 :]
    else:
        info["launcher"] = "claude"
        info["launcher_args"] = info["claude_args"]
    sf = Path(cfg) / "sessions" / f"{cl}.json"
    if sf.exists():
        try:
            meta = json.loads(sf.read_text())
            info.update(
                session_id=meta.get("sessionId"),
                name=meta.get("name"),
                status=meta.get("status"),
                cwd=meta.get("cwd"),
            )
        except (OSError, ValueError):
            pass
    return info


def snapshot():
    fmt = "#{session_name}\t#{window_index}\t#{window_name}\t#{window_layout}\t#{pane_index}\t#{pane_pid}\t#{pane_current_command}\t#{pane_current_path}\t#{pane_active}\t#{window_active}"
    sessions = {}
    for line in tmux("list-panes", "-a", "-F", fmt).splitlines():
        s, wi, wn, lay, pi, pid, cmd, path, pact, wact = line.split("\t")
        pid = int(pid)
        pane = {"index": int(pi), "cwd": path, "command": cmd, "active": pact == "1"}
        if cmd == "claude":
            pane["claude"] = claude_info(pid)
        elif cmd not in SHELLS:
            fg = find_proc(pid, cmd) or None
            argv = [a.decode(errors="replace") for a in cmdline(fg)] if fg else []
            pane["argv"] = argv
        win = sessions.setdefault(s, {}).setdefault(
            int(wi), {"name": wn, "layout": lay, "active": wact == "1", "panes": []}
        )
        win["panes"].append(pane)
    return sessions


RESTORE = r"""#!/usr/bin/env bash
# Restore tmux sessions from snapshot.json (written by tmux-claude-snapshot.py at @STAMP@).
# Dry run by default; --go to act. Existing sessions with the same name are left alone.
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
exec python3 - "$DIR/snapshot.json" "$@" <<'PY'
import fnmatch, json, shlex, subprocess, sys, time
snap = json.load(open(sys.argv[1]))
args = sys.argv[2:]
go = "--go" in args
with_cmds = "--with-commands" in args
only = args[args.index("--only") + 1] if "--only" in args else None
skip_existing = "--skip-existing" in args
delay = float(args[args.index("--delay") + 1]) if "--delay" in args else 6.0

def run(*a):
    if go:
        subprocess.run(["tmux", *a], check=False)
    else:
        print("  tmux " + " ".join(shlex.quote(x) for x in a))

subprocess.run(["tmux", "start-server"], capture_output=True)  # after a reboot: load ~/.tmux.conf first
try:
    BASE = int(subprocess.run(["tmux", "show-options", "-gv", "base-index"], capture_output=True, text=True).stdout.strip() or 0)
except ValueError:
    BASE = 0

def exists(s):
    return subprocess.run(["tmux", "has-session", "-t", "=" + s], capture_output=True).returncode == 0

n_claude = 0
for sname, wins in snap["sessions"].items():
    if only and not fnmatch.fnmatch(sname, only):
        continue
    if exists(sname):
        # e.g. a fresh terminal after boot created an empty session "2": never touch it,
        # restore the recorded one next to it as "<name>-restored" (or skip with --skip-existing)
        if skip_existing:
            print(f"skip {sname}: already exists (--skip-existing)")
            continue
        new = f"{sname}-restored"
        if exists(new):
            print(f"skip {sname}: already exists and {new} too (restored before)")
            continue
        print(f"note {sname}: already exists -> restoring it as {new}")
        sname = new
    print(f"session {sname}")
    first = True
    for wi in sorted(wins, key=int):
        w = wins[wi]
        for k, p in enumerate(w["panes"]):
            cwd = p["cwd"]
            if first:
                run("new-session", "-d", "-s", sname, "-n", w["name"], "-c", cwd)
                first = False
                if str(wi) != str(BASE):  # first window lands on base-index; move it to its recorded index
                    run("move-window", "-s", f"={sname}:{BASE}", "-t", f"={sname}:{wi}")
            elif k == 0:
                run("new-window", "-d", "-t", f"={sname}:{wi}", "-n", w["name"], "-c", cwd)
            else:
                run("split-window", "-d", "-t", f"={sname}:{wi}", "-c", cwd)
            target = f"={sname}:{wi}.{p['index']}"
            c = p.get("claude")
            line = None
            if c:
                base = ["claude-lane"] + c["launcher_args"] if c["launcher"] == "claude-lane" else ["claude"] + c["launcher_args"]
                # drop any previous --resume/-c so we resume the recorded session id exactly
                clean, skip = [], False
                for a in base:
                    if skip: skip = False; continue
                    if a in ("--resume", "-r", "--session-id"): skip = True; continue
                    if a in ("--continue", "-c"): continue
                    clean.append(a)
                if c.get("session_id"):
                    clean += ["--resume", c["session_id"]]
                else:
                    clean += ["--continue"]
                line = " ".join(shlex.quote(x) for x in clean)
            elif with_cmds and p.get("argv"):
                line = " ".join(shlex.quote(x) for x in p["argv"])
            if line:
                run("send-keys", "-t", target, "-l", line)
                run("send-keys", "-t", target, "Enter")
                if c:
                    n_claude += 1
                    if go:
                        time.sleep(delay)
        if len(w["panes"]) > 1:
            run("select-layout", "-t", f"={sname}:{wi}", w["layout"])
print(f"{'started' if go else 'would start'} {n_claude} Claude sessions" + ("" if go else "  (dry run; add --go)"))
PY
"""


def main():
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    ap.add_argument(
        "--out",
        default=str(
            HOME / "Documents" / "tmux-snapshots" / time.strftime("%Y%m%d-%H%M%S")
        ),
    )
    a = ap.parse_args()
    out = Path(a.out)
    out.mkdir(parents=True, exist_ok=True)
    snap = {
        "taken": time.strftime("%Y-%m-%d %H:%M:%S"),
        "host": os.uname().nodename,
        "sessions": snapshot(),
    }
    (out / "snapshot.json").write_text(json.dumps(snap, indent=1))
    rs = out / "restore.sh"
    rs.write_text(RESTORE.replace("@STAMP@", snap["taken"]))
    rs.chmod(0o755)
    n_s = len(snap["sessions"])
    panes = [
        p for w in snap["sessions"].values() for win in w.values() for p in win["panes"]
    ]
    cl = [p for p in panes if p.get("claude")]
    no_id = [p for p in cl if not p["claude"].get("session_id")]
    print(
        f"{n_s} sessions, {len(panes)} panes, {len(cl)} Claude panes ({len(no_id)} without a session id -> --continue)"
    )
    print(
        f"snapshot: {out / 'snapshot.json'}\nrestore:  {rs}  (dry run by default, --go to act)"
    )


if __name__ == "__main__":
    main()
