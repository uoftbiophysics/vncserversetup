#!/bin/bash
#enables and starts services for each user (so they run at system startup)
systemctl daemon-reload
#now for each user in users.txt
while IFS=':' read -r index email || [[ -n "$email" ]]; do
	USER=${email%@*}
	systemctl enable ${USER}vnc@$index.service
	systemctl start ${USER}vnc@$index
	
done < ../Config/users.txt