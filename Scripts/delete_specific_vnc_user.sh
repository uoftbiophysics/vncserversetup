#!/bin/bash
#first argument is username, second is port
systemctl daemon-reload
USER=$1
index=$2
systemctl stop ${USER}vnc@$index.service
systemctl disable ${USER}vnc@$index.service
rm /temp/.X$index-lock
rm /tmp/.X11-unix/X$index
rm /etc/systemd/system/${USER}vnc@.service
deluser $USER
rm -r /media/homes/$USER
rm -r /media/storage/"$USER"_storage
userdel -f $USER #in case used by process
