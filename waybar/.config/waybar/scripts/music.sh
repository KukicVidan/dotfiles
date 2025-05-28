#!/bin/sh

# File to store format toggle state
FORMAT_FILE="/tmp/waybar_music_format"
[ ! -f "$FORMAT_FILE" ] && echo "0" >"$FORMAT_FILE"
read -r FORMAT <"$FORMAT_FILE"

# Allow toggling format from Waybar clicks
case "$1" in
toggle)
	echo "$(((FORMAT + 1) % 2))" >"$FORMAT_FILE"
	exit 0
	;;
esac

# Define display format
[ "$FORMAT" -eq 0 ] && META="{{ trunc(artist,17) }} - {{ trunc(title,17) }}" || META="{{ trunc(album,17) }} - {{ trunc(title,17) }}"

# Priority: chromium > mpv > mpd
PLAYERS="firefox chromium mpv mpd"

for PLAYER in $PLAYERS; do
	STATUS=$(playerctl --player="$PLAYER" status 2>/dev/null)
	if [ "$STATUS" = "Playing" ]; then
		INFO=$(playerctl metadata --player="$PLAYER" --format "$META")
		echo "{\"text\": \"|   $INFO\"}"
		exit 0
	fi
done

# If nothing is playing, but mpd is paused, show it
STATUS=$(playerctl --player=mpd status 2>/dev/null)
if [ "$STATUS" = "Paused" ]; then
	INFO=$(playerctl metadata --player=mpd --format "$META")
	echo "{\"text\": \"| ❚❚ $INFO\"}"
else
	echo "{\"text\": \"| ⏹ No music\"}"
fi
