#!/bin/bash
#This script sends a message to both VNC and SSH user lists.
#Message file is first stdin argument. 
source $1

#for SSH users
while IFS='' read -r email || [[ -n "$email" ]]; do

	printf "$MESSAGE" | ssmtp $email

done < ../Config/SSH_users.txt

#for VNC users
while IFS=':' read -r index email || [[ -n "$email" ]]; do

	printf "$MESSAGE" | ssmtp $email

done < ../Config/VNC_users.txt

