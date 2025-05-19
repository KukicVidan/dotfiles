#!/bin/sh

# If run with 'click', fetch news and show a notification
if [ "$1" = "click" ]; then
	notify-send "󰻈 Newsboat" "Fetching new articles..."
	newsboat -x reload >/dev/null 2>&1
	echo "󰻈 Updated: $(date '+%H:%M')" >/tmp/newsboat_lastupdate
	exit 0
fi

# Show status in Waybar (no fetching here!)
# If /tmp/newsupdate exists, show its contents
if [ -f /tmp/newsupdate ]; then
	cat /tmp/newsupdate
else
	# Otherwise, show unread count + optional update marker
	news_count=$(newsboat -x print-unread 2>/dev/null | awk '{ if($1>0) print "󰻈 NEWS:" $1}')
	update_status=$(cat "${XDG_CONFIG_HOME:-$HOME/.config}"/newsboat/.update 2>/dev/null)
	last_update=$(cat /tmp/newsboat_lastupdate 2>/dev/null)

	echo "${news_count}${update_status}"
	echo "$last_update"
fi
