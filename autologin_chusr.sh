#!/bin/bash

if [ $(whoami) != 'root' ]; then 
	echo 'Please run as root'
	exit 1
fi

echo -n 'Write a valid username to autlogin: '
read CHOICE

n=$(grep -n 'AutomaticLogin=' /etc/gdm/custom.conf | awk -F ':' '{print $1}')
grep -m $n "" /etc/gdm/custom.conf > /tmp/custom.conf
echo "AutomaticLogin=$CHOICE" >> /tmp/custom.conf
grep -v "$(grep -m $n "" /etc/gdm/custom.conf)" /etc/gdm/custom.conf >> /tmp/custom.conf
sudo mv /tmp/custom.conf /etc/gdm/custom.conf