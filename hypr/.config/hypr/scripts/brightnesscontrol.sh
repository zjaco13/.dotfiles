#!/usr/bin/env sh

ScrDir=`dirname $(realpath $0)`
source $ScrDir/globalcontrol.sh

function print_error
{
cat << "EOF"
    ./brightnesscontrol.sh <action>
    ...valid actions are...
        i -- <i>ncrease brightness [+5%]
        d -- <d>ecrease brightness [-5%]
EOF
}

function send_notification {
    brightness=$(ddcutil getvcp 10 --display 1 | awk '{print $9}' | tr -d ",")
    brightinfo="External Monitor Brightness"
    dunstify "Brightness" -a "$brightness%" "$brightinfo" -r 91190 -t 800
}

function adjust_brightness {
    local delta=$1
    current_brightness=$(ddcutil getvcp 10 --display 1 | awk '{print $9}' | tr -d ",")
    new_brightness=$((current_brightness + delta))
    if (( new_brightness > 100 )); then new_brightness=100; fi
    if (( new_brightness < 0 )); then new_brightness=0; fi
    for display in $(ddcutil detect | grep 'Display' | awk '{print $2}'); do
        ddcutil setvcp 10 $new_brightness --display $display
    done
    send_notification
}

case $1 in
i) adjust_brightness 10 ;;   # Increase by 10%
d) adjust_brightness -10 ;;  # Decrease by 10%
*) print_error ;;
esac
