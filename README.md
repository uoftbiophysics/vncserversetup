Collection of scripts and config files to streamline setup of an Xubuntu 18.04 VNC server with multiple concurrent users.
To use just clone and run master.sh or scripts individually in /scripts directory.

As an admin the only config files you have to change are <users.txt> and <ssmtp.conf>.

[users.txt]

format is port number separated by user email:

1:user1@domain.com
2:user2@domain.com

where 1(2) is the VNC port number (5900 + 1(2)). Usernames generated are truncated at the @ symbol.

[ssmtp.conf]

Replace x by your email/password to allow gmail account to send out temporary passwords and usernames for those who request them.

PRIVACY NOTICE

The ssmtp config file stores the sender account credentials in plain text.... so that account and the passwords it delivers are
only as secure as the box is. Make sure this is read only exclusive to root.

Also note that <users_generated.txt> also locally stores user passwords for debugging. Just comment out the line in <create_users_2.sh>
to prevent this.

MobaXterm Instructions:

In order to create a user profile, email the administrator. 
You will receive an email with your required user info.

Creating an SSH session:
From the tabs click Session
Choose SSH from the tabs in the pop-up window
Ensure the following information is correct - 
	Remote host = Contact the administrator
	Specify username = refer to your email from the admin
	Port = 22
You may choose a session name under the bookmark tab if you wish.
Click OK
MobaXterm should automatically start the session, but if 
it doesn't then simply double click the session from the 
left panel. You will be prompted to enter the password 
from your email. Allow MobaXterm to save the password.

Creating a VNC session:
From the tabs click Session
Choose VNC from the tabs in the pop-up window
Ensure the following information is correct - 
	Remote hostname or IP address = Contact the administrator
	Port = refer to your email from the admin
Go to the Network Settings and check Connect through SSH gateway
Fill in the following information:
	Gateway SSH server = Contact the administrator
	Port = 22
	User = refer to your email from the admin
You may choose a session name under the bookmark tab if you wish.
Click OK
MobaXterm should automatically start the session, but if 
it doesn't then simply double click the session from the 
left panel. You will be prompted to enter the password 
from your email. Allow MobaXterm to save the password.
You can use the default config if asked on first login.

Troubleshooting:
Authentication failure: If you have previously made a MobaXterm
SSH or VNC session and are making a new session with new username
or password, you may not be prompted to enter your new password.
In this situation, go to the settings tab in MobaXterm and click
MobaXterm passwords management. You must manually delete all 
passwords related to old sessions and then click ok. Now you 
should be able to double-click the new session from the lefthand
panel in MobaXterm and you will be prompted to enter your new 
password and have MobaXterm save it. 


