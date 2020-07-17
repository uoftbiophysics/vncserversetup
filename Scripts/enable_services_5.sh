#!/bin/bash
#enables and starts services for each user (so they run at system startup)
systemctl daemon-reload
#now for each user in VNC_users.txt
while IFS=':' read -r index email || [[ -n "$email" ]]; do
	USER=${email%@*}
        if [[ $USER == *.* ]] ; then
                USER=${USER%%.*}
        fi

	systemctl enable ${USER}vnc@$index.service
	systemctl start ${USER}vnc@$index
	
done < ../Config/VNC_users.txt
