#!/bin/bash

# Get all unique layouts in use
layouts=$(hyprctl devices | grep "active keymap" | awk -F': ' '{print $2}' | sort | uniq)

# If any device is using Serbian, display Serbian
if echo "$layouts" | grep -q "Serbian"; then
	echo "  СРБ"
else
	echo "  US"
fi
