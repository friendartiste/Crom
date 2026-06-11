#!/bin/bash

### [ VARIABLES ] ###

DOCKER_CONTAINER_NAME=conanexiles-dedicated-server
LOCAL_STEAMAPPS_FOLDER=/opt/conanexiles/game/steamapps/
DOCKER_COMPOSE_FOLDER=/opt/conanexiles

#####################

LOCAL_STEAMAPPS_FOLDER+=appmanifest_443030.acf

if [[ $(docker logs $DOCKER_CONTAINER_NAME 2>&1 | grep "Status report." | tail -n 1 | awk 'match($0, /[Pp]layers=([0-9]+)/, arr) {print arr[1]}') -eq 0 ]]; then
	echo "[$(date -I seconds)]	Nobody around, checking for updates..."
	LOCAL_MANIFEST=$(cat $LOCAL_STEAMAPPS_FOLDER | grep -m 1 '"buildid"' | awk '{gsub(/"/, ""); print $2}')
	REMOTE_MANIFEST=$(docker exec $DOCKER_CONTAINER_NAME steamcmd +login anonymous +app_info_print 443030 +quit 2>&1 | grep "buildid" | awk 'NR==1 {gsub(/"/,""); print $2; exit}')
	if [[ $LOCAL_MANIFEST -ne $REMOTE_MANIFEST ]]; then
		echo "[$(date -I seconds)]	Update is Available! Rebooting Server..."
		cd $DOCKER_COMPOSE_FOLDER
		docker compose down && docker compose up -d 2>&1
	else
		echo "[$(date -I seconds)]	No Updates at this time..."
	fi
else
	echo "[$(date -I seconds)]	Players online! Sleeping..."
fi
