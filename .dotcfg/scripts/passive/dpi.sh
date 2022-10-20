dbus-send --print-reply --dest=org.razer /org/razer razer.devices.getDevices | grep -Eo "string \"([0-9A-Z]+)\"" | sed -E "s|string \"([0-9A-Z]+)\"|\1|" |
    xargs -i \
dbus-send --print-reply --dest=org.razer /org/razer/device/{} razer.device.dpi.getDPI | grep -Eo "int32 ([0-9]+)" | sed -E "s|int32 ([0-9]+)| \1|" | uniq | tr -d '\n'
