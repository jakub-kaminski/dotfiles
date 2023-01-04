#!/bin/bash

# Check if compton is running
# -x flag only match processes whose name (or command line if -f is
# specified) exactly match the pattern. 

if pgrep -x "compton" > /dev/null
then
    echo "Stopping"
    pkill compton
else
    echo "Launching"
    #compton -f
    compton --config /home/jakub/.config/compton.conf
fi
