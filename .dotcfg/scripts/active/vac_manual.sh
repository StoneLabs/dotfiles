#!/bin/bash
SPEAKERS="alsa_output.usb-BEHRINGER_UMC1820_$1-00.multichannel-output"
MICROPHONE="alsa_input.usb-BEHRINGER_UMC1820_$1-00.multichannel-input"

pactl unload-module module-null-sink
pactl unload-module module-loopback

# Create the null sinks
pactl load-module module-null-sink sink_name=vac1 sink_properties=device.description="VAC-Input+Output"
pactl load-module module-null-sink sink_name=vac2 sink_properties=device.description="VAC-Input"

# Now create the loopback devices, all arguments are optional and can be configured with pavucontrol
pactl load-module module-loopback latency_msec=25 source=vac1.monitor sink=$SPEAKERS
pactl load-module module-loopback latency_msec=25 source=$MICROPHONE sink=vac2
pactl load-module module-loopback latency_msec=25 source=vac1.monitor sink=vac2

