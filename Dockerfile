FROM fedora:31
LABEL maintainer="p.g.richardson@phantomjinx.co.uk"

RUN dnf install -y bind \
 wget unzip hostname which perl perl-Net-SSLeay \
 perl-Time-Local perl-Encode-Detect perl-Data-Dumper \
 iputils net-tools procps-ng \
 && wget http://www.webmin.com/download/rpm/webmin-current.rpm \
 && rpm -Uvh webmin-current.rpm
 
#RUN apt-get update \
# && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg \
# && apt-key adv --fetch-keys http://www.webmin.com/jcameron-key.asc \
# && echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list \
# && rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
# && apt-get update \
# && DEBIAN_FRONTEND=noninteractive apt-get install -y \
#      bind9=1:${BIND_VERSION}* bind9-host=1:${BIND_VERSION}* dnsutils \
#      webmin=${WEBMIN_VERSION}* libsocket6-perl \
#      iputils-ping \
# && rm -rf /var/lib/apt/lists/*

ENV BIND_USER=named \
 DATA_DIR=/data

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp 10000/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/named"]
