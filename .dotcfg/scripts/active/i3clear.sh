#!/bin/bash

IMAGE=/tmp/i3lock.png
SCREENSHOT="scrot $IMAGE" # 0.46s

$SCREENSHOT
i3lock -i $IMAGE
rm $IMAGE
