#!/bin/bash
#Script reads users file to generate both usernames and passwords, as well as create these users
#with necessary VNC files. User and VNC passwords are identical, and will be sent over email to users.

while IFS='' read -r email || [[ -n "$email" ]]; do
	USER=${email%@*}
	
	if id -u $USER &>/dev/null ; then
		echo "$USER alread exists, skipping.."
	else
		#generate 8 character password with openssl
		PSS="$(openssl rand -base64 6)"
	
		#put the username and generated password in a temporary file
		echo "$USER $PSS" >> ../Config/SSH_users_generated.txt

		#create users and add to nonadmin group
		adduser --disabled-password --gecos "" $USER
		echo -e "$PSS\n$PSS\n" | passwd $USER
		adduser $USER nonadmin

		#lock down file permissions
		chmod 700 /home/$USER

		#send email to user with username and generated password
		printf "Subject: Credentials for UTSG biophysics server\n\nusername: $USER\npassword: $PSS\n\n Please change this password immediately using passwd command after initial login!" | ssmtp $email
	fi
	
done < ../Config/SSH_users.txt