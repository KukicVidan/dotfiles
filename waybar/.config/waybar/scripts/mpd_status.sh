#!/bin/bash

song=$(mpc current 2>/dev/null)
state=$(mpc status 2>/dev/null | sed -n 2p)

if [[ -z "$state" ]]; then
	echo '{"text": "| ⏹ No MPD connection"}'
	exit 0
fi

if [[ "$state" == *"[playing]"* ]]; then
	icon=" ▶ "
elif [[ "$state" == *"[paused]"* ]]; then
	icon=" ⏸ "
else
	icon=" ⏹ "
fi

if [[ -z "$song" ]]; then
	echo "{\"text\": \"| $icon No song\"}"
else
	artist=$(echo "$song" | cut -d '-' -f1 | xargs)
	title=$(echo "$song" | cut -d '-' -f2- | xargs)
	echo "{\"text\": \"| $icon $artist - $title\"}"
fi
