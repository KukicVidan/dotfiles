#!/bin/bash

# wallpaper-demo.sh
# This script uses nsxiv to browse wallpapers and swww to apply them

# Wallpaper directory

WALLPAPER_DIR="$HOME/dotfiles/wallpapers/"

# Check if the wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
	echo "Error: Wallpaper directory not found at $WALLPAPER_DIR"
	exit 1
fi

# Check if nsxiv is installed
if ! command -v nsxiv &>/dev/null; then
	echo "Error: nsxiv is not installed. Please install it first."
	exit 1
fi

# Check if swww is installed
if ! command -v swww &>/dev/null; then
	echo "Error: swww is not installed. Please install it first."
	exit 1
fi

# Initialize swww if it's not already running

swww query || swww-daemon &
sleep 1 # mali delay da se daemon pokrene

# Create a temporary file to store the selected image path
TEMP_FILE=$(mktemp)

# Use nsxiv to browse and select a wallpaper
# The -to options enable thumbnail mode,
# -r searches recursively if there are subdirectories
nsxiv -to "$WALLPAPER_DIR" | head -n 1 >"$TEMP_FILE"

# Get the selected image path
SELECTED_IMG=$(cat "$TEMP_FILE")

# Clean up temp file
rm "$TEMP_FILE"

# If an image was selected, apply it as wallpaper
if [ -n "$SELECTED_IMG" ]; then
	echo "Setting wallpaper: $SELECTED_IMG"
	swww img "$SELECTED_IMG" --transition-type none

	# Optionally save the selection to a config file for persistence
	echo "$SELECTED_IMG" >"$HOME/.current_wallpaper"

	echo "Wallpaper set successfully!"
else
	echo "No wallpaper selected."
fi
