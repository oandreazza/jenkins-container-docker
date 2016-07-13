FROM jenkins

USER root

RUN dpkg --add-architecture i386
RUN apt-get update

#INSTALLING DOCKER
RUN apt-get install apparmor lxc docker.io wget zip -y


RUN apt-get install libncurses5:i386 libstdc++6:i386 zlib1g:i386 -y 

#ADDING USER JENKINS TO STAFF GROUP
RUN usermod -a -G staff jenkins

RUN service docker start

#INSTALLING DOCKER-COMPOSE
RUN curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose


# Install Android SDK
RUN mkdir -p /var/Library/Android/sdk
RUN cd /var/Library/Android/sdk && wget -nv http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz && tar xfo android-sdk_r23.0.2-linux.tgz --no-same-permissions && chmod -R a+rX android-sdk-linux
RUN rm -rf /var/Library/Android/sdkandroid-sdk_r23.0.2-linux.tgz

# Install Android tools
RUN echo y | /var/Library/Android/sdk/android-sdk-linux/tools/android update sdk --filter tools --no-ui --force -a
RUN echo y | /var/Library/Android/sdk/android-sdk-linux/tools/android update sdk --filter platform-tools --no-ui --force -a
RUN echo y | /var/Library/Android/sdk/android-sdk-linux/tools/android update sdk --filter platform --no-ui --force -a
RUN echo y | /var/Library/Android/sdk/android-sdk-linux/tools/android update sdk --filter build-tools-23.0.2 --no-ui -a
RUN echo y | /var/Library/Android/sdk/android-sdk-linux/tools/android update sdk --filter sys-img-x86-android-18 --no-ui -a
RUN echo y | /var/Library/Android/sdk/android-sdk-linux/tools/android update sdk --filter sys-img-x86-android-19 --no-ui -a
RUN echo y | /var/Library/Android/sdk/android-sdk-linux/tools/android update sdk --filter sys-img-x86-android-21 --no-ui -a

ENV ANDROID_HOME /var/Library/Android/sdk/android-sdk-linux/

EXPOSE 8080

USER jenkins

VOLUME /var/run/docker.sock

