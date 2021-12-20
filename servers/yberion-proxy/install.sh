#!/bin/bash

# Run this script as root or with sudo
#
# This script will install a yberion base server in /home/jka-server/server

echo "Copying asset files, this could take 1-2 minutes"

# Construct JKA server directory
cp -r base/ /home/jka-server/server/base/
cp ../../assets/* /home/jka-server/server/base/
cp ../linuxjampded /home/jka-server/server/
cp ../../scripts/wrap-start-server.sh /home/jka-server/server/
cp ../../systemd/jka-server.service /etc/systemd/system/

echo "Copy finished"

chmod +x /home/jka-server/server/wrap-start-server.sh
chmod +x /home/jka-server/server/linuxjampded

chown -R jka-server /home/jka-server/server/
systemctl enable jka-server
systemctl start jka-server

echo "Yberion Proxy base server installed."
