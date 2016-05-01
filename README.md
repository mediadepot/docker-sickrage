# Requirements


# Environmental
The following environmental variables must be populated, when running container 

- PUID
- PGID


# Ports
The following ports must be mapped, when running container 

 - 8081 #webui listen 
 
# Volumes
The following volumes must be mapped, when running container 

- :/srv/sickrage/config
- :/srv/sickrage/data
- /mnt/tvshows:/mnt/tvshows
- /mnt/downloads/[Tvshows]:/mnt/downloads
- /mnt/blackhole/[Tvshows]:/mnt/blackhole
