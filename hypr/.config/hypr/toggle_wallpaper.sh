#!/usr/bin/env bash

# Path to the specific video wallpaper you want to toggle
VIDEO_WALLPAPER="$HOME/Videos/wallpapers/goku-ultra-instinct_2.3840x2160.mp4"
# VIDEO_WALLPAPER="$HOME/Videos/wallpapers/black-hole-in-deep-space-wallpaperwaifu-com.mp4"
# VIDEO_WALLPAPER="$HOME/Videos/wallpapers/brook-one-piece-requiem.3840x2160.mp4"

# Check if mpvpaper is currently running
if pgrep -x mpvpaper > /dev/null; then
    # If it is running, kill it. 
    # Because your static wallpaper daemon (awww) runs underneath, 
    # killing mpvpaper instantly reveals your static photo wallpaper.
    pkill -x mpvpaper
else
    # If it's not running, launch the video wallpaper over the top of the static one.
    mpvpaper -o "loop panscan=1.0" '*' "$VIDEO_WALLPAPER" >/dev/null 2>&1 &
    disown
fi
