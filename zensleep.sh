#!/bin/sh
# zensleep
#   A lightweight gtk sleep notifier.
#     When called with no arguments, zensleep begins a 20-second countdown
#     before running pm-suspend.  The time of the countdown (in seconds) can be
#     overriden with the -t flag, the sleep command can be overriden with the
#     -s flag.  If the -p flag is used, the script only executes if the level of
#     the battery's charge matches the value provided

# Default values
sleepCommand=pm-suspend
sleepTime=20

while getopts :p:s:t: option
do
    case "$option" in
    p)
         batPercent=$OPTARG
         ;;
    s)
         sleepCommand=$OPTARG
         ;;
    t)
         sleepTime=$OPTARG
         ;;
    [?])
        echo "Usage: $0 [-p battery-percentage] [-s sleep-command] [-t countdown-time]"
		exit 1
        ;;
    esac
done

# If a battery percentage value is provided using the -p flag
# and it doesn't match the current battery level, exit the script
if [[ -n $batPercent ]]; then
    if [[ -z `acpi -b | grep "Discharging, $batPercent%"` ]]; then
       exit 1
    fi
fi

(
for (( c=0; c<=$sleepTime; c++ ))
do

    echo "$((c*100/sleepTime))"
    echo "# System will suspend in $((sleepTime-c)) seconds..."
    sleep 1
done
) |
zenity --progress --title="Low Battery" --auto-close
if [ "$?" = 0 ] ; then
    $sleepCommand
fi
