#!/bin/bash
echo "please make sure you have already edited 'vpnmonitor' with required input before starting this -- follow the readme"
echo "installing sqlite3"
apt-get -y install sqlite3
echo "installing screen"
apt-get -y install screen
echo "creating database 'jkadb.sqlite'"
sqlite3 jkadb.sqlite "CREATE TABLE iplist (id INTEGER PRIMARY KEY AUTOINCREMENT, ip varchar(30), vpn int, date DATETIME DEFAULT CURRENT_TIMESTAMP);"
echo "finished creating database 'jkadb.sqlite'"
echo "you can now start the VPN monitor with ./startvpnmonitor"
