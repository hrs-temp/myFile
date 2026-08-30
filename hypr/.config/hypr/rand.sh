#!/bin/bash

DIR1="$HOME/Anime-Wallpapers/"
DIR2="$HOME/Pictures/Wallpapers/"

if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon --format xrgb &
    sleep 1
fi

TRANSITIONS=("wipe" "wave" "grow" "center" "any" "outer")

WP=$(find "$DIR1" "$DIR2" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) 2>/dev/null | shuf -n 1)

if [ -n "$WP" ]; then
    ln -sf "$WP" "$HOME/.cache/current_wallpaper.png"
    
    RANDOM_TRANS=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}
    
    awww img "$WP" --transition-type "$RANDOM_TRANS" --transition-step 90 --transition-fps 60 --transition-angle 30
    
else
    notify-send -u critical "Wallpaper Error" "No images found in $DIR1 or $DIR2"
fi
