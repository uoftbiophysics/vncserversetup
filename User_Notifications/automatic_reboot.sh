#!/bin/bash
#Executes a safe reboot for the current week, with immediate email, reminder on Thursday, and reboot Friday.
./generate_dates_thisweek.sh
./timed_reboot.sh reboot_date_messages.txt


