#!/bin/bash

scr_dir="/home/sheh/.config/hypr/scripts/.lock_script_images"
monitors=$(hyprctl monitors all | grep Monitor | cut -d' ' -f 2)

if [ ! -d "$scr_dir" ]
then
    mkdir "$scr_dir"
fi

swaylock_args=""
for monitor in $monitors
do
    grim -o $monitor $scr_dir/$monitor.jpg
    convert -geometry 10% -blur 600 $scr_dir/$monitor.jpg $scr_dir/$monitor.jpg

    swaylock_args="$swaylock_args --image $monitor:$scr_dir/$monitor.jpg"
done

swaylock $swaylock_args
