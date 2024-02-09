#!/bin/bash
screenshots_dir=$HOME/Pictures/Screenshots
time=`date +%Y-%m-%d-%H-%M-%S`
image_path=$screenshots_dir"/"$time".png"

edit_action() {
	gimp $image_path 2> /dev/null &
}

delete_action() {
    rm $image_path
}


if [ ! -d $screenshots_dir ]; then
    mkdir -p $screenshots_dir
    dunstify --timeout 3000 "Maim" "Screenshots dir has been created: $screenshots_dir"
fi

case $1 in
	"-s")
        grim -g "$(slurp)" "$image_path"
		;;
    *)
        grim "$image_path"
        ;;
esac


wl-copy < "$image_path"

if [ -f $image_path ]
then
    action=$(dunstify --timeout=5000\
             --action="delete,Delete"\
             --action="dismiss,Dismiss"\
             --action="edit,Edit"\
             --icon="$image_path"\
             "Grim"\
             "Screenshot saved!")

    case $action in
        "delete")
            delete_action
            ;;
        "edit")
            edit_action
            ;;
        *)
            ;;
    esac
else
	dunstify --timeout 3000 "Maim" "Something goes wrong!"
fi
