#!/bin/sh

pm_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=primary mountain 2>/dev/null)
fg_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=foreground mountain 2>/dev/null)

prefix=$(python ~/.config/polybar/spotify.py -f '{play_pause}' 2>/dev/null)
suffix=$(python ~/.config/polybar/spotify.py -f '{song} - {artist}' 2>/dev/null)

echo "%{F$pm_color}$prefix%{F-} $suffix"
