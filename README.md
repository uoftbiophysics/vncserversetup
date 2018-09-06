Collection of scripts and config files to streamline setup of an Xubuntu 18.04 VNC server with multiple concurrent users.
To use just clone and run master.sh or scripts individually in /scripts directory.

As an admin the only config files you have to change are <users.txt> and <ssmtp.conf>.

[users.txt]

format is port number separated by user email:

1:user1@domain.com\
2:user2@domain.com

where 1(2) is the VNC port number (5900 + 1(2)). Usernames generated are truncated at the @ symbol.

[ssmtp.conf]

Replace x by your email/password to allow gmail account to send out temporary passwords and usernames for those who request them.

PRIVACY NOTICE

The ssmtp config file stores the sender account credentials in plain text.... so that account and the passwords it delivers are
only as secure as the box is. Make sure this is read only exclusive to root.

Also note that <users_generated.txt> also locally stores user passwords for debugging. Just comment out the line in <create_users_2.sh>
to prevent this.
