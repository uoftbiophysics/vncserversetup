#!/bin/bash

#pass working directory as first argument to this script (where you want to store config files)
WORKINGDIR=$1
rm $WORKINGDIR/disk_usage.csv
rm $WORKINGDIR/cpumem_usage.csv
rm $WORKINGDIR/graphics_usage.csv
rm $WORKINGDIR/temp_status.csv

#give home directory disk usage for each user in csv
echo "Home Directory Usage" > $WORKINGDIR/disk_usage.csv
for filename in /media/homes/*;do
if [ "$filename" != "/media/homes/lost+found" ]; then
du -sh $filename | tr -s '[:blank:]' ',' >> $WORKINGDIR/disk_usage.csv
fi
done
echo "" >> $WORKINGDIR/disk_usage.csv
echo "Home Summary" >> $WORKINGDIR/disk_usage.csv
df -h /dev/md/hd0 | tr -s '[:blank:]' ',' >> $WORKINGDIR/disk_usage.csv

#give storage directory disk usage for each user
echo "" >> $WORKINGDIR/disk_usage.csv
echo "Storage Usage" >> $WORKINGDIR/disk_usage.csv
echo "" >> $WORKINGDIR/disk_usage.csv
for filename in /media/storage/*;do
if [ "$filename" != "/media/storage/lost+found" ]; then
du -sh $filename | tr -s '[:blank:]' ',' >> $WORKINGDIR/disk_usage.csv
fi
done
echo "" >> $WORKINGDIR/disk_usage.csv
echo "Storage Summary" >> $WORKINGDIR/disk_usage.csv
df -h /dev/md/sd0 | tr -s '[:blank:]' ',' >> $WORKINGDIR/disk_usage.csv

#hardware usage output to csv
mpstat -P ALL | tr -s '[:blank:]' ',' > $WORKINGDIR/cpumem_usage.csv
echo -e "\n" >> hw_usage.csv
echo "" >> $WORKINGDIR/cpumem_usage.csv
top -n 1 -b | head -20 | tr -s '[:blank:]' ',' >> $WORKINGDIR/cpumem_usage.csv

#provide sensor readout for machine to csv
sensors | tr -s '[:blank:]' ',' > $WORKINGDIR/temp_status_raw.csv
sed -e "s/=/equals/g" $WORKINGDIR/temp_status_raw.csv > $WORKINGDIR/temp_status.csv

#VNC server status (look for ones port etc) to csv
netstat -nlp | grep vnc | tr -s '[:blank:]' ','> $WORKINGDIR/VNC_running.csv

#check status of graphics card
#nvidia-smi | tr -s '[:blank:]' ',' >> $WORKINGDIR/graphics_usage.csv
echo "Summary" > $WORKINGDIR/graphics_usage.csv
nvidia-smi --query-gpu=timestamp,name,driver_version,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv >> $WORKINGDIR/graphics_usage.csv
echo "" >> $WORKINGDIR/graphics_usage.csv
echo "Compute Processes" >> $WORKINGDIR/graphics_usage.csv
nvidia-smi --query-compute-apps=pid,process_name,used_memory --format=csv >> $WORKINGDIR/graphics_usage.csv






