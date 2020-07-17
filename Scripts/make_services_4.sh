#!/bin/bash
#makes systemd service files for each user (from a template) that attaches port to username.
#these services will run the vncservers for each VNC user at boot
while IFS=':' read -r index email || [[ -n "$email" ]]; do
	USER=${email%@*}
	if [[ $USER == *.* ]] ; then
                USER=${USER%%.*}
        fi

	if [ -f ../Config/${USER}vnc@.service ]
	then
		echo "../Config/${USER}vnc@.service already exists..."
	else
		sed -e "s/TMP/$USER/g" ../Config/uservnc@.service >  ../Config/${USER}vnc@.service
		chmod 755 ../Config/${USER}vnc@.service
		cp ../Config/${USER}vnc@.service /etc/systemd/system/
	fi
done < ../Config/VNC_users.txt
