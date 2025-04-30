#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Keyhints. Idea got from Garuda Hyprland

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Detect monitor resolution and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculate width and height based on percentages and monitor resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Set maximum width and height
max_width=1200
max_height=1000

# Set percentage of screen size for dynamic adjustment
percentage_width=70
percentage_height=70

# Calculate dynamic width and height
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad --width=$dynamic_width --height=$dynamic_height \
	--center \
	--title="Keybindings" \
	--no-buttons \
	--list \
	--column=Key: \
	--column=Description: \
	--column=Command: \
	--timeout-indicator=bottom \
	"ESC" "close this app" "" "=" "SUPER KEY (Windows Key)" "(SUPER KEY)" \
	" enter" "Terminal" "(kitty)" \
	" CTRL arrows" "Resize tiled window" "(Hyprland)" \
	" SHIFT arrows" "Move tiled window" "(Hyprland)" \
	" A" "Desktop Overview" "(Hyprspace)" \
	" D" "App Launcher" "(rofi-wayland)" \
	" T" "Open File Manager" "(Thunar)" \
	" S" "Open Spotify in terminal" "(CLI-Spotify)" \
	" Q" "Close active window" "(not kill)" \
	" W" "Choose wallpaper" "(Waypaper)" \
	"Printscreen" "Screenshot" "(grim)" \
	"ALT Shift" "Change language" "(ENG/СРБ)" \
	" ALT F" "Fullscreen" "Toggles to full screen" \
	" F" "Toggle float" "single window" \
	" Shift B" "Toggle Blur" "normal or less blur" \
	" E" "Rofi Emoticons" "Emoticon" \
	" H" "Launch this app" "" \
	" Y" "Launch Yazi File Manager" "Yazi" \
	"" "" ""
