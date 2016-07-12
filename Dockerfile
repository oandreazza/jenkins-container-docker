FROM jenkins

USER root

RUN apt-get update

#INSTALLING DOCKER
RUN apt-get install apparmor lxc -y
RUN apt-get install docker.io -y

#ADDING USER JENKINS TO STAFF GROUP
RUN usermod -a -G staff jenkins

RUN service docker start

#INSTALLING DOCKER-COMPOSE
RUN curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

EXPOSE 8080

USER jenkins

VOLUME /var/run/docker.sock

