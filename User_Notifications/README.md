Two sample scripts and configuration files to automate a time delayed server reboot, and general blanket messages to users.

timed_reboot.sh calls notifyUsers.sh to send emails alerting users of the reboot, and performs the reboot at a time specified in the script.

notifyUsers.sh can be used alone to send blanket messages to users.


Configuration files: 

[notify_message.txt]

format is:

MESSAGE="Subject: Important message \n\n Dear Users,....."

This should be used to send general messages to users of the server through notify_message.sh


[reboot_message.txt]

Format same as above, but specific to server reboots. This is the contents of the first email to users notifying them of the server reboot date.


[reboot_message_2.txt]

Format same as above. To be used as a followup reminder immediately before the server reboot is scheduled.


[reboot.log]

File that stores reboot "at" jobs for diagnostics. You can view existing "at" jobs by typing atq in the terminal.
