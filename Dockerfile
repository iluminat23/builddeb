FROM tianon/raspbian:stretch-slim

ARG DEBIAN_FRONTEND=noninteractive

ADD "https://raw.githubusercontent.com/RevolutionPi/imagebakery/eee1738b82dd3a8c9b79f8e7ecc901bce39ac819/templates/revpi.list" etc/apt/sources.list.d/revpi.list
ADD "https://github.com/RevolutionPi/imagebakery/raw/master/templates/revpi.gpg" revpi.gpg
RUN apt-key add revpi.gpg \
&& rm revpi.gpg


# install build basics
RUN \
mv /etc/apt/sources.list /etc/apt/sources.list.bak \
&& echo "deb http://mirror.chaoticum.net/rpi/raspbian/ stretch main contrib non-free rpi" > /etc/apt/sources.list \
&& apt-get update \
&& apt-get -y install \
	ca-certificates \
	openssl \
&& mv /etc/apt/sources.list.bak /etc/apt/sources.list \
&& apt-get update \
&& apt-get -y install \
	build-essential \
	fakeroot \
	devscripts \
	git-buildpackage \
	eatmydata \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN install -d /work
RUN install -d -m 0700 /root/gnupg

COPY run.sh /usr/local/bin
CMD ["/usr/local/bin/run.sh"]