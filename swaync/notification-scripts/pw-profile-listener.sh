#!/bin/bash
# This script is used to send a notification when the user
# change the actual power profile using waybar

# Command to listen to a change of power profile
gdbus monitor --system \
  --dest net.hadess.PowerProfiles \
  --object-path /net/hadess/PowerProfiles | # Pipe to send the output to the next command
  while read -r line; do
    if echo "$line" | grep -q "ActiveProfile"; then
      profile=$(echo "$line" | grep -oP "ActiveProfile': <'\K[^']+")

      if [ "$profile" != "$last" ]; then
        notify-send -r 9999 "Power Profile" "Switched to: $profile"
        last="$profile"
      fi
    fi
  done
