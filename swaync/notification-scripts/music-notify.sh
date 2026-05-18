#!/bin/bash
# music-notify.sh
# Listens for MPD track changes via mpd-mpris D-Bus signals
# Parses the signal output directly without extra dbus-send calls

gdbus monitor --session \
  --dest org.mpris.MediaPlayer2.mpd \
  --object-path /org/mpris/MediaPlayer2 |
  while read -r line; do

    # Filter only lines that contain a track change
    # We check for both PropertiesChanged AND Metadata in the same line
    # This excludes Seeked signals and other unrelated property changes
    if echo "$line" | grep -q "PropertiesChanged" &&
      echo "$line" | grep -q "xesam:title"; then

      # Extract title
      # Format in signal: 'xesam:title': <'Song Name'>
      title=$(echo "$line" | grep -oP "xesam:title': <'\K[^']+")

      # Extract artist
      # Format in signal: 'xesam:artist': <['Artist Name']>
      artist=$(echo "$line" | grep -oP "xesam:artist': <\['\K[^']+")

      # Extract album
      # Format in signal: 'xesam:album': <'Album Name'>
      album=$(echo "$line" | grep -oP "xesam:album': <'\K[^']+")

      # Extract album art path
      # Format in signal: 'mpris:artUrl': <'file:///tmp/mpd_mpris/artwork_XXXXXX'>
      art=$(echo "$line" | grep -oP "mpris:artUrl': <'file://\K[^']+")

      # Send the notification
      # -r 8888     : notification ID, replaces previous music notification
      # -i "$art"   : uses the local album art file directly
      # -t 5000     : auto dismiss after 5 seconds
      notify-send \
        -u low \
        -r 8888 \
        -t 5000 \
        -i "$art" \
        "󰝚 $title" \
        "$artist\n<i>$album</i>"

    fi
  done
