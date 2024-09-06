#!/bin/bash

if [ $(whoami) != 'root' ]; then 
	echo 'Please run as root'
	exit 1
fi

mkdir -p /etc/GnomeTablet/
echo '#!/bin/bash
dbus-send --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock' > /etc/GnomeTablet/gnome-tablet.sh
chmod +x /etc/GnomeTablet/gnome-tablet.sh

echo "$(wget -qLO - https://github.com/christianbraghette/gnome_tablet_login/raw/main/autologin_chusr.sh)" > /tmp/autologin_chusr
chmod +x /tmp/autologin_chusr
mv /tmp/autologin_chusr /bin

echo '[Desktop Entry]                                
Name=Gnome-Tablet
GenericName=Gnome Tablet
Comment=Customization for Gnome on Tablet
Exec=/etc/GnomeTablet/gnome-tablet.sh
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true' > /etc/xdg/autostart/gnome-tablet.desktop

mkdir -p /etc/dconf/profile
echo 'user-db:user
system-db:local' > /etc/dconf/profile/user

mkdir -p /etc/dconf/db/local.d
echo "[org/gnome/mutter]
experimental-features=['scale-monitor-framebuffer']" > /etc/dconf/db/local.d/00-hidpi

mkdir -p /etc/dconf/db/locks
echo '/org/gnome/mutter/experimental-features' > /etc/dconf/db/locks/hidpi

dconf update

echo "Gnome tablet customization installed"
exit 0