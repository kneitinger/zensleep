#ZenSleep

A lightweight [zenity](https://en.wikipedia.org/wiki/Zenity) based sleep-counter for Linux.
![ScreenShot](zensleep.jpg)
##Usage
###Default
By default, zensleep launches a 30 second countdown window, executing `pm-suspend` if the Cancel button is not clicked within that timeframe.  This mode is useful for creating udev rules. For instance:

Create `/etc/udev/rules.d/zensleep.rules` with the following text:
```bash
# Execute zensleep when battery level drops to 4%
KERNEL=="BAT1", SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="4", RUN+="/home/your_user_name/bin/zensleep"
```
Now whenever your battery lavel drops to 4%, udev runs zensleep.

###Parameters
zensleep can also take command line arguments to modify the duration of the
counter (-t), the command used to suspend (-s) and/or the percentage at which
the battery should be at in order for the dialog to run (-p), which is useful in
cron based setups where udev cannot recognize battery level events.
