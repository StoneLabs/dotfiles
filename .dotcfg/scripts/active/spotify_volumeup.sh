pactl list sink-inputs | tac | rev | awk "/$(echo "application.name = \"]Ss[potify\"" | rev)/,/$(echo "Sink Input #" | rev)/" | tac | rev | 
grep "Sink Input #" | grep -o -E "[0-9]+" | xargs -L1 -i pactl set-sink-input-volume {} $(
    echo $(
        echo -e "$(
            expr $(
                pactl list sink-inputs | tac | rev | awk "/$(
                    echo "application.name = \"]Ss[potify\"" | rev
                )/,/$(
                    echo "Sink Input #" | rev
                )/" | tac | rev | grep --ignore-case volume | grep -o -E "[0-9]+%" | grep -o -E "[0-9]+" | sort -rn | head -1
            ) + 2
        )\n100" | sort -n | head -1
    )%
)
