
#!/bin/bash

# Define the base directory for audiobooks
AUDIOBOOKS_DIR="$HOME/Documents/Audiobooks"

# Find all .opus files in the directory and subdirectories
# You can change "*.opus" to another extension if needed (e.g., *.mp3, *.flac)
find "$AUDIOBOOKS_DIR" -type f -name "*.opus" | while read -r file; do
    # Open each file in mpv
    mpv "$file"
done

