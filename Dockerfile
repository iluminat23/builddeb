FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

# install build basics
RUN apt-get update \
&& apt-get -y install \
	software-properties-common \
	apt-utils \
&& apt-add-repository 'deb http://deb.debian.org/debian buster-backports main' \
&& apt-get update \
&& apt-get -y upgrade \
&& apt-get -y -t buster-backports install \
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