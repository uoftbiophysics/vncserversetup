A collection of scripts and a configuration file used to send blanket messages to users, and schedule reboots.

[reboot_date_messages.txt]

Here you can enter a time and date for a reboot notification, and the reboot itself.

<generate_dates_thisweek.sh>:

Instead of populating the configuration file yourself, if you have agreed on a reboot schedule just modify and run <generate_dates_thisweek.sh> to update the configuration file above.

<notifyUsers.sh>

This script takes its first argument and sends it as an email to all users.

<timed_reboot.sh>:

This script uses the configuration file to schedule and perform the reboots and emails.

<automatic_reboot.sh>

If you notice you need a reboot this week, and are happy with the default dates and times in <generate_dates_thisweek.sh>, you can run this script safely.


TO CANCEL THESE JOBS: as sudo run "atq" to see the list of jobs and their job numbers. Run "atrm [job number]" to kill each job.