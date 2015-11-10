if [ -f /srv/sickbeard/config/config.ini ]
then
	#config file already exists, do nothing
else
	#generate the config file for the first time using docker-gen
	/srv/docker-gen/docker-gen /srv/docker-gen/sickbeard.ini.tmpl /srv/sickbeard/config/sickbeard.ini
fi

/usr/bin/python /srv/sickbeard/app/SickBeard.py \
	--nolaunch \
	--datadir /srv/sickbeard/data \
	-p 8081 \
	--config /srv/sickbeard/config/sickbeard.ini