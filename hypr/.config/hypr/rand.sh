#!/bin/bash

DIR="$HOME/Anime-Wallpapers/"

if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon --format xrgb &
fi

WP=$(find "$DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

if [ -n "$WP" ]; then
    # 3. Update the symlink for hyprlock
    ln -sf "$WP" "$HOME/.cache/current_wallpaper.png"
    
    # 4. Change wallpaper with a smooth transition
    # swww handles scaling automatically based on your monitor config
    swww img "$WP" --transition-type outer --transition-step 90 --transition-fps 60
else
    echo "No wallpapers found in $DIR. Checking again in 10s..."
fi
