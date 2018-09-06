#!/bin/bash
#delete users
#now for each user in users.txt
systemctl daemon-reload
while IFS=':' read -r index email || [[ -n "$email" ]]; do
	USER=${email%@*}
	systemctl stop ${USER}vnc@$index.service
	systemctl disable ${USER}vnc@$index.service
	rm /etc/systemd/system/${USER}vnc@.service
	deluser --remove-home $USER
	userdel -f $USER #in case used by process
	rm ../Config/users_generated.txt
	rm /temp/.X$index-lock
	rm /tmp/.X11-unix/X$index
done < ../Config/users.txt