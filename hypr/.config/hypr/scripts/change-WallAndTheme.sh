#!/bin/bash

# Combined wallpaper script with nsxiv preview and pywal

WALLPAPER_DIR="$HOME/dotfiles/wallpapers/"
MONITOR="DP-3"

# Check wallpaper directory
if [ ! -d "$WALLPAPER_DIR" ]; then
	echo "Error: Wallpaper directory not found at $WALLPAPER_DIR"
	exit 1
fi

# Check dependencies
for cmd in nsxiv swww wal hyprctl waybar; do
	if ! command -v "$cmd" &>/dev/null; then
		echo "Error: $cmd is not installed." >&2
		exit 1
	fi
done

# Start swww-daemon if not running
swww query || swww-daemon &
sleep 1

# Temporary file for storing selected image
TEMP_FILE=$(mktemp)

# Launch nsxiv to select wallpaper
nsxiv -to "$WALLPAPER_DIR" | head -n 1 >"$TEMP_FILE"

SELECTED_IMG=$(cat "$TEMP_FILE")
rm "$TEMP_FILE"

if [ -n "$SELECTED_IMG" ]; then
	echo "Setting wallpaper: $SELECTED_IMG"
	swww img "$SELECTED_IMG" --transition-type none

	# Apply pywal and reload waybar
	wal -i "$SELECTED_IMG"
	pkill waybar
	waybar &

	# Save wallpaper path
	echo "$SELECTED_IMG" >"$HOME/.current_wallpaper"

	echo "Wallpaper set and pywal applied!"
else
	echo "No wallpaper selected."
fi
