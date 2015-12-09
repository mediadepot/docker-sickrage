#!/usr/bin/env bash
if [ ! -f /srv/sickrage/config/sickbeard.ini ]; then

	confd -onetime -backend rancher -prefix /2015-07-25
	chown -R depot:depot /srv/sickrage
fi

su -c "/usr/bin/python /srv/sickrage/app/SickBeard.py --nolaunch --datadir /srv/sickrage/data --config /srv/sickrage/config/sickbeard.ini" depot
