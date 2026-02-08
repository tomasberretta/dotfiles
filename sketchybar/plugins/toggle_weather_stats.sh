#!/usr/bin/env zsh

# Toggle weather stats between expanded and collapsed states
# State is stored in a file so weather.sh can respect it

STATE_FILE="/tmp/sketchybar_weather_stats_state"
STATS_CACHE="/tmp/sketchybar_weather_stats_cache"
COLLAPSED_ICON=$'\uf05a'  # Info circle icon

# Get current state (default to expanded)
if [[ -f "$STATE_FILE" ]]; then
    CURRENT_STATE=$(cat "$STATE_FILE")
else
    CURRENT_STATE="expanded"
fi

# Toggle state
if [[ "$CURRENT_STATE" == "expanded" ]]; then
    NEW_STATE="collapsed"
    # Set collapsed view - just show an info icon
    sketchybar --set weather.moon label="" icon="$COLLAPSED_ICON" icon.drawing=on label.drawing=off 2>/dev/null
    sketchybar --set weather.moon.notch label="" icon="$COLLAPSED_ICON" icon.drawing=on label.drawing=off 2>/dev/null
else
    NEW_STATE="expanded"
    # Restore the stats label from cache if available
    if [[ -f "$STATS_CACHE" ]]; then
        STATS_LABEL=$(cat "$STATS_CACHE")
        sketchybar --set weather.moon label="$STATS_LABEL" icon.drawing=off label.drawing=on 2>/dev/null
        sketchybar --set weather.moon.notch label="$STATS_LABEL" icon.drawing=off label.drawing=on 2>/dev/null
    else
        # Trigger full weather update if no cache
        sketchybar --set weather.moon icon.drawing=off label.drawing=on 2>/dev/null
        sketchybar --set weather.moon.notch icon.drawing=off label.drawing=on 2>/dev/null
        # Run weather script in background to update
        "$HOME/.config/sketchybar/plugins/weather.sh" &
    fi
fi

# Save new state
echo "$NEW_STATE" > "$STATE_FILE"
