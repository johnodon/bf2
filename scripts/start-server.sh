#!/bin/bash

echo "---BF2 Check---"
if [ ! -f "${SERVER_DIR}/start.sh" ]; then
    echo "---BF2 not found, downloading!---"
    cd ${INSTALLER_DIR}
    wget -q - ftp://ftp.bf-games.net/server-files/bf2/bf2-linuxded-1.5.3153.0-installer.tgz
    tar -xvf bf2-linuxded-1.5.3153.0-installer.tgz
    rm -R bf2-linuxded-1.5.3153.0-installer.tgz
fi

echo "---Prepare Server---"
chmod +x $INSTALLER_DIR
./opt/scripts/extract

fi
echo "---Server ready---"
chmod -R 770 ${DATA_DIR}
echo "---Checking for old logs---"
find ${SERVER_DIR} -name "masterLog.*" -exec rm -f {} \;

echo "---Start Server---"
cd ${SERVER_DIR}
screen -S Terraria -L -Logfile ${SERVER_DIR}/masterLog.0 -d -m ${SERVER_DIR}/TerrariaServer.bin.x86_64 ${GAME_PARAMS}
sleep 2
tail -f ${SERVER_DIR}/masterLog.0
