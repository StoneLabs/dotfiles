#!/bin/sh

pm_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=primary mountain)
fg_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=foreground mountain)

prefix=$(python ~/.config/polybar/spotify.py -f '{play_pause}' 2>/dev/null)
suffix=$(python ~/.config/polybar/spotify.py -f '{song} - {artist}' 2>/dev/null)

echo "%{F$pm_color}$prefix%{F-} $suffix"
