#!/bin/bash
#makes systemd service files for each user (from a template) that attaches port to username.
#these services will run the vncservers for each VNC user at boot
while IFS=':' read -r index email || [[ -n "$email" ]]; do
	USER=${email%@*}
	sed -e "s/TMP/$USER/g" ../Config/uservnc@.service >  ../Config/${USER}vnc@.service
	chmod 755 ../Config/${USER}vnc@.service
	cp ../Config/${USER}vnc@.service /etc/systemd/system/
done < ../Config/VNC_users.txt