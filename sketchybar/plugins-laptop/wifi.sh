#!/usr/bin/env zsh

LOG_FILE="/tmp/wifi_debug.log"
echo "--- New Run $(date) ---" > "$LOG_FILE" # Overwrite log each run for this debug session

# Icons (Nerd Font - Material Design Icons)
ICON_WIFI_OFF="󰤭"    # nf-md-wifi_off
ICON_WIFI_1_BAR="󰤟"  # nf-md-wifi_strength_1
ICON_WIFI_2_BARS="󰤢" # nf-md-wifi_strength_2
ICON_WIFI_3_BARS="󰤥" # nf-md-wifi_strength_3
ICON_WIFI_4_BARS="󰤨" # nf-md-wifi_strength_4

PROFILE_OUTPUT=$(system_profiler SPAirPortDataType)
echo "PROFILE_OUTPUT:\n$PROFILE_OUTPUT" >> "$LOG_FILE"

# Check connection status
STATUS=$(echo "$PROFILE_OUTPUT" | grep -E '^\s*Status:' | awk -F': ' '{print $2}')
echo "PARSED STATUS: [$STATUS]" >> "$LOG_FILE"

CURRENT_SSID=""
ICON=$ICON_WIFI_OFF

if [ "$STATUS" = "Connected" ]; then
    echo "DEBUG: Status is Connected." >> "$LOG_FILE"
    
    # Get a focused block of text around "Current Network Information:"
    FOCUSED_INFO=$(echo "$PROFILE_OUTPUT" | grep -A 8 "Current Network Information:")
    echo "DEBUG: FOCUSED_INFO:\n$FOCUSED_INFO" >> "$LOG_FILE"

    if [ -n "$FOCUSED_INFO" ]; then
        # Extract SSID: the first line after "Current Network Information:" that ends with a colon.
        # This assumes SSID is the first such line in the FOCUSED_INFO.
        TEMP_SSID=$(echo "$FOCUSED_INFO" | awk -F':' '/Current Network Information:/{getline; print $1; exit}' | awk '{$1=$1;print}')
        echo "DEBUG: TEMP_SSID: [$TEMP_SSID]" >> "$LOG_FILE"
        
        SIGNAL_STRENGTH=$(echo "$FOCUSED_INFO" | grep 'Signal / Noise:' | sed -E 's/.*Signal \/ Noise: (-?[0-9]+) dBm.*/\1/')
        echo "DEBUG: SIGNAL_STRENGTH: [$SIGNAL_STRENGTH]" >> "$LOG_FILE"

        if [[ -n "$TEMP_SSID" && "$TEMP_SSID" != "Current Network Information" ]]; then # Ensure it's not the header itself
            echo "DEBUG: TEMP_SSID is not empty and not the header." >> "$LOG_FILE"
            CURRENT_SSID="$TEMP_SSID"
            
            if [[ "$SIGNAL_STRENGTH" =~ ^-?[0-9]+$ ]]; then
                echo "DEBUG: Signal strength is a number: $SIGNAL_STRENGTH" >> "$LOG_FILE"
                if [ "$SIGNAL_STRENGTH" -ge -67 ]; then
                    ICON="$ICON_WIFI_4_BARS"
                elif [ "$SIGNAL_STRENGTH" -ge -70 ]; then
                    ICON="$ICON_WIFI_3_BARS"
                elif [ "$SIGNAL_STRENGTH" -ge -80 ]; then
                    ICON="$ICON_WIFI_2_BARS"
                elif [ "$SIGNAL_STRENGTH" -lt -80 ]; then
                    ICON="$ICON_WIFI_1_BAR"
                else
                    ICON="$ICON_WIFI_4_BARS"
                fi
                echo "DEBUG: Icon based on signal: $ICON" >> "$LOG_FILE"
            else
                echo "DEBUG: Signal strength not a number. Defaulting to 4 bars." >> "$LOG_FILE"
                ICON="$ICON_WIFI_4_BARS"
            fi
        else
            echo "DEBUG: TEMP_SSID was empty or the header. Setting icon to OFF." >> "$LOG_FILE"
            ICON=$ICON_WIFI_OFF
        fi
    else
        echo "DEBUG: FOCUSED_INFO block was empty. Setting icon to OFF." >> "$LOG_FILE"
        ICON=$ICON_WIFI_OFF 
    fi
else
    echo "DEBUG: Status is NOT Connected: [$STATUS]. Setting icon to OFF." >> "$LOG_FILE"
    ICON=$ICON_WIFI_OFF
fi

echo "FINAL ICON: $ICON, FINAL SSID: [$CURRENT_SSID]" >> "$LOG_FILE"

# Update SketchyBar
if [[ -z "$CURRENT_SSID" || "$ICON" == "$ICON_WIFI_OFF" ]]; then
  sketchybar --set wifi icon="$ICON" label.drawing=off
else
  sketchybar --set wifi icon="$ICON" label="$CURRENT_SSID" label.drawing=on
fi 