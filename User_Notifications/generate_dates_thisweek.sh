#!/bin/bash
#generates dates for email notifications and reboots for this week and places into reboot_date_message.txt file

FridayTime="10:00" #ten in the morning
ThursdayTime="13:00" #1PM Thursday notification before Friday at 10AM shutdown

#this is the important stuff
TODAY=$(date +%A)
if [ $TODAY = "Thursday" ]; then
Friday=$(date -d'Friday+7 days' +%Y-%m-%d) #what date is next week friday?
Thursday=$(date -d'Thursday+7 days' +%Y-%m-%d) #date next week Thursday for second email notification?

elif [ $TODAY = "Friday" ]; then
Friday=$(date -d'Friday+7 days' +%Y-%m-%d) #what date is next friday?
Thursday=$(date -dthis-Thursday +%Y-%m-%d) #date this Thursday (means next thursday) for second email notification?

else
Friday=$(date -dthis-Friday +%Y-%m-%d) #what date is this friday?
Thursday=$(date -dthis-Thursday +%Y-%m-%d) #date this Thursday for second email notification?
fi
	
RebootDate=$Friday
MailDate=$Thursday

#set dates in reboot_date_message.txt
sed -i "/EMAILTIME=/c\EMAILTIME=$ThursdayTime" ./reboot_date_messages.txt
sed -i "/EMAILDATE=/c\EMAILDATE=$Thursday" ./reboot_date_messages.txt
sed -i "/REBOOTTIME=/c\REBOOTTIME=$FridayTime" ./reboot_date_messages.txt
sed -i "/REBOOTDATE=/c\REBOOTDATE=$Friday" ./reboot_date_messages.txt

#optionally change message
#MESSAGE="Subject: *** server is rebooting this week!\n\n Reboot is scheduled for 10AM $(FridayTime) Friday. \n\n Please refrain from running jobs during this time, or if you do make sure to save your parameters."
