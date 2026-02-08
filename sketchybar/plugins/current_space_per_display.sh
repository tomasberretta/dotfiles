#!/usr/bin/env zsh

# Extract sketchybar display ID from item name (e.g., current_space.1 -> 1)
SKETCHYBAR_DISPLAY=$(echo "$NAME" | sed -E 's/current_space\.([0-9]+).*/\1/')

# Map sketchybar display ID (NSScreen) to aerospace monitor ID
MONITOR_MAP=$(aerospace list-monitors --format "%{monitor-id}:%{monitor-appkit-nsscreen-screens-id}" 2>/dev/null)
AEROSPACE_MONITOR=$(echo "$MONITOR_MAP" | grep ":${SKETCHYBAR_DISPLAY}$" | cut -d: -f1)

# Fallback if mapping fails
if [[ -z "$AEROSPACE_MONITOR" ]]; then
    AEROSPACE_MONITOR="$SKETCHYBAR_DISPLAY"
fi

update_space() {
    # Get the visible workspace for this specific monitor
    SPACE_NAME=$(aerospace list-workspaces --monitor "$AEROSPACE_MONITOR" --visible 2>/dev/null | head -1 | awk '{print $1}')

    # If no workspace found, this monitor might not exist
    if [[ -z "$SPACE_NAME" ]]; then
        return
    fi

    # Default values
    ICON="?"
    LABEL="$SPACE_NAME"
    ICON_PADDING_LEFT=7
    ICON_PADDING_RIGHT=7

    case $SPACE_NAME in
    "Terminal")
        ICON= # Terminal
        ICON_PADDING_RIGHT=8
        ;;
    "Browser")
        ICON= # Web / Globe
        ;;
    "Dev")
        ICON=󰨞 # Code
        ICON_PADDING_RIGHT=4
        ;;
    "Communication")
        ICON= # Comments / Chat
        ;;
    "Issues")
        ICON= # Tag / Label / Issue
        ;;
    "Misc")
        ICON= # Circle / Generic
        ;;
    "Notes")
        ICON=󰎚 # Notion / Note
        ICON_PADDING_RIGHT=6
        ;;
    "Meetings")
        ICON= # Calendar
        ;;
    "Temp")
        ICON=󰚑 # Trash / Temporary
        ;;
    *)
        # Default for any other workspace name
        ICON= # Question mark
        LABEL="$SPACE_NAME ?"
        ;;
    esac

    # Set icon on the main item
    sketchybar --set "current_space.$SKETCHYBAR_DISPLAY" \
        icon=$ICON \
        icon.padding_left=$ICON_PADDING_LEFT \
        icon.padding_right=$ICON_PADDING_RIGHT

    # Set label on the .name item
    sketchybar --set "current_space.$SKETCHYBAR_DISPLAY.name" label="$LABEL"
}

case "$SENDER" in
"mouse.clicked")
    # Reload sketchybar
    sketchybar --remove '/.*/'
    source $HOME/.config/sketchybar/sketchybarrc
    ;;
*)
    update_space
    ;;
esac
