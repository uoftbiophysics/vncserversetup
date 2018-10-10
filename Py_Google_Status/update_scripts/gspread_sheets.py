import gspread
import csv
import sys
from oauth2client.service_account import ServiceAccountCredentials

#must pass your working directory as first argument that contains all system info files and JSON file
working_directory = sys.argv[1]
# use creds to create a client to interact with the Google Drive API
scope = ['https://spreadsheets.google.com/feeds','https://www.googleapis.com/auth/drive' ]
creds = ServiceAccountCredentials.from_json_keyfile_name(working_directory+'my.json', scope)
client = gspread.authorize(creds)
#dictionary format: Google Spreadsheet name: local file name
file_dict = {'Disk Usage':'disk_usage.csv', 'CPU/MEM Usage':'cpumem_usage.csv', 'Graphics Usage':'graphics_usage.csv',
             'System Temps':'temp_status.csv','VNC Servers':'VNC_running.csv' }

for spreadsheet_name, file_name in file_dict.iteritems():

    local_list=[]
    with open(working_directory+file_name, 'r') as csvfile:
        filereader = csv.reader(csvfile, delimiter=',')
        for row in filereader:
            local_list.append(row)

    #get maximum dimensions to make rectangular array encompassing all data
    ymax = len(local_list)
    xmax = len(max(local_list, key=len))

    #now append empty strings to outer_list to pad to make a rectangle
    for row in local_list:
        len_to_pad = xmax - len(row)
        row.extend([""]*len_to_pad)

    #flatten our local list
    flattened_list = [y for x in local_list for y in x]

    #define the same rectangle in the sheet
    SS = client.open(spreadsheet_name)
    worksheet = SS.get_worksheet(0)
    range_string = 'A1:' + str(chr(64+xmax)) + str(ymax)
    cell_list = worksheet.range(range_string)

    #update cells locally
    for data,cell in zip(flattened_list, cell_list):
        cell.value=data

    #update remotely
    worksheet.update_cells(cell_list)
