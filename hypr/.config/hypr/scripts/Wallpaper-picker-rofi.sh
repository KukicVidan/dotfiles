#!/bin/bash

# Configuration variables
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/"
SUPPORTED_FORMATS=("jpg" "jpeg" "png" "gif")
MONITOR="DP-3"

# Function to check if a file is an image based on extension
is_image() {
	local file="$1"
	local ext="${file##*.}"
	ext="${ext,,}" # Convert to lowercase

	for format in "${SUPPORTED_FORMATS[@]}"; do
		if [[ "$ext" == "$format" ]]; then
			return 0
		fi
	done
	return 1
}

# Function to get all images from the wallpaper directory
get_wallpapers() {
	local images=()

	# Check if directory exists
	if [[ ! -d "$WALLPAPER_DIR" ]]; then
		echo "Error: Wallpaper directory not found: $WALLPAPER_DIR" >&2
		exit 1
	fi

	# Find all files in the directory
	while IFS= read -r -d '' file; do
		if is_image "$file"; then
			images+=("$(basename "$file")")
		fi
	done < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f -print0)

	# Check if any images were found
	if [[ ${#images[@]} -eq 0 ]]; then
		echo "Error: No supported images found in $WALLPAPER_DIR" >&2
		exit 1
	fi

	printf '%s\n' "${images[@]}"
}

# Get selected wallpaper using rofi
selected=$(get_wallpapers | rofi -dmenu -p "Select wallpaper:")

# Check if user selected a wallpaper (didn't cancel)
if [[ -n "$selected" ]]; then
	wallpaper_path="$WALLPAPER_DIR/$selected"

	# Verify file exists and is readable
	if [[ ! -r "$wallpaper_path" ]]; then
		echo "Error: Cannot read selected wallpaper: $wallpaper_path" >&2
		exit 1
	fi

	# Set the wallpaper using hyprctl
	hyprctl hyprpaper preload "$wallpaper_path"
	if [[ $? -eq 0 ]]; then
		hyprctl hyprpaper wallpaper "$MONITOR,$wallpaper_path"
		if [[ $? -eq 0 ]]; then
			wal -i "$wallpaper_path"
			pkill waybar
			waybar &
			echo "Successfully set wallpaper: $selected"
			exit 0
		fi
	fi

	echo "Error: Failed to set wallpaper" >&2
	exit 1
fi

# User cancelled selection
exit 0
