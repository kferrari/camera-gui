#!/usr/bin/env bash

# Add raspberry sources (required for travis build)
wget https://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -
echo 'deb http://archive.raspbian.org/raspbian/ buster main contrib non-free' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://archive.raspbian.org/raspbian buster main contrib non-free' | sudo tee -a /etc/apt/sources.list

# Install raspi-config (required for travis build)
sudo apt-get update
sudo apt-get install raspi-config

# Create Code folder and cd into it
echo "Creating Code folder"
sudo mkdir -p /home/pi/Code
cd /home/pi/Code
sudo chown -R travis /home/pi/Code

# Clone into camera-gui repository
echo "Cloning camera-gui repository"
git clone https://github.com/kferrari/camera-gui.git # change this to public repo
if [ ! -d "camera-gui" ]; then
  exit 1
fi

# Enable camera
echo "Enabling camera..."
if sudo raspi-config nonint do_camera 0 ; then
  echo "Success"
else
  exit $?
fi

# Enable I2C for BrightPi control
sudo raspi-config nonint do_i2c 0

# Install python-smbus if not installed
sudo apt-get install python-smbus -y

# Clone into BrightPi repository and run install script
git clone https://github.com/PiSupply/Bright-Pi.git
cd Bright-Pi
sudo python setup.py install

exit $?

# Reboot raspberry
whiptail --msgbox "The system will now reboot" 8 40
sudo reboot
