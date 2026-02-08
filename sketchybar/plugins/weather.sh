#!/usr/bin/env zsh

# Set a manual location here if automatic detection is not working
# MANUAL_LOCATION="London, England"
MANUAL_LOCATION="San Jose, California"
# MANUAL_LOCATION="Mumbai, India"
# MANUAL_LOCATION="Tigre, Buenos Aires"
# MANUAL_LOCATION="Rosario, Santa Fe"

if [ -n "$MANUAL_LOCATION" ]; then
    LOCATION_ESCAPED="${MANUAL_LOCATION// /+}"
    WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1")
    LOCATION="Pilar"
else
    LOCATION_JSON=$(curl -s http://ip-api.com/json)
    LOCATION=$(echo $LOCATION_JSON | jq -r '.city')

    # Fallback to geolocating by IP if a city is not found
    if [ -z "$LOCATION" ] || [ "$LOCATION" = "null" ]; then
        WEATHER_JSON=$(curl -s "https://wttr.in/?format=j1")
        LOCATION=$(echo $WEATHER_JSON | jq -r '.nearest_area[0].areaName[0].value')
    else
        REGION="$(echo $LOCATION_JSON | jq -r '.regionName')"
        # Line below replaces spaces with +
        LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
        WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1")
    fi
fi

# Fallback if empty
if [ -z "$WEATHER_JSON" ]; then
    sketchybar --set $NAME label="?" icon=""
    exit 0
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_C' | tr -d '"')
WEATHER_CODE=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherCode' | tr -d '"')
FEELS_LIKE=$(echo $WEATHER_JSON | jq '.current_condition[0].FeelsLikeC' | tr -d '"')
HUMIDITY=$(echo $WEATHER_JSON | jq '.current_condition[0].humidity' | tr -d '"')
UV_INDEX=$(echo $WEATHER_JSON | jq '.current_condition[0].uvIndex' | tr -d '"')
WIND_SPEED=$(echo $WEATHER_JSON | jq '.current_condition[0].windspeedKmph' | tr -d '"')
RAIN_CHANCE=$(echo $WEATHER_JSON | jq '.weather[0].hourly[0].chanceofrain' | tr -d '"')

# Map UV index to description
if [ "$UV_INDEX" -le 2 ]; then
    UV_DESC="Low"
elif [ "$UV_INDEX" -le 5 ]; then
    UV_DESC="Moderate"
elif [ "$UV_INDEX" -le 7 ]; then
    UV_DESC="High"
elif [ "$UV_INDEX" -le 10 ]; then
    UV_DESC="Very High"
else
    UV_DESC="Extreme"
fi

# Map weather code to icon
case ${WEATHER_CODE} in
113) # Clear/Sunny
    WEATHER_ICON=$'\ue30d'
    ;;
116) # Partly cloudy
    WEATHER_ICON=$'\ue302'
    ;;
119|122) # Cloudy/Overcast
    WEATHER_ICON=$'\ue312'
    ;;
143|248|260) # Mist/Fog
    WEATHER_ICON=$'\ue313'
    ;;
176|263|266|293|296|353) # Light rain/drizzle
    WEATHER_ICON=$'\ue318'
    ;;
299|302|305|308|356|359) # Heavy rain
    WEATHER_ICON=$'\ue318'
    ;;
179|182|185|281|284|311|314|317|350|362|365|374|377) # Sleet/freezing
    WEATHER_ICON=$'\ue3ad'
    ;;
200|386|389|392) # Thunderstorm
    WEATHER_ICON=$'\ue31d'
    ;;
227|230|320|323|326|329|332|335|338|368|371|395) # Snow
    WEATHER_ICON=$'\ue320'
    ;;
*)
    WEATHER_ICON=$'\ue30d'
    ;;
esac

sketchybar --set $NAME icon="$WEATHER_ICON" label="$LOCATION  $TEMPERATURE℃ (${FEELS_LIKE}℃)"

# Check stats toggle state before updating
STATE_FILE="/tmp/sketchybar_weather_stats_state"
STATS_CACHE="/tmp/sketchybar_weather_stats_cache"
STATS_STATE="expanded"
if [[ -f "$STATE_FILE" ]]; then
    STATS_STATE=$(cat "$STATE_FILE")
fi

STATS_LABEL=$'\ue318'" ${RAIN_CHANCE}%   "$'\ue30d'" ${UV_DESC} (${UV_INDEX})   "$'\ue373'" ${HUMIDITY}%   "$'\ue34b'"  ${WIND_SPEED}km/h"

# Always cache the stats label for toggle restoration
echo "$STATS_LABEL" > "$STATS_CACHE"

if [[ "$STATS_STATE" == "expanded" ]]; then
    sketchybar --set $NAME.moon label="$STATS_LABEL" icon.drawing=off label.drawing=on
    sketchybar --set weather.moon.notch label="$STATS_LABEL" icon.drawing=off label.drawing=on 2>/dev/null
fi

# Also update notch display items
sketchybar --set weather.notch icon="$WEATHER_ICON" label="$LOCATION  $TEMPERATURE℃ (${FEELS_LIKE}℃)" 2>/dev/null
