#!/bin/sh
# ZenSleep
# Checks if battery level is equal to 1st argument
#   if so, start a 20 second cancellable counter to suspend

if acpi -b | grep "Discharging, $1%"; then
    (
    for i in {0..20}
    do
        let t=20-$i
        let i*=5
        echo "$i"
        echo "# System will suspend in $t seconds..."
        sleep 1
    done
    ) |
    zenity --progress \
        --title="Low Battery" \
        --auto-close
    if [ "$?" = 0 ] ; then
        sudo pm-suspend
    fi
fi
