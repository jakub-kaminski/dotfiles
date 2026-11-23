#!/bin/bash
# dmenu wrapper for agent-display.sh
# Shows running displays with a stop option, and available slots to start.

SCRIPT=~/.config/i3/scripts/agent-display.sh

# Build menu entries
entries=""
running=""
for n in $(seq 1 20); do
    if [ -e "/tmp/.X11-unix/X$((100 + n))" ]; then
        entries+="stop s${n}\n"
        running+=" s${n}"
    fi
done
entries+="---\n"
for n in $(seq 1 20); do
    if [ ! -e "/tmp/.X11-unix/X$((100 + n))" ]; then
        entries+="start s${n}\n"
    fi
done

if [ -n "$running" ]; then
    entries="stop all\n${entries}"
fi

chosen=$(echo -e "$entries" | rofi -dmenu -i -p "Agent display" -font "System San Francisco Display 36")
[ -z "$chosen" ] && exit 0

action=$(echo "$chosen" | awk '{print $1}')

if [ "$action" = "---" ]; then
    exit 0
elif [ "$action" = "stop" ] && [ "$(echo "$chosen" | awk '{print $2}')" = "all" ]; then
    for n in $(seq 1 20); do
        if [ -e "/tmp/.X11-unix/X$((100 + n))" ]; then
            bash "$SCRIPT" "$n" stop
        fi
    done
else
    num=$(echo "$chosen" | sed 's/[^0-9]//g')
    if [ "$action" = "stop" ]; then
        bash "$SCRIPT" "$num" stop
    else
        bash "$SCRIPT" "$num"
    fi
fi
