#!/bin/bash

SOUNDS_DIR="$HOME/dotfiles/keyboard-sounds"
CONFIG_FILE="$HOME/.config/wayvibes_current_pack"
VOLUME_FILE="$HOME/.config/wayvibes_volume"
WAYVIBES_CMD="/usr/bin/wayvibes"
LOG_FILE="/tmp/wayvibes-cycle.log"

# Get list of subfolders (sound packs)
sound_packs=($(find "$SOUNDS_DIR" -mindepth 1 -maxdepth 1 -type d | sort))
total=${#sound_packs[@]}

# Read current pack
if [[ -f "$CONFIG_FILE" ]]; then
	current=$(cat "$CONFIG_FILE")
else
	current="${sound_packs[0]}"
fi

# Find index of current
index=0
for i in "${!sound_packs[@]}"; do
	[[ "${sound_packs[$i]}" == "$current" ]] && index=$i && break
done

# Get next pack
next_index=$(((index + 1) % total))
next="${sound_packs[$next_index]}"

# Save new current
echo "$next" >"$CONFIG_FILE"

# Load volume (default 0.2 if not set)
[[ -f "$VOLUME_FILE" ]] && volume=$(cat "$VOLUME_FILE") || volume=0.2

# Restart wayvibes
killall wayvibes 2>/dev/null
cd "$next" || exit 1
"$WAYVIBES_CMD" "$next" -v "$volume" >>"$LOG_FILE" 2>&1 &
disown

# Optional notify
notify-send "Wayvibes Pack" "Now using: $(basename "$next")"
