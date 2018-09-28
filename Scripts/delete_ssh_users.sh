#!/bin/bash
#delete ssh users
systemctl daemon-reload
while IFS='' read -r email || [[ -n "$email" ]]; do
	USER=${email%@*}
	deluser --remove-home $USER
	userdel -f $USER #in case used by process
	rm ../Config/SSH_users_generated.txt
done < ../Config/SSH_users.txt