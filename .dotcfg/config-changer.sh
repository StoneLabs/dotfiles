CONFIGURATION=$(echo -e "Mountain\nMinimal" | dmenu)
__modules=~/.dotcfg/i3/modules
__i3_config=~/.dotcfg/i3/i3.cfg

case "$CONFIGURATION" in
    "Mountain")
        rm $__i3_config
        cat $__modules/always.cfg >> $__i3_config
        cat $__modules/mountain.cfg >> $__i3_config
        i3-msg "reload; restart"
        ;;
    "Minimal")
        rm $__i3_config
        cat $__modules/always.cfg >> $__i3_config
        cat $__modules/minimal.cfg >> $__i3_config
        i3-msg "reload; restart"
        ;;
    *)
        ;;
esac