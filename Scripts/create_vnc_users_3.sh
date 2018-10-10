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
		
		#create storage folder
		mkdir /media/storage/"$USER"_storage
		chown -R $USER:$USER /media/storage/"$USER"_storage
		chmod 700 /media/storage/"$USER"_storage

		#change location of user home directory
                usermod -m -d /media/homes/$USER $USER
		
		#create environment variable for storage
                echo "export STORAGE=/media/storage/${USER}_storage" >> /media/homes/$USER/.profile

		#create necessary vnc files
		mkdir /media/homes/$USER/.vnc
		echo $PSS | vncpasswd -f > /media/homes/$USER/.vnc/passwd
		cp ../Config/xstartup /media/homes/$USER/.vnc
		echo "" > /media/homes/$USER/.vnc/$(hostname):$index.pid

		#create scripts that allow users to change vncpassword and fix vnc in case of accidental logout
		echo '#!/bin/bash' > /media/homes/$USER/.vnc/change_vnc_password.sh
		echo 'vncpasswd' >> /media/homes/$USER/.vnc/change_vnc_password.sh
		echo '#!/bin/bash' > /media/homes/$USER/.vnc/restart_vnc.sh
		echo "vncserver -kill :$index" >> /media/homes/$USER/.vnc/restart_vnc.sh
		echo "vncserver :$index -localhost -geometry 1600x900 -nolisten tcp -depth 24" >> /media/homes/$USER/.vnc/restart_vnc.sh
		chown -R $USER:$USER /media/homes/$USER/.vnc

		#lock down file permissions
		chmod 700 /media/homes/$USER/.vnc
		chmod 664 /media/homes/$USER/.vnc/$(hostname):$index.pid
		chmod 755 /media/homes/$USER/.vnc/xstartup
		chmod 600 /media/homes/$USER/.vnc/passwd
		chmod 500 /media/homes/$USER/.vnc/change_vnc_password.sh
		chmod 500 /media/homes/$USER/.vnc/restart_vnc.sh
		chmod 700 /media/homes/$USER

		#send email to user with username and generated password
		printf "Subject: Credentials for UTSG biophysics server\n\nusername: $USER\npassword(both SSH and VNC): $PSS\nport: 5900+$index\n\n Please change this password immediately using passwd command after initial login!\nYou will also have to change your VNC password (same as password above) by running change_vnc_password.sh in your user/.vnc directory." | ssmtp $email
	fi
	
done < ../Config/VNC_users.txt
