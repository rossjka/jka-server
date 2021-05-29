#!/bin/bash

echo "Superleet startup script!"

cd /home/jka-server/server

status=1
while [ $status -ne 0 ]
do
        ./linuxjampded +exec "server.cfg" +set net_port 29070 +set dedicated 1 +set developer 1 >log.txt 2>&1
        status=$?

        if [ $status -ne 0 ]
        then
                date=`/bin/date`
                echo "Server crashed with status "$status" at "$date
        fi
done

echo "Server exited peacefully"
