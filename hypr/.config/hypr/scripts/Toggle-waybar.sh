#!/bin/bash

if pgrep -x waybar >/dev/null; then
	killall waybar
else
	# Run in correct environment for Wayland
	HyprlandSocket=$(echo $XDG_RUNTIME_DIR/hypr | grep -o "/.*")
	WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-wayland-1} \
		XDG_CURRENT_DESKTOP=Hyprland \
		XDG_SESSION_TYPE=wayland \
		waybar >/dev/null 2>&1 &
fi
