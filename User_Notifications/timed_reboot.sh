#!/bin/bash
#must be run as root for safety!
source $1
rootcheck () {
    if [ $(id -u) != "0" ]
    then
        sudo "$0" "$@" 
        exit $?
    fi
}

rootcheck "${@}"

echo "./notifyUsers.sh '$MESSAGE'" | at now +2 min
echo "reboot" | at $REBOOTTIME $REBOOTDATE &>> reboots.log 
echo "./notifyUsers.sh '$MESSAGE2'" | at $EMAILTIME $EMAILDATE
