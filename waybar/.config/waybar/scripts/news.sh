#!/bin/sh

# If /tmp/newsupdate exists, show its contents
if [ -f /tmp/newsupdate ]; then
	cat /tmp/newsupdate
else
	# Otherwise, show unread count + optional update marker
	news_count=$(newsboat -x print-unread | awk '{ if($1>0) print "󰻈 " $1}')
	update_status=$(cat "${XDG_CONFIG_HOME:-$HOME/.config}"/newsboat/.update 2>/dev/null)
	echo "${news_count}${update_status}"
fi
