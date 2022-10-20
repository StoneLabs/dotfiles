ask() {
    local prompt default reply

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

echo

echo Running Arch-Audit...
ping -c 1 8.8.8.8 > /dev/null 2>&1
while [ $? -ne 0 ]; do
	sleep 1
	((c++)) && ((c==15)) && break	
	ping -c 1 8.8.8.8 > /dev/null 2>&1
done
	
arch-audit --color=always | tac

echo

if ask "Start i3?" Y; then
    startx /usr/bin/i3 -c ~/.dotcfg/i3/i3.cfg > /dev/null 2>&1
    logout
fi
