#!/bin/bash

DIR="$HOME/Anime-Wallpapers/"
INTERVAL=120 # 5 minutes

# 1. Initialize swww daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon --format xrgb &
    sleep 1
fi

while true; do
    # 2. Find a random image (supports almost any format)
    # This ignores case (-iname) and finds multiple extensions
    WP=$(find "$DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

    if [ -n "$WP" ]; then
        # 3. Update the symlink for hyprlock
        ln -sf "$WP" "$HOME/.cache/current_wallpaper.png"
        
        # 4. Change wallpaper with a smooth transition
        # swww handles scaling automatically based on your monitor config
        swww img "$WP" --transition-type outer --transition-step 90 --transition-fps 60
        
        sleep "$INTERVAL"
    else
        echo "No wallpapers found in $DIR. Checking again in 10s..."
        sleep 10
    fi
done
