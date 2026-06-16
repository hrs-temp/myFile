#!/bin/bash

# 1. ATOMIC LOCK (Anti-Spin Guard)
# Prevents the image from spinning wildly if you hold the key.
if ! mkdir /tmp/imv_rotate_lock 2>/dev/null; then
    exit 0
fi

# 2. CLEANUP TRAP
trap 'rmdir /tmp/imv_rotate_lock' EXIT

DEGREE=$1
FILE=$2

# Check if file exists (safety)
if [ -f "$FILE" ]; then
    # 3. ROTATE PERMANENTLY
    # mogrify overwrites the file in place.
    # imv will detect the change and reload the image automatically.
    mogrify -rotate "$DEGREE" "$FILE"
    
    # Optional: Notification
    notify-send "Rotated" "${DEGREE}°" -t 800
fi
