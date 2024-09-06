#!/bin/bash

if [ $(whoami) == 'root' ]; then 
	echo 'Please run as a user'
	exit 1
fi

user=$(whoami)
n=$(grep -n '[daemon]' /etc/gdm/custom.conf | awk -F ':' '{print $1}')
grep -m $n "" /etc/gdm/custom.conf > /tmp/custom.conf
echo "AutomaticLoginEnable=True
AutomaticLogin=$user" >> /tmp/custom.conf
grep -v "$(grep -m $n "" /etc/gdm/custom.conf)" /etc/gdm/custom.conf >> /tmp/custom.conf
sudo mv /tmp/custom.conf /etc/gdm/custom.conf

#sudo bash ./install_krane_root.sh
sudo bash -c "$(wget -qLO - https://github.com/christianbraghette/gnome_tablet_login/raw/main/gnome_tablet_root.sh)"

exit 0