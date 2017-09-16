FROM centos:7

MAINTAINER "Kasper Mol" <awsumthx@gmail.com>

# Install dependencies
RUN yum -y install wget
RUN yum -y install xz

# Download and untar factorio headless server
RUN wget -O /tmp/factorio_headless.tar.xz https://www.factorio.com/get-download/0.15.34/headless/linux64

WORKDIR /opt

RUN tar -xJf /tmp/factorio_headless.tar.xz
RUN rm /tmp/factorio_headless.tar.xz

# Copy over saves and settings
WORKDIR /opt/factorio

ADD saves saves
ADD server-settings.json data/server-settings.json

# Start up server!
EXPOSE 1337/udp

CMD /opt/factorio/bin/x64/factorio --start-server /opt/factorio/saves/save.zip --server-settings /opt/factorio/data/server-settings.json --port 1337