lock_cmd="swaylock -f --image /home/sheh/Pictures/tochou_girl_blurred.png"

swayidle -w timeout 300 "$lock_cmd" \
            timeout 600 'hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' \
            timeout 900 'systemctl suspend' \
            before-sleep "$lock_cmd" &
