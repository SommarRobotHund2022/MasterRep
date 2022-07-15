#!/usr/bin/bash

printf "Updating packages...\n"
sudo apt-get update -y > /dev/null
printf "Done!\n\n"

printf "Installing required packages...\n"
printf "Installing libatlas-base-dev...\n"
sudo apt-get install libatlas-base-dev -y > /dev/null
printf "Installing libjasper-dev...\n"
sudo apt-get install libjasper-dev -y > /dev/null
printf "Installing libhdf5-dev...\n"
sudo apt-get install libhdf5-dev -y > /dev/null
printf "Installing libopencv-dev...\n"
sudo apt-get install libopencv-dev -y > /dev/null
printf "Installing python...\n"
sudo apt-get install python -y > /dev/null
printf "Installing python3...\n"
sudo apt-get install python3 -y > /dev/null
printf "Installing python3-opencv...\n"
sudo apt-get install python3-opencv -y > /dev/null
printf "Done!\n\n"

# Removing python 2.7.x
printf "Removing python 2.7.x... "
sudo rm /usr/bin/python
sudo ln /usr/bin/python3 /usr/bin/python
printf "Done!\n\n"

printf "Installing pip reqiurements..."
sudo pip install -r requirements.txt > /dev/null
printf "Done!\n\n"

printf "Downloading submodules...\n"
# Download and update submodules
git submodule init 2>&1 >/dev/null
git submodule update --init --recursive 2>&1 >/dev/null
git submodule foreach git pull origin master 2>&1 >/dev/null
printf "Done!\n\n"

printf "Moving submodules... "
mv AutoPi ~/
mv PiServer ~/
mv Serial-Daemon ~/
printf "Done!\n"

printf "Installing Server and Daemon... "
cd ../PiServer && chmod +x install.sh && ./install.sh
printf "Done!\n"
printf "Installing Serial Daemon service... "
cd ../Serial-Daemon && chmod +x install.sh && ./install.sh
printf "Done!\n"