#!/usr/bin/env zsh

# Extract sketchybar display ID from item name (e.g., front_app.1 -> 1)
SKETCHYBAR_DISPLAY=$(echo "$NAME" | sed -E 's/front_app\.([0-9]+).*/\1/')

# Map sketchybar display ID (NSScreen) to aerospace monitor ID
MONITOR_MAP=$(aerospace list-monitors --format "%{monitor-id}:%{monitor-appkit-nsscreen-screens-id}" 2>/dev/null)
AEROSPACE_MONITOR=$(echo "$MONITOR_MAP" | grep ":${SKETCHYBAR_DISPLAY}$" | cut -d: -f1)

# Fallback if mapping fails
if [[ -z "$AEROSPACE_MONITOR" ]]; then
    AEROSPACE_MONITOR="$SKETCHYBAR_DISPLAY"
fi

# Get the visible workspace on this monitor
WORKSPACE=$(aerospace list-workspaces --monitor "$AEROSPACE_MONITOR" --visible 2>/dev/null | head -1)

if [[ -z "$WORKSPACE" ]]; then
    sketchybar --set "front_app.$SKETCHYBAR_DISPLAY" drawing=off \
               --set "front_app.$SKETCHYBAR_DISPLAY.separator" drawing=off \
               --set "front_app.$SKETCHYBAR_DISPLAY.name" drawing=off
    exit 0
fi

# Get the focused window's monitor (NSScreen ID)
FOCUSED_NSSCREEN=$(aerospace list-windows --focused --format "%{monitor-appkit-nsscreen-screens-id}" 2>/dev/null | head -1)

if [[ "$FOCUSED_NSSCREEN" == "$SKETCHYBAR_DISPLAY" ]]; then
    # This display has the focused window, use the focused app
    APP_NAME=$(aerospace list-windows --focused --format "%{app-name}" 2>/dev/null | head -1)
else
    # This display doesn't have focus, get the first window on its visible workspace
    APP_NAME=$(aerospace list-windows --workspace "$WORKSPACE" --format "%{app-name}" 2>/dev/null | head -1)
fi

# If no app found, hide the items
if [[ -z "$APP_NAME" ]]; then
    sketchybar --set "front_app.$SKETCHYBAR_DISPLAY" drawing=off \
               --set "front_app.$SKETCHYBAR_DISPLAY.separator" drawing=off \
               --set "front_app.$SKETCHYBAR_DISPLAY.name" drawing=off
    exit 0
else
    sketchybar --set "front_app.$SKETCHYBAR_DISPLAY" drawing=on \
               --set "front_app.$SKETCHYBAR_DISPLAY.separator" drawing=on \
               --set "front_app.$SKETCHYBAR_DISPLAY.name" drawing=on
fi

case $APP_NAME in
"Arc")
    ICON_PADDING_RIGHT=5
    ICON=󰞍
    ;;
"Code")
    ICON_PADDING_RIGHT=4
    ICON=󰨞
    ;;
"Calendar")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Discord")
    ICON=
    ;;
"FaceTime")
    ICON_PADDING_RIGHT=5
    ICON=
    ;;
"Finder")
    ICON=󰀶
    ;;
"Google Chrome")
    ICON_PADDING_RIGHT=7
    ICON=
    ;;
"IINA")
    ICON_PADDING_RIGHT=4
    ICON=󰕼
    ;;
"kitty")
    ICON=󰄛
    ;;
"Messages")
    ICON=
    ;;
"Notion")
    ICON_PADDING_RIGHT=6
    ICON=󰎚
    ;;
"Preview")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"PS Remote Play")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Spotify")
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
"TextEdit")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"Transmission")
    ICON_PADDING_RIGHT=3
    ICON=󰶘
    ;;
*)
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
esac

sketchybar --set "front_app.$SKETCHYBAR_DISPLAY" icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
sketchybar --set "front_app.$SKETCHYBAR_DISPLAY.name" label="$APP_NAME"
