#!/bin/bash

echo "---BF2 Check---"
if [ ! -f "${SERVER_DIR}/start.sh" ]; then
    echo "---BF2 not found, downloading!---"
    cd /serverfiles
    wget ftp://ftp.bf-games.net/server-files/bf2/bf2-linuxded-1.5.3153.0-installer.tgz
    tar -xvf bf2-linuxded-1.5.3153.0-installer.tgz
    rm -R bf2-linuxded-1.5.3153.0-installer.tgz
    echo "---Prepare Server---"
    chmod +x /opt/scripts
    ./opt/scripts/extract
fi

echo "---Server ready---"
chmod -R 770 ${DATA_DIR}
echo "---Checking for old logs---"
find /serverfiles/bf2 -name "masterLog.*" -exec rm -f {} \;

echo "---Start Server---"
cd /serverfiles/bf2
./start.sh
