ZenSleep
========

A lightweight Zenity based sleep-counter for Linux.

Usage
-----

If no command line arguments are used, ZenSleep launches a 20-second countdown window, executing 'suspend' if the Cancel button was not clicked within that timeframe.  This mode is useful for creating udev rules. For instance:

'/etc/udev/rules.d/zensleep.rules'
    # Execute zensleep when battery level drops to 4%
    KERNEL=="BAT1", SUBSYSTEM==:power_supply", ATTR{status}=="Discharging",
    ATTR{capacity}=="4", RUN+="/home/kyle/bin/zensleep"

