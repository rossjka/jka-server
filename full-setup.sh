read -p "Do you want yberion proxy?" proxy
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
cd ..

if [ "$proxy" = "true" ]; then
  cd servers/yberion-proxy
else
  cd servers/vanilla
fi
chmod +x install.sh
./install.sh
echo "JKA service installed; start with 'sudo systemctl start jka-server'"

if [ ! -z "$apikey" ]; then
  cd ../../vpnmonitor
  sed 's/yourapikey/$apikey' vpnmonitor
  chmod +x install-vpnmonitor.sh 
  ./install-vpnmonitor.sh
  cd ../systemd
  cp vpnmonitor.service /etc/systemd/system/
  systemctl enable vpnmonitor
  echo "VPN service installed; start with 'sudo systemctl start vpnmonitor'"
fi

echo -e "Installation complete"
