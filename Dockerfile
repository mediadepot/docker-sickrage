FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Create internal depot user (which will be mapped to external DEPOT_USER, with the uid and gid values)
RUN groupadd -g 15000 -r depot && useradd --uid 15000 -r -g depot depot

#Install base applications + deps
RUN echo "deb http://http.us.debian.org/debian stable main contrib non-free" | tee -a /etc/apt/sources.list
RUN apt-get -q update && \
    apt-get install -qy --force-yes python-cheetah python-openssl unrar curl && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create confd folder structure
RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-linux-amd64
RUN chmod u+x  /usr/local/bin/confd
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates

#Create sickrage folder structure & set as volumes
RUN mkdir -p /srv/sickrage/app && \
	mkdir -p /srv/sickrage/config && \
	mkdir -p /srv/sickrage/data


#Install Sickrage
ENV SICKRAGE_VERSION="master"
RUN curl -L https://github.com/SiCKRAGETV/SickRage/tarball/${SICKRAGE_VERSION} -o sickrage.tgz && \
	tar -xvf sickrage.tgz -C /  && \
	cp -R /SiCKRAGETV-SickRage-*/. /srv/sickrage/app/ && \
	rm  /sickrage.tgz

#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

VOLUME ["/srv/sickrage/app", "/srv/sickrage/config", "/srv/sickrage/data"]

EXPOSE 8080

CMD ["/srv/start.sh"]