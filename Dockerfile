FROM ubuntu

MAINTAINER johnodon

RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install wget screen unzip curl

ENV DATA_DIR="/home/bf2"
ENV SERVER_DIR="${DATA_DIR}/bf2"
ENV INSTALLER_DIR="${DATA_DIR}/installer"
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR
RUN mkdir $SERVER_DIR
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID bf2
RUN chown -R bf2 $DATA_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R terraria /opt/scripts

USER bf2

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]
