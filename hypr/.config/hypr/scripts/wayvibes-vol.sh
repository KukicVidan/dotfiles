#!/bin/bash

VOLUME_FILE="$HOME/.config/wayvibes_volume"
SOUND_DIR="$HOME/dotfiles/keyboard-sounds/Trust_GXT_865_ASTA"
WAYVIBES_CMD="/usr/bin/wayvibes" # adjust if in a different path
LOG_FILE="/tmp/wayvibes-volume.log"

# Ensure volume file exists
[[ -f "$VOLUME_FILE" ]] || echo 0.2 >"$VOLUME_FILE"

# Calculate new volume
current=$(cat "$VOLUME_FILE")
delta=$1
new=$(awk "BEGIN { v=$current + $delta; if (v < 0) v=0; if (v > 1) v=1; printf \"%.2f\", v }")
echo "$new" >"$VOLUME_FILE"

# Kill previous wayvibes
killall wayvibes 2>/dev/null

# Start wayvibes with new volume from correct dir
cd "$SOUND_DIR" || exit 1
"$WAYVIBES_CMD" "$SOUND_DIR" -v "$new" >>"$LOG_FILE" 2>&1 &
disown

# Optional notification
notify-send "Wayvibes Volume" "Set to $new"
