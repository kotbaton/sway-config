lock_cmd="~/.config/hypr/scripts/lock.sh"

swayidle -w timeout 300 "$lock_cmd" \
            timeout 310 'hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' \
            before-sleep "$lock_cmd" &
