#!/bin/bash

#get what we need for VNC server to run
apt-get update
apt-get install openssh-server tightvncserver
apt-get install ssmtp

#change file permissions to prevent users from shutting down in terminal
chmod 700 /sbin/shutdown
chmod 700 /sbin/reboot

#add a group necessary for preventing hibernate/sleep/shutdown/restart
addgroup nonadmin

#use PolicyKit to prevent users from messing with powermanagement or networking (two files)
cp ../Config/no-powermanagement.pkla /etc/polkit-1/localauthority/50-local.d/
cp ../Config/no-networking.pkla /etc/polkit-1/localauthority/50-local.d/

#add shell script to bin that tells and prevents users from logging out in some instances
cp ../Config/no_logout_prompt.sh /usr/bin/
chmod 755 /usr/bin/no_logout_prompt.sh

#change xfce4-session-logout.desktop binary call to a script which blocks logout
cp ../Config/xfce4-session-logoutdenied.desktop /usr/share/applications/
cp /usr/share/applications/xfce4-session-logout.desktop /usr/share/applications/xfce4-session-logout.desktop.bk
mv /usr/share/applications/xfce4-session-logoutdenied.desktop /usr/share/applications/xfce4-session-logout.desktop

#add email settings to server (replace x with required info)
cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.backup
cp ../Config/ssmtp.conf /etc/ssmtp/ssmtp.conf
