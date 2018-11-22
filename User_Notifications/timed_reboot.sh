#!/bin/bash
#must be run as root for safety!
rootcheck () {
    if [ $(id -u) != "0" ]
    then
        sudo "$0" "$@" 
        exit $?
    fi
}

rootcheck "${@}"

Friday=$(date -dthis-Friday +%Y%m%d) #what date is next friday?
Thursday=$(date -dthis-Thursday +%Y%m%d) #date next Thursday for second email notification?

FridayTime="1000.00" #ten in the morning
ThursdayTime="2000.00" #8PM Thursday notification before Friday at 10AM shutdown

RebootTime=$Friday$FridayTime
SecondMailTime=$Thursday$ThursdayTime

echo './notifyUsers.sh reboot_message.txt' | at now +2 min
echo 'reboot' | at -t $RebootTime &>> reboots.log #reboot at Friday, 10AM
echo './notifyUsers.sh reboot_message_2.txt' | at -t $SecondMailTime
