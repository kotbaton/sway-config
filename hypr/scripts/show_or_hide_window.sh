#!/bin/bash

window=$1

if [[ -z "$window" ]]
then
    exit 1
fi

active_workspace=$(hyprctl -j activeworkspace | jq -r ."name")

window_workspace=$(hyprctl -j clients | jq -r 'map(select(."class" == "'$window'")) | .[0]["workspace"]["name"]')

if [[ "$window_workspace" == "null" ]]
then
    notify-send -t 3000 "Hyprland script" "Window \"$window\" is not running now."
    exit 1
fi

echo $active_workspace $window_workspace

if [[ "$active_workspace" == "$window_workspace" ]]
then
    hyprctl dispatch movetoworkspacesilent special:hidden,$window
    hyprctl dispatch cyclenext
else
    hyprctl dispatch movetoworkspace $active_workspace,$window
fi
