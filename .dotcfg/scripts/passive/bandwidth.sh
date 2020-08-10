#!/bin/bash

pm_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=primary mountain)
fg_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=foreground mountain)

__print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1024 ]; then
        printf "%5d   B/s" $1
    elif [ "$1" -lt 1048576 ]; then
        printf "%5.1f KiB/s" $(bc <<< "scale=1; $1 / 1024")
    else
        printf "%5.1f MiB/s" $(bc <<< "scale=1; $1 / 1048576")
    fi

    echo "$bytes"
}

__INTERVAL="2"
__INTERFACE="wlo1"

__past_rx="$(cat /sys/class/net/"$__INTERFACE"/statistics/rx_bytes)"
__past_tx="$(cat /sys/class/net/"$__INTERFACE"/statistics/tx_bytes)"

while true; do
    __now_rx="$(cat /sys/class/net/"$__INTERFACE"/statistics/rx_bytes)"
    __now_tx="$(cat /sys/class/net/"$__INTERFACE"/statistics/tx_bytes)"

    __bps_rt=$(bc <<< "($__now_rx - $__past_rx) / $__INTERVAL")
    __bps_tx=$(bc <<< "($__now_tx - $__past_tx) / $__INTERVAL")

    __past_rx=$__now_rx
    __past_tx=$__now_tx

#    echo "%{F$pm_color}%{F-} $(__print_bytes $__bps_rt) %{F$pm_color}%{F-} $(__print_bytes $__bps_tx)"
    echo "%{F$pm_color}%{F-} $(__print_bytes $__bps_rt)"

    sleep $__INTERVAL
done
