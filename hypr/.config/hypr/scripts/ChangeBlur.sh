
#!/bin/bash
# Script for changing blur settings on the fly

STATE=$(/sbin/hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
    /sbin/hyprctl keyword decoration:blur:size 2
    /sbin/hyprctl keyword decoration:blur:passes 1
else
    /sbin/hyprctl keyword decoration:blur:size 5
    /sbin/hyprctl keyword decoration:blur:passes 2
fi

