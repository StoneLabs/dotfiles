function sway_module()
{
    # Get sway output name from XWAYLAND output name
    output=$(xrandr | grep $monitor | sed "s/+0+0/DP-1/" | sed "s/+1920+0/HDMI-A-1/"  | grep -Eo "(DP-1|HDMI-A-1)")

    # Iterate over workspaces on that output
    swaymsg -rt get_workspaces | jq --raw-output ".[] | select(.output==\"$output\") | \"\(.name);\(.visible);\(.focused)\"" | while read -r line ; do
        # $line is in format "WORKSPACE_NAME FOCUSED"

        local workspace=$(echo $line | cut -d ';' -f 1)
        local visible=$(echo $line | cut -d ';' -f 2)
        local focused=$(echo $line | cut -d ';' -f 3)

        # Print Bcolor
        if [ $visible == 'true' ]
        then
            if [ $focused == 'true' ]
            then
                echo -n "%{U#999 +u}%{B#444}    $workspace    %{B-}%{-u}"
            else
                echo -n "%{B#444}    $workspace    %{B-}"
            fi
        else
            echo -n "    $workspace    "
        fi
    done
}
sway_module