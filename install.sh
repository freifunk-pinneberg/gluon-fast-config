#!/bin/bash
# Installation des Fast-Config-Modes auf einen Router
# Vorraussetzung:
# - Der Router ist über IP4 / IP6 erreichbar
# - ssh/scp-Zugang ist konfiguriert (Vorzugsweise KEY)
if [ "$1" == '' ]
  then
    echo "Bitte die IP des Routers als Parameter mit angeben"
    exit 1
fi

echo ""
echo "Fast-Config-Mode für GLUON"
echo ""
echo "Installation auf $1 läuft..."
echo ""
echo "Kopieren der Dateien (LUA)..."
scp -r ./fcm/ root@$1:/usr/lib/lua/
echo ""
echo "Kopieren der Dateien (Webserver)..."
scp -r ./www/ root@$1:/lib/gluon/status-page/
echo ""
echo "Kopieren der Dateien (Hotplug)"
scp -r ./button/ root@$1:/etc/hotplug.d/
echo ""
echo "Kopieren der Dateien (libs)..."
scp -r ./lib/ root@$1:/usr/lib/
echo ""
echo "Kopieren der Dateien (bins)..."
scp -r ./bin/ root@$1:/usr/bin/
echo ""
echo "Fertig."
echo ""
