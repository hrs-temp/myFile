#!/bin/bash

DIR="$HOME/Anime-Wallpapers/"
INTERVAL=60 

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon --format xrgb &
    sleep 1
fi

TRANSITIONS=("wipe" "wave" "grow" "center" "any" "outer")

while true; do
    WP=$(find "$DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

    if [ -n "$WP" ]; then
        ln -sf "$WP" "$HOME/.cache/current_wallpaper.png"
        
        RANDOM_TRANS=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
        
        awww img "$WP" --transition-type "$RANDOM_TRANS" --transition-step 90 --transition-fps 60 --transition-angle 30
        
        sleep "$INTERVAL"
    else
        echo "No wallpapers found..."
        sleep 10
    fi
done
