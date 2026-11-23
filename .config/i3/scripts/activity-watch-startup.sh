#!/bin/bash
# aw-qt discovers aw-server and the watchers by scanning $PATH, so the venv's
# bin/ must be on PATH when i3 launches it — i3's inherited env does not
# include it.
export PATH="/home/jakub/Documents/time-tracking-software/activitywatch/venv/bin:$PATH"
aw-qt &
