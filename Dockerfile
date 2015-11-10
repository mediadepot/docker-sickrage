FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Install base applications + deps
RUN apt-get -q update && \
    apt-get install -qy --force-yes python-cheetah python-openssl unrar && \

	curl -L https://github.com/jwilder/docker-gen/releases/download/0.4.3/docker-gen-linux-amd64-0.4.3.tar.gz -o docker-gen.tar.gz && \
	mkdir -p /srv/docker-gen && \
	tar xvzf docker-gen.tar.gz -C /srv/docker-gen  && \
	rm  /docker-gen.tgz && \

    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create sickrage folder structure & set as volumes
RUN mkdir -p /srv/sickbeard/app && \
	mkdir -p /srv/sickbeard/config && \
	mkdir -p /srv/sickbeard/data
VOLUME ["/srv/sickbeard/app", "/srv/sickbeard/config", "/srv/sickbeard/data"]


#Install Sickrage
ENV SICKRAGE_VERSION="master"
RUN curl -L https://github.com/SiCKRAGETV/SickRage/tarball/${SICKRAGE_VERSION} -o sickrage.tgz && \
	tar -xvf sickrage.tgz -C /  && \
	mv /SiCKRAGETV-SickRage-* /srv/sickrage/app && \
	rm  /sickrage.tgz && \

#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
ADD ./docker-gen/sickbeard.ini.tmpl /srv/docker-gen/sickbeard.ini.tmpl
RUN chmod u+x  /srv/start.sh



EXPOSE 8081

CMD ["/start.sh"]