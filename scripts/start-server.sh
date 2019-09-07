#!/bin/bash

echo "---BF2 Check---"
if [ ! -f "/serverfiles/bf2-linuxded-1.5.3153.0-installer.tgz" ]; then
    echo "---BF2 source not found, downloading!---"
    cd /serverfiles
    wget -nc -q --show-progress --progress=bar:force:noscroll ftp://ftp.bf-games.net/server-files/bf2/bf2-linuxded-1.5.3153.0-installer.tgz
    wget -nc -q --show-progress --progress=bar:force:noscroll https://www.bf2hub.com/downloads/BF2Hub-Unranked-Linux-R3.tar.gz
    if [ ! -f "/serverfiles/bf2/start.sh" ]; then
        echo "---Extracting!---"
        tar -xvf /serverfiles/bf2-linuxded-1.5.3153.0-installer.tgz -C /serverfiles
        chmod +x /opt/scripts
        /opt/scripts/extract
    fi        
fi

echo "---Server ready---"
chmod -R 770 ${DATA_DIR}
echo "---Checking for old logs---"
find /serverfiles/bf2 -name "masterLog.*" -exec rm -f {} \;

echo "---Start Server---"
cd /serverfiles/bf2
rm -rf /serverfiles/bf2/start.sh
cp /serverfiles/config/start.sh /serverfiles/bf2/start.sh
chmod +x /serverfiles/bf2/start.sh
./start.sh
