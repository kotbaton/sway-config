#!/bin/bash

single="Single screen"
wi="WI"
mirrorHDMI="Mirror to HDMI (Full HD)"

chosen=$(printf '%s;%s;%s\n' "$single" "$wi" "$mirrorHDMI"\
                                   "$log_out" \
    | rofi -theme-str "#listview {lines: 5; }"\
           -dmenu \
           -sep ';' \
           -selected-row 1.0\
           -fixed-num-lines)

case "$chosen" in
    "$single")
        hyprctl keyword monitor eDP-1, 1920x1080@60, 0x0, 1.0
        sleep 1

        hyprctl keyword monitor DP-1, disable
        hyprctl keyword monitor HDMI-A-2, disable

        ;;

    "$wi")
        hyprctl keyword monitor HDMI-A-2, 1920x1080@60, 0x0, 1.0, transform, 1
        sleep 1

        hyprctl keyword monitor DP-1, 3840x2160@30, 1080x0, 1.5
        sleep 1

        hyprctl keyword monitor eDP-1, disable
        ;;

    "$mirrorHDMI")
        wlr-randr --output eDP-1 --on --preferred\
                  --output HDMI-A-2 --on --pos 1920,0 --mode 1920x1080@60Hz
        ;;

    *) exit 1 ;;
esac
