#!/bin/bash
a=`df -h | grep /dev/xvda1 | awk '{print $5}' | cut -d'%' -f1`
b=`find /var/local/atlassian/confluence/backups/ -atime +7 | sort -nr | tail -1`
#df -h > /home/bhimavarapureddy/confluencedisk.out
if [ $a -le 80 ]
then
echo "#"
echo "Current Disk:$a %"
echo "exiting"
exit
fi

if [ -z "$b" ]
then
echo "#"
echo "No backup files more than 7 days"
echo "exiting"
exit
else
echo "#"
#echo "disk space reached threshold"
fi

echo "Processing.."
sudo su - <<EOF
echo "#moving $b to S3"
echo
aws s3 mv $b s3://backup/custom_backups/ > /home/bhimavarapureddy/confout.out
EOF
