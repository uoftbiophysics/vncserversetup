A suite to monitor a shared VNC server through google spreadsheets (and their integration in a google site). Uses Python and the Google
Drive API. 

On the server these binaries must be installed to get system information:

sysstat, lm-sensors, python-pip, freeipmi-tools, nvidia-settings (if applicable)

(on Ubuntu run sudo apt-get install sysstat lm-sensors python-pip freeipmi-tools nvidia-settings)

Python modules to access the spreadsheets:

gspread, oauth2client

(run pip install gspread oauth2client)

An superficial overview of how this suite works:

Local commands are executed on the server as a cron job at set time intervals. Output from these commands are stored as CSV
files. A Python script also run as a cron job reads these configuration files and updates multiple google sheets owned by a user account
through the Google Drive API. 

Now into some specifics....

<format_output.sh>:

This script runs a collection of packages that gather system information, including: disk usage, CPU usage, temperatures, graphics card usage, and
running VNC servers. 

For each of these commands the output is stored in a CSV file. 

This script should be run as a cron job, so for example if we want status updates every two minutes add the following line
to sudo crontab:

*/2 * * * * /working_directory/format_output.sh /working_directory/

Note that you WILL have to change lines in this script to get it to behave with your system. For example, you must know your storage device names
and mount points to get information about disk usage.

<gspread_sheets.py>:

A Python script that parses the output files above and places the contents into Google spreadsheets. To be able to interact
with Google-anything you need to head to the Google APIs Console and make a new project, where you will have to log in to a Google account. 
Next, enable the Google Drive API. Once enabled, create credentials for Web Server to access Application Data. Then grant your account the Project role
of Editor. 

You will then be prompted to download the JSON file that contains your private key, which guarantees that only your Google account
can make changes to your project files. This JSON file should be in the same directory as the Python script, and its name entered into the creds variable in 
gspread_sheets.py. 

Next create some spreadsheets with the same Google account connected to the API. "Share" these sheets with the email entry in the JSON file,
and start manipulating them with gspread_sheets.py.

If you want regular updates, also run this script as a cron job. For example, making updates to sheets at two minute intervals would look like:

*/2 * * * * /usr/bin/python /working_directory/gspread_sheets.py /working_directory/
















