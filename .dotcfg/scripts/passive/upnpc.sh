#!/bin/sh

pm_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=primary mountain)
fg_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=foreground mountain)

forwards=$(upnpc -L 2>/dev/null | grep libminiupnpc | wc -l)

if (( $forwards > 0 )); then
	echo -n "%{u#ff9900 +u}%{F$pm_color}%{F-} "
else
	echo -n "%{F$pm_color}%{F-} "
fi
echo -n "$forwards" || echo "UNKNOWN"
