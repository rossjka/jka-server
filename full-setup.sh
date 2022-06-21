while true; do
    read -p "Do you want yberion proxy on this server? y/n" yn
    case $yn in
        [Yy] ) proxy=true;;
        [Nn] ) proxy=false;;
        * ) echo "Please answer with y (yes) or n (no)";;
    esac
done
read -p "Enter an API key if you would like to set up VPN protection (otherwise just hit enter): " apikey
read -p "Enter URL to download assets.tgz: " assets

apt-get install wget

cd scripts
chmod +x ./install.sh
./install.sh
cd ../assets
wget $assets -O assets.tgz
tar -xf assets.tgz
rm assets.tgz

if [ "$proxy" = "true" ]; then
  echo "Installing ybeproxy server"
  cd ../servers/yberion-proxy
else
  echo "Installing pure server (no proxy)"
  cd ../servers/vanilla
fi
chmod +x install.sh
./install.sh
echo "JKA service installed"

if [ ! -z "$apikey" ]; then
  cd ../../vpnmonitor
  sed 's/yourapikey/$apikey' vpnmonitor
  chmod +x install-vpnmonitor.sh 
  ./install-vpnmonitor.sh
  cp ../systemd/vpnmonitor.service /etc/systemd/system/
  systemctl enable vpnmonitor
  echo "VPN service installed"
  systemctl start vpnmonitor
fi

cd /home/jka-server/server/base
echo -e "Installation complete"
return 0
