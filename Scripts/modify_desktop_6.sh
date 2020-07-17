#!/bin/bash
#work in progress
#cp -v ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/
#nano /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

#while IFS=':' read -r index email || [[ -n "$email" ]]; do
	#cp -f ../Config/whiskermenu-1.rc /home/$USER/.config/xfce4/panel/whiskermenu-1.rc
#done < ../Config/users.txt

#create symbolic link to user storage on desktop
while IFS=':' read -r index email || [[ -n "$email" ]]; do
	USER=${email%@*}
        if [[ $USER == *.* ]] ; then
                USER=${USER%%.*}
        fi

	ln -sT /media/storage/"$USER"_storage /media/homes/$USER/Desktop/Storage
done < ../Config/VNC_users.txt
