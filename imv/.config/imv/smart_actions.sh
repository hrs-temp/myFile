#!/bin/bash

# If a prompt is already open, this exits SILENTLY.
if ! mkdir /tmp/imv_action_lock 2>/dev/null; then
    exit 0
fi

# CLEANUP TRAP
trap 'rmdir /tmp/imv_action_lock' EXIT

ACTION=$1
FILE=$2
IMV_PID=$3  # We catch the PID passed from config

if [ "$ACTION" == "delete" ]; then
    zenity --question --title="Confirm Delete" \
           --text="Permanently delete:\n\n$(basename "$FILE")?" \
           --icon-name=edit-delete \
           --width=300

    if [ $? -eq 0 ]; then
        rm "$FILE"
        notify-send "Deleted" "$(basename "$FILE")" -t 1000
    fi

elif [ "$ACTION" == "move" ]; then
    DEST=$(zenity --file-selection --directory --title="Move to...")
    if [ -n "$DEST" ]; then
        mv "$FILE" "$DEST"
        notify-send "Moved" "to $DEST" -t 1000
    fi
fi

# Now that the user has decided (Yes or No), we tell imv to move on.
imv-msg $IMV_PID next

exit 0
