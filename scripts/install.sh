#!/bin/bash

# Run with sudo or as root
#
# This script prepares the server itself to host a JKA server.

echo "Preparing machine to host a Jedi Academy server"

# Enable 32 bit packages and libraries
dpkg --add-architecture i386

# Update package repos
apt-get update

# Install 32 bit c++ libs
apt-get install -y libstdc++6:i386

# Install libcxa.so.1 for the jka server
cp ../libraries/libcxa.so.1 /usr/lib/

# Create a user to run the server process
useradd jka-server -s /bin/bash -p '*'

# Create some initial directories for the user
mkdir /home/jka-server/
mkdir /home/jka-server/server/

# Set ownership of all files in those directories to the new user
chown -R jka-server /home/jka-server/

# Add user to sudoers
usermod -aG sudo jka-server

# Allow user to call iptables without a password when using sudo (VPNMonitor)
echo 'jka-server ALL=(ALL:ALL) NOPASSWD:/usr/sbin/ipables' | sudo EDITOR='tee -a' visudo

# Done
exit




