#!/bin/bash

#/home/jakub/Dropbox/@Kindle/Alicja_Kindle/monitor_pdf_events.sh
running_dir=/home/jakub/Dropbox/sync/homedir/.config/i3/scripts
pdf_monitoring1=/home/jakub/Dropbox/sync/homedir/.config/i3/scripts/pdfProcessing/pdf1col_inotify.sh
pdf_monitoring2=/home/jakub/Dropbox/sync/homedir/.config/i3/scripts/pdfProcessing/pdf2col_inotify.sh

session_name=automation38

# Create a new session
tmux new -s ${session_name} -d

# Rename the 1st window
tmux send-keys -t ${session_name} "tmux rename-window "Alice"" ENTER
# Create a new pane on the 1st window
tmux send-keys -t ${session_name} "tmux split-window -h" ENTER

# Create the 2nd window
tmux send-keys -t ${session_name} "tmux new-window" ENTER
tmux send-keys -t ${session_name} "tmux rename-window "Jakub"" ENTER
 
echo "step3"
sleep 1
# Create a new pane on the 2nd window
tmux send-keys -t ${session_name}:Jakub "tmux split-window -h" ENTER
echo "step4"
sleep 1

# Clean screens
tmux send-keys -t ${session_name}:Alice.1 "clear; cd $running_dir" ENTER
tmux send-keys -t ${session_name}:Alice.2 "clear; cd $running_dir" ENTER
tmux send-keys -t ${session_name}:Jakub.1 "clear; cd $running_dir" ENTER
tmux send-keys -t ${session_name}:Jakub.2 "clear; cd $running_dir" ENTER

# Execute commands
#tmux send-keys -t ${session_name}:Alice.1 "clear; cd $running_dir" ENTER
tmux send-keys -t ${session_name}:Alice.1 "bash ${pdf_monitoring1}" ENTER
tmux send-keys -t ${session_name}:Alice.2 "bash ${pdf_monitoring2}" ENTER


waitPaths="/home/jakub/Dropbox/@Kindle/Alicja_Kindle/Input2Column"
targetPaths="/home/jakub/Dropbox/@Kindle/Alicja_Kindle/Output2Column/"
my_command="k2pdfopt -x -ui- -dev kp3 -vls -3 -vb 1.25"


# Execute commands
tmux send-keys -t ${session_name}:Alice.1 "bash ${pdf_monitoring1}" ENTER


waitPaths="/home/jakub/Dropbox/@Kindle/Alicja_Kindle/Input2Column"
targetPaths="/home/jakub/Dropbox/@Kindle/Alicja_Kindle/Output2Column/"
my_command="k2pdfopt -x -ui- -dev kp3 -vls -3 -vb 1.25"

#bash /home/jakub/Dropbox/sync/homedir/.config/i3/scripts/pdfProcessing/k2pdfopt_inotify.sh $waitPaths $targetPaths "$my_command"

tmux send-keys -t ${session_name}:Jakub.2 "bash /home/jakub/Dropbox/sync/homedir/.config/i3/scripts/pdfProcessing/k2pdfopt_inotify.sh $waitPaths $targetPaths "k2pdfopt -x -ui- -dev kp3 -vls -3 -vb 1.25"" ENTER
