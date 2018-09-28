#!/bin/bash
#Script reads users file to generate both usernames and passwords, as well as create these users
#with necessary VNC files. User and VNC passwords are identical, and will be sent over email to users.

while IFS=':' read -r index email || [[ -n "$email" ]]; do
	USER=${email%@*}
	
	if id -u $USER &>/dev/null ; then
		echo "$USER alread exists, skipping.."
	else
		#generate 8 character password with openssl
		PSS="$(openssl rand -base64 6)"
	
		#put the username and generated password in a temporary file
		echo "$index: $USER $PSS" >> ../Config/VNC_users_generated.txt

		#create users and add to nonadmin group
		adduser --disabled-password --gecos "" $USER
		echo -e "$PSS\n$PSS\n" | passwd $USER
		adduser $USER nonadmin

		#create necessary vnc files
		mkdir /home/$USER/.vnc
		echo $PSS | vncpasswd -f > /home/$USER/.vnc/passwd
		cp ../Config/xstartup /home/$USER/.vnc
		echo "" > /home/$USER/.vnc/$(hostname):$index.pid

		#create scripts that allow users to change vncpassword and fix vnc in case of accidental logout
		echo '#!/bin/bash' > /home/$USER/.vnc/change_vnc_password.sh
		echo 'vncpasswd' >> /home/$USER/.vnc/change_vnc_password.sh
		echo '#!/bin/bash' > /home/$USER/.vnc/restart_vnc.sh
		echo "vncserver -kill :$index" >> /home/$USER/.vnc/restart_vnc.sh
		echo "vncserver :$index -localhost -nolisten tcp -depth 24" >> /home/$USER/.vnc/restart_vnc.sh
		chown -R $USER:$USER /home/$USER/.vnc

		#lock down file permissions
		chmod 700 /home/$USER/.vnc
		chmod 664 /home/$USER/.vnc/$(hostname):$index.pid
		chmod 755 /home/$USER/.vnc/xstartup
		chmod 600 /home/$USER/.vnc/passwd
		chmod 500 /home/$USER/.vnc/change_vnc_password.sh
		chmod 500 /home/$USER/.vnc/restart_vnc.sh
		chmod 700 /home/$USER

		#send email to user with username and generated password
		printf "Subject: Credentials for UTSG biophysics server\n\nusername: $USER\npassword: $PSS\nport: 5900+$index\n\n Please change this password immediately using passwd command after initial login!" | ssmtp $email
	fi
	
done < ../Config/VNC_users.txt