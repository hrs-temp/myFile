#!/bin/bash

# Listen continuously, but ignore case and check for any substring match
playerctl -F status 2>/dev/null | while read -r status; do
    # Convert the incoming status to lowercase
    status=${status,,}
    
    if [[ "$status" == *"playing"* ]]; then
        if ! pgrep -f "kitty --class cava-widget" > /dev/null; then
            kitty --class cava-widget -o background_opacity=0.0 -o background_blur=0 -o window_padding_width=0 -e cava &
        fi
    else
        # Kills the widget if stopped, paused, or closed
        pkill -f "kitty --class cava-widget"
    fi
done
