#!/bin/bash

while true; do
    read -p "Do you want yberion proxy on this server? y/n: " yn
    case $yn in
        [Yy] ) servertype=ybeproxy; break;;
        [Nn] ) servertype=pure; break;;
        * ) echo "Please answer with y (yes) or n (no)";;
    esac
done
read -p "Enter an API key if you would like to set up VPN protection (otherwise just hit enter): " apikey
read -p "Enter URL to download assets.tgz: " assets

apt-get -y install wget

cd scripts
chmod +x ./install.sh
./install.sh
cd ../assets
wget $assets -O assets.tgz
tar -xf assets.tgz
rm assets.tgz

if [ "$servertype" = "ybeproxy" ]; then
  echo "Installing ybeproxy server"
  cd ../servers/yberion-proxy
else
  echo "Installing pure server (no proxy)"
  cd ../servers/vanilla
fi
chmod +x install.sh
./install.sh
echo -e "\n\n======================"
echo "JKA service installed"
echo -e "======================\n\n"

if [ ! -z "$apikey" ]; then
  cd ../../vpnmonitor
  sed 's/yourapikey/$apikey' vpnmonitor
  chmod +x install-vpnmonitor.sh 
  ./install-vpnmonitor.sh
  cp ../systemd/vpnmonitor.service /etc/systemd/system/
  systemctl enable vpnmonitor
  echo -e "\n\n======================"
  echo "VPN service installed"
  echo -e "======================\n\n"
  systemctl start vpnmonitor
  vpnstatus="VPN Monitor is on"
else
  echo "Skipping installation of VPN service"
  vpnstatus="VPN Monitor was not installed"
fi

cd /home/jka-server/server/base
echo -e "Installation complete! Server type is $servertype and $vpnconfirmation"

exit 0
