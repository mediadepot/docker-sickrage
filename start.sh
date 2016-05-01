#!/usr/bin/env sh

#run the default config script
sh /srv/config.sh

#chown the sickrage directory by the new user
chown mediadepot:mediadepot -R /srv/sickrage

# download the latest version of SickRage
[[ ! -d /srv/sickrage/app/.git ]] && su -c "git clone https://github.com/SickRage/SickRage.git /srv/sickrage/app" mediadepot

# opt out for autoupdates using env variable
if [ -z "$ADVANCED_DISABLEUPDATES" ]; then
	# update the application
	cd /srv/sickrage/app/ && su -c "git pull" mediadepot
fi

# run SickRage
su -c "/usr/bin/python /srv/sickrage/app/SickBeard.py --nolaunch --datadir /srv/sickrage/data --config /srv/sickrage/config/sickbeard.ini" mediadepot
