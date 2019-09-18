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
if [ ! -f "/serverfiles/BF2CCD_1.4.2446.zip" ]; then
    echo "---BF2CC source not found, downloading!---"
    wget -nc -q --show-progress --progress=bar:force:noscroll https://www.fullcontactwar.com/files/BF2CCD_1.4.2446.zip
    unzip BF2CCD_1.4.2446.zip –d /serverfiles/bf2
fi
if [ ! -f "/serverfiles/bf2/bf2ccd.exe" ]; then
    echo "---BF2CC files not found, extracting!---"
    unzip BF2CCD_1.4.2446.zip –d /serverfiles/bf2
fi
if [ ! -f "/serverfiles/mono-1.1.12.1_0-installer.bin" ]; then
    echo "---mono installer source not found, downloading!---"
    wget -nc -q --show-progress --progress=bar:force:noscroll https://download.mono-project.com/archive/1.1.12.1/linux-installer/0/mono-1.1.12.1_0-installer.bin
    chmod +x mono-1.1.12.1_0-installer.bin
    /serverfiles/mono-1.1.12.1_0-installer.bin
fi
if [ ! -f "/serverfiles/mono-1.1.12.1_0-installer.bin" ]; then
    echo "---mono installer source not found, downloading!---"
    chmod +x mono-1.1.12.1_0-installer.bin
    /serverfiles/mono-1.1.12.1_0-installer.bin
fi

echo "---Server ready---"
chmod -R 770 ${DATA_DIR}
echo "---Checking for old logs---"
find /serverfiles/bf2 -name "masterLog.*" -exec rm -f {} \;

echo "---Start Server---"
cd /serverfiles/bf2
rm -rf /serverfiles/bf2/start.sh
cp /opt/scripts/start.sh /serverfiles/bf2/start.sh
chmod +x /serverfiles/bf2/start.sh
./start.sh
