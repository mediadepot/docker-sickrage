FROM mediadepot/base:python

#Create sickrage folder structure & set as volumes
RUN mkdir -p /srv/sickrage/app && \
	mkdir -p /srv/sickrage/config && \
	mkdir -p /srv/sickrage/data

WORKDIR /srv/sickrage/app

# Install permanent apk packages
RUN apk --no-cache --update add py-cheetah openssl-dev bash unrar wget curl \
	--update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

#Create confd folder structure
RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64
RUN chmod u+x  /usr/local/bin/confd
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates

#Download sickrage source
RUN git clone https://github.com/SickRage/SickRage.git /srv/sickrage/app

#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

VOLUME ["/srv/sickrage/app", "/srv/sickrage/config", "/srv/sickrage/data"]
EXPOSE 8081

CMD ["/srv/start.sh"]
