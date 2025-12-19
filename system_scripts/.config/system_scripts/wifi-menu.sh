#!/bin/bash

# 1. Get the list using Terse mode (-t) to strip all formatting
# -f SSID: Only fetch the name
# grep -v: Remove empty lines (hidden networks)
# sort -u: Remove duplicates
wifi_list=$(nmcli -t -f SSID device wifi list | grep -v '^$' | sort -u)

# 2. Use rofi to select
# -i: Case insensitive
chosen_network=$(echo -e "$wifi_list" | rofi -dmenu -i -p "Wi-Fi SSID: " -config ~/.config/rofi/config.rasi)

# 3. Stop if the user cancelled
if [ -z "$chosen_network" ]; then
    exit
fi

# 4. Check if we already have a profile for this network
# -g NAME: Get specific column (Name) in terse mode
saved_connections=$(nmcli -g NAME connection show)

if echo "$saved_connections" | grep -w "$chosen_network" > /dev/null; then
    # Already saved? Just connect.
    notify-send "Wi-Fi" "Connecting to saved network: $chosen_network..."
    nmcli connection up id "$chosen_network"
else
    # Not saved? Prompt for password.
    wifi_password=$(rofi -dmenu -p "Password for $chosen_network: " -password -config ~/.config/rofi/config.rasi)
    
    # If password entered, try to connect
    if [ -n "$wifi_password" ]; then
        notify-send "Wi-Fi" "Connecting to new network: $chosen_network..."
        nmcli device wifi connect "$chosen_network" password "$wifi_password"
    fi
fi
