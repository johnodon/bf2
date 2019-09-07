FROM ubuntu

MAINTAINER johnodon

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic multiverse" >> /etc/apt/source.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ bionic multiverse">> /etc/apt/source.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ bionic-updates multiverse" >> /etc/apt/source.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ bionic-updates multiverse" >> /etc/apt/source.list
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install wget screen unzip curl expect

ENV DATA_DIR="/serverfiles"
ENV SERVER_DIR="${DATA_DIR}/bf2"
ENV INSTALLER_DIR="${DATA_DIR}/tmp"
ENV SCRIPTS_DIR="/opt/scripts"
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR
RUN mkdir $SERVER_DIR
RUN mkdir $INSTALLER_DIR
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID bf2
RUN chown -R bf2:bf2 $DATA_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R bf2 /opt/scripts

USER bf2

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]
