#!/bin/bash

echo "---BF2 Check---"
cd /serverfiles
if [ ! -f "/serverfiles/bf2-linuxded-1.5.3153.0-installer.tgz" ]; then
    echo "---BF2 source not found, downloading!---"
    wget -nc -q --show-progress --progress=bar:force:noscroll ftp://ftp.bf-games.net/server-files/bf2/bf2-linuxded-1.5.3153.0-installer.tgz
fi
if [ ! -f "/serverfiles/bf2-linuxded-1.5.3153.0-installer.sh" ]; then
    echo "---BF2 installer not found, extracting!---"
    tar -xvf /serverfiles/bf2-linuxded-1.5.3153.0-installer.tgz -C /serverfiles
fi
if [ ! -f "/serverfiles/bf2/start.sh" ]; then
    echo "---BF2 server files not found, installing!---"
    chmod +x /opt/scripts
    /opt/scripts/extract
fi
if [ ! -f "/serverfiles/BF2Hub-Unranked-Linux-R3.tar.gz" ]; then
    echo "---BF2hub source not found, downloading!---"
    wget -nc -q --show-progress --progress=bar:force:noscroll https://www.bf2hub.com/downloads/BF2Hub-Unranked-Linux-R3.tar.gz
fi

echo "---Server ready---"
chmod -R 770 ${DATA_DIR}
echo "---Checking for old logs---"
find /serverfiles/bf2 -name "masterLog.*" -exec rm -f {} \;

echo "---Start Server---"
cd /serverfiles/bf2
rm -rf /serverfiles/bf2/start.sh
cp /opt/scripts/start.sh /serverfiles/bf2/start.sh
rm -rf /serverfiles/bf2/mods/bf2/settings/maplist.con
cp /opt/scripts/maplist.con /serverfiles/bf2/mods/bf2/settings/maplist.con
rm -rf /serverfiles/bf2/mods/bf2/settings/serversettings.con
cp /opt/scripts/serversettings.con /serverfiles/bf2/mods/bf2/settings/serversettings.con
chmod +x /serverfiles/bf2/start.sh
./start.sh
