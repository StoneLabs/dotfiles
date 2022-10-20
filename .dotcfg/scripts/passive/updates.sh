#!/bin/sh

export CHECKUPDATES_DB=/tmp/update_script_$$/

if [ -d "$CHECKUPDATES_DB" ]; then
  echo "ERROR: Target /tmp folder exists."
  exit 1
fi

#check for updates
pm_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=primary mountain 2>/dev/null)
fg_color=$(polybar -c ~/.dotcfg/polybar/polybar.cfg --dump=foreground mountain 2>/dev/null)

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	updates_arch=$(checkupdates | wc -l)
	updates_aur=$(pacaur -Qum 2> /dev/null | wc -l)
	updates=$(("$updates_arch" + "$updates_aur"))

	if [ "$updates" -ge 100 ]; then
		echo "%{u#ff0000 +u}%{F$pm_color}%{F-} $updates_arch - $updates_aur"
	elif [ "$updates" -ge 50 ]; then
		echo "%{u#ff9900 +u}%{F$pm_color}%{F-} $updates_arch - $updates_aur"
	else
		echo "$updates_arch %{F$pm_color}%{F-} $updates_aur"
	fi
else
	echo "%{u#ff0000 +u}%{F$pm_color}%{F-} NO CONNECTION "
fi

rm -rf $CHECKUPDATES_DB

#remove lock
unset CHECKUPDATES_DB
