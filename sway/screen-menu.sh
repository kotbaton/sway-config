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
        wlr-randr --output DP-1 --off
        wlr-randr --output HDMI-A-2 --off
        wlr-randr --output eDP-1 --on --preferred
        killall wl-mirror
        ;;

    "$wi")
        wlr-randr --output eDP-1 --off\
                  --output HDMI-A-2 --on --pos 0,0 --preferred --scale 1.0 --transform 90\
                  --output DP-1 --on --mode 2560x1440 --pos 1080,0
        ;;

    "$mirrorHDMI")
        wlr-randr --output eDP-1 --on --preferred\
                  --output HDMI-A-2 --on --pos 1920,0 --mode 1920x1080@60Hz
        ;;

    *) exit 1 ;;
esac
