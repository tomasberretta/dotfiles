#!/bin/zsh


function yabai_nth_space_move() {
    local display_id=$1
    local space_id=$2
    echo "Moving to display $display_id space $space_id"
    local space_to_move=$(yabai -m query --displays | jq ".[] | select(.index == $display_id) | .spaces[$space_id]")
    echo "Moving to space $space_to_move"
    yabai -m window --space $space_to_move
    yabai -m space --focus $space_to_move
}


yabai_nth_space_move "$@"