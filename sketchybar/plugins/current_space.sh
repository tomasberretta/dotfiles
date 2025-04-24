#!/usr/bin/env zsh

update_space() {
    SPACE_NAME=$(aerospace list-workspaces --focused | awk '{print $1}')

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
    sketchybar --set $NAME \
        icon=$ICON \
        icon.padding_left=$ICON_PADDING_LEFT \
        icon.padding_right=$ICON_PADDING_RIGHT

    # Set label on the .name item
    sketchybar --set $NAME.name label="$LABEL"
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
