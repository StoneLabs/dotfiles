#!/bin/bash
SPEAKERS="alsa_output.usb-BEHRINGER_UMC1820_5A84AA56-00.multichannel-output"
MICROPHONE="alsa_input.usb-BEHRINGER_UMC1820_5A84AA56-00.multichannel-input"

pactl unload-module module-loopback

pactl load-module module-loopback latency_msec=25 source=vac1.monitor sink=$SPEAKERS
pactl load-module module-loopback latency_msec=25 source=$MICROPHONE sink=vac2
pactl load-module module-loopback latency_msec=25 source=vac1.monitor sink=vac2