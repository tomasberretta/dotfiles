#!/usr/bin/env zsh

# Set a manual location here if automatic detection is not working
# Example: LOCATION="London"
MANUAL_LOCATION=""

if [ -n "$MANUAL_LOCATION" ]; then
    LOCATION_ESCAPED="${MANUAL_LOCATION// /+}"
    WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1")
    LOCATION=$MANUAL_LOCATION
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

    sketchybar --set $NAME label="?"
    sketchybar --set $NAME.moon icon=

    return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_C' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{25\}\).*/\1.../')
MOON_PHASE=$(echo $WEATHER_JSON | jq '.weather[0].astronomy[0].moon_phase' | tr -d '"')

case ${MOON_PHASE} in
"New Moon")
    ICON=
    ;;
"Waxing Crescent")
    ICON=
    ;;
"First Quarter")
    ICON=
    ;;
"Waxing Gibbous")
    ICON=
    ;;
"Full Moon")
    ICON=
    ;;
"Waning Gibbous")
    ICON=
    ;;
"Last Quarter")
    ICON=
    ;;
"Waning Crescent")
    ICON=
    ;;
esac

sketchybar --set $NAME label="$LOCATION  $TEMPERATURE℃ $WEATHER_DESCRIPTION"
sketchybar --set $NAME.moon icon=$ICON
