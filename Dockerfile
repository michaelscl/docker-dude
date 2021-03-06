FROM ubuntu:20.04

ENV DUDE_VERSION=6.47.7

ENV DUDE_STUFF=dude-install-$DUDE_VERSION.exe

COPY container/ /
COPY installer/$DUDE_STUFF /


RUN export DEBIAN_FRONTEND=noninteractive \
  && dpkg --add-architecture i386 \
  && apt-get -qq clean \
  && apt-get -qq update \
  && apt-get -qq install wget gnupg1 software-properties-common apt-utils x11vnc xvfb xdotool p7zip-full
  
RUN wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
  && add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ focal main" \
  && apt-get -qq update \
  && apt-get -qq install --install-recommends winehq-stable

RUN mkdir /dude \
  && 7z x -o/dude /$DUDE_STUFF \
  && chmod +x /dude/dude.exe

RUN apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm --force /$DUDE_STUFF

RUN chmod +x /etc/init.d/dude \
  && update-rc.d dude defaults

EXPOSE 8129


#CMD ["/sbin/my_init"]
