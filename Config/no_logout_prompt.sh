#!/bin/bash
#give a popup notification telling users to not log out if in nonadmin group
username="$USER"
if groups $username | grep &>/dev/null "\bnonadmin\b"; then
        notify-send "Hey $username," "No need to log out!!! Please just disconnect from your VNC session.\n\n\n"
else
       xfce4-session-logout 
fi
