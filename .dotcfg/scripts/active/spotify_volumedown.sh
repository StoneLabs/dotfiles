pactl list sink-inputs | tac | rev | awk "/$(echo "application.name = \"]Ss[potify\"" | rev)/,/$(echo "Sink Input #" | rev)/" | tac | rev | 
grep "Sink Input #" | grep -o -E "[0-9]+" | xargs -L1 -i pactl set-sink-input-volume {} -2%
