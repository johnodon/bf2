#!/bin/bash

echo "---BF2 Check---"
if [ ! -f "${SERVER_DIR}/start.sh" ]; then
    echo "---BF2 not installed, extracting!---"
    cd /serverfiles
    chmod +x /opt/scripts
    /opt/scripts/extract
fi

echo "---Server ready---"
chmod -R 770 ${DATA_DIR}
echo "---Checking for old logs---"
find /serverfiles/bf2 -name "masterLog.*" -exec rm -f {} \;

echo "---Start Server---"
cd /serverfiles/bf2
./start.sh
