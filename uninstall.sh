#!/usr/bin/env bash

# Remove Bright-Pi
sudo rm -R /home/pi/Code/Bright-Pi
sudo rm /usr/local/bin/brightpi*

# Remove camera-gui
sudo rm -R /home/pi/Code/camera-gui

# Remove Code directory only if it's empty
DIR="/home/pi/Code"
if [ ! "$(ls -A $DIR)" ]; then
  sudo rm -R /home/pi/Code
fi

# Reboot raspberry
whiptail --msgbox "Bright-Pi and camera-gui successfully uninstalled" 8 40
