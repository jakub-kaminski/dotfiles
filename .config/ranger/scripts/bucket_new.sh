#!/bin/bash
# Create a new timestamped bucket in ~/screen_images/buckets/

BUCKET_DIR="$HOME/screen_images/buckets/$(date +"%Y-%m-%dT%H-%M-%S")"
mkdir -p "$BUCKET_DIR"
notify-send "Bucket Created" "$BUCKET_DIR"
