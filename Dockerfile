FROM  tutum/debian:jessie
MAINTAINER jhall@ciena.com

# Install JDK 8
RUN apt-get update && apt-get -y -q install software-properties-common && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    rm -rf /var/cache/oracle-jdk8-installer

# Install other dependencies and remove systemd
RUN apt-get update && \
    apt-get install -qqy sudo \
                         git \
                         maven \
                         net-tools \
                         wget \
                         sysvinit-core \
                         sysvinit \
                         sysvinit-utils \
                         curl \
                         vim \
                         man \
                         faketime \
                         unzip \
                         libjna-java \
                         gnuplot \
                         iptables \
                         iputils-ping \
                         logrotate \
                         iproute2 \
                         bzip2 \
                         rsyslog && \
    apt-get remove -y --purge --auto-remove systemd

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
