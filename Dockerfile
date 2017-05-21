FROM lsiobase/mono
MAINTAINER ullbergm

# environment settings
ENV XDG_CONFIG_HOME="/config/xdg"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Ullberg.us version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install emby
RUN \
  apt-get update \
  && apt-get install -y wget at \
  && wget -qO - http://download.opensuse.org/repositories/home:hurricanehernandez:emby-server/xUbuntu_16.04/Release.key | apt-key add - \
  && echo 'deb http://download.opensuse.org/repositories/home:/hurricanehernandez:/emby-server/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/emby-server.list \
  && apt-get update \
  && apt-get install -y embymagick libembysqlite3-0

COPY emby-server_3.2.13.0_all.deb /tmp

RUN \
  dpkg -i /tmp/emby-server_3.2.13.0_all.deb \

# clean up
  && rm -rf \
	/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 8096
VOLUME /config /downloads /movies
