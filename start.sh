#!/usr/bin/env bash
if [ ! -f /srv/sickrage/config/config.ini ]; then
	#generate the config file for the first time using docker-gen
	#/srv/docker-gen/docker-gen /srv/docker-gen/sickbeard.ini.tmpl /srv/sickrage/config/sickbeard.ini

	cheetah fill --oext ini --env /src/sickrage/config/sickbeard
fi

echo "THIS IS A TEST"
ls -alt /srv/sickrage
ls -alt /srv/sickrage/app

/usr/bin/python /srv/sickrage/app/SickBeard.py \
	--nolaunch \
	--datadir /srv/sickrage/data \
	--config /srv/sickrage/config/sickbeard.ini