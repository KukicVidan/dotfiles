

#!/bin/bash

# Path to your audiobooks folder
AUDIOBOOKS_DIR=~/Documents/Audiobooks

# Find all .opus files, extract the subfolder and filename, and display them with fzf
selected_book=$(find "$AUDIOBOOKS_DIR" -type f -name "*.opus" | awk -F/ '{print $(NF-1)"/"$NF}' | fzf)

# If a book was selected, play it with mpv
if [[ -n "$selected_book" ]]; then
    # Get the full path of the selected book
    full_path=$(find "$AUDIOBOOKS_DIR" -type f -name "*.opus" | grep -F "$selected_book")
    # Play the selected audiobook with mpv
    mpv "$full_path"
else
    echo "No audiobook selected."
fi

