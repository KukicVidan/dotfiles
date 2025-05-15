#!/bin/bash

# Wallpaper picker script using nsxiv, hyprpaper, and pywal

WALLPAPER_DIR="$HOME/dotfiles/wallpapers/"
MONITOR="DP-3"

# Check wallpaper directory
if [ ! -d "$WALLPAPER_DIR" ]; then
	echo "Error: Wallpaper directory not found at $WALLPAPER_DIR"
	exit 1
fi

# Check dependencies
for cmd in nsxiv wal hyprctl hyprpaper waybar; do
	if ! command -v "$cmd" &>/dev/null; then
		echo "Error: $cmd is not installed." >&2
		exit 1
	fi
done

# Temporary file for storing selected image
TEMP_FILE=$(mktemp)

# Launch nsxiv to select wallpaper
nsxiv -to "$WALLPAPER_DIR" | head -n 1 >"$TEMP_FILE"
SELECTED_IMG=$(cat "$TEMP_FILE")
rm "$TEMP_FILE"

if [ -n "$SELECTED_IMG" ]; then
	echo "Setting wallpaper: $SELECTED_IMG"

	# Set wallpaper using hyprpaper (requires preload first)
	hyprctl hyprpaper preload "$SELECTED_IMG"
	sleep 0.5
	hyprctl hyprpaper wallpaper "$MONITOR,$SELECTED_IMG"

	# Apply pywal colors
	wal -i "$SELECTED_IMG"

	# Reload waybar to apply new colors
	pkill waybar
	waybar &

	# Save selected wallpaper path
	echo "$SELECTED_IMG" >"$HOME/.current_wallpaper"

	echo "Wallpaper set and pywal applied!"
else
	echo "No wallpaper selected."
fi
