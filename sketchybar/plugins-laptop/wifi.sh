#!/usr/bin/env zsh

LOG_FILE="/tmp/wifi_debug.log"
echo "--- New Run $(date) ---" > "$LOG_FILE" # Overwrite log each run for this debug session

# Icons (Nerd Font - Material Design Icons)
ICON_WIFI_OFF="󰤭"    # nf-md-wifi_off
ICON_WIFI_1_BAR="󰤟"  # nf-md-wifi_strength_1
ICON_WIFI_2_BARS="󰤢" # nf-md-wifi_strength_2
ICON_WIFI_3_BARS="󰤥" # nf-md-wifi_strength_3
ICON_WIFI_4_BARS="󰤨" # nf-md-wifi_strength_4

# Check if WiFi is connected by looking for an IP on en0
WIFI_IP=$(ifconfig en0 2>/dev/null | awk '/inet / {print $2}')
echo "WIFI_IP: [$WIFI_IP]" >> "$LOG_FILE"

ICON=$ICON_WIFI_OFF

if [[ -n "$WIFI_IP" ]]; then
    ICON="$ICON_WIFI_4_BARS"
    echo "DEBUG: WiFi connected with IP $WIFI_IP" >> "$LOG_FILE"
else
    echo "DEBUG: WiFi not connected" >> "$LOG_FILE"
fi

echo "FINAL ICON: $ICON" >> "$LOG_FILE"

# Update SketchyBar (icon only, no SSID label due to macOS privacy restrictions)
sketchybar --set wifi icon="$ICON" label.drawing=off 