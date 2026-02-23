#!/bin/bash
# Add files to the latest bucket with zero-padded numbering and md5 dedup.
# Usage: bucket_add.sh file1 [file2 ...]

BUCKETS_DIR="$HOME/screen_images/buckets"

# Find latest bucket or auto-create one
LATEST=$(ls -1 "$BUCKETS_DIR" 2>/dev/null | sort -r | head -1)
if [ -z "$LATEST" ]; then
    LATEST="$(date +"%Y-%m-%dT%H-%M-%S")"
    mkdir -p "$BUCKETS_DIR/$LATEST"
fi

BUCKET="$BUCKETS_DIR/$LATEST"
HASHFILE="$BUCKET/.hashes"
touch "$HASHFILE"

# Determine next counter from existing NNN_ prefixes
LAST=$(ls -1 "$BUCKET" | grep -oP '^\d{3}' | sort -r | head -1)
if [ -z "$LAST" ]; then
    NEXT=0
else
    NEXT=$((10#$LAST + 1))
fi

ADDED=0
SKIPPED=0

for FILE in "$@"; do
    [ -f "$FILE" ] || continue

    HASH=$(md5sum "$FILE" | cut -d' ' -f1)

    if grep -qF "$HASH" "$HASHFILE"; then
        SKIPPED=$((SKIPPED + 1))
        continue
    fi

    BASENAME=$(basename "$FILE")
    PADDED=$(printf "%03d" "$NEXT")
    cp "$FILE" "$BUCKET/${PADDED}_${BASENAME}"
    echo "$HASH" >> "$HASHFILE"
    NEXT=$((NEXT + 1))
    ADDED=$((ADDED + 1))
done

notify-send "Bucket Add" "Added: $ADDED, Skipped: $SKIPPED → $LATEST"
