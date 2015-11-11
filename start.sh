#!/usr/bin/env bash
if [ ! -f /srv/sickrage/config/sickbeard.ini ]; then

	cheetah fill --oext ini --env /src/sickrage/config/sickbeard
	chown -R depot:depot /srv/couchpotato
fi

su -c "/usr/bin/python /srv/sickrage/app/SickBeard.py --nolaunch --datadir /srv/sickrage/data --config /srv/sickrage/config/sickbeard.ini" depot
