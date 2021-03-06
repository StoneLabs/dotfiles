#!/usr/bin/env sh

# Terminate already running bar instances
killall -s 9 polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch top bars
for i in $(polybar -m | awk -F: '{print $1}'); do
	env monitor=$i polybar "$@" &
done
