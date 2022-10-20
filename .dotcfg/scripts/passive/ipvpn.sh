#!/bin/sh

pm_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=primary mountain 2>/dev/null)
fg_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=foreground mountain 2>/dev/null)


if [ "$(pgrep openvpn)" ]; then
	echo -n "%{F#009900}%{F-} "
else
	echo -n "%{F$pm_color}%{F-} "
fi
echo -n "$(curl -s http://whatismyip.akamai.com/)" || echo "UNKNOWN"
