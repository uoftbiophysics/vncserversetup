#!/bin/bash
#first argument is username
USER=$1
deluser $USER
rm -r /media/homes/$USER
rm -r /media/storage/"$USER"_storage
userdel -f $USER #in case used by process

