#!/bin/bash
#delete ssh users
systemctl daemon-reload
while IFS='' read -r email || [[ -n "$email" ]]; do
	USER=${email%@*}
	deluser $USER
	rm -r /media/homes/$USER
	userdel -f $USER #in case used by process
done < ../Config/SSH_users.txt

#and remove generated SSH users file containing passwords
rm ../Config/SSH_users_generated.txt