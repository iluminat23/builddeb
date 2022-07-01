FROM tianon/raspbian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

ADD "https://raw.githubusercontent.com/RevolutionPi/imagebakery/cdb7ceab47ca5f7b3c21e5708ed6346db67e1697/templates/revpi.list" etc/apt/sources.list.d/revpi.list
ADD "https://github.com/RevolutionPi/imagebakery/raw/master/templates/revpi.gpg" revpi.gpg
RUN apt-key add revpi.gpg \
&& rm revpi.gpg


# install build basics
RUN \
mv /etc/apt/sources.list /etc/apt/sources.list.bak \
&& echo "deb http://mirror.cxserv.de/raspbian/ buster main contrib non-free rpi" > /etc/apt/sources.list \
&& apt-get update \
&& apt-get -y install \
	apt-utils \
	ca-certificates \
	openssl \
	apt-transport-https
#&& mv /etc/apt/sources.list.bak /etc/apt/sources.list

RUN \
apt-get update \
&& apt-get dist-upgrade -y
RUN \
apt-get -y install \
	git \
	build-essential \
	fakeroot \
	devscripts \
	equivs \
	git-buildpackage \
	eatmydata

RUN \
apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN install -d /work
RUN install -d -m 0700 /root/gnupg

COPY run.sh /usr/local/bin
CMD ["/usr/local/bin/run.sh"]