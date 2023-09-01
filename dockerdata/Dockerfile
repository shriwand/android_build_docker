FROM ubuntu:bionic
MAINTAINER Ivan Sharavuev <shriwand@gmail.com>
ARG DEBIAN_FRONTEND=noninteractive

ARG USER_ID
RUN echo "USER_ID: $USER_ID"


RUN dpkg --add-architecture amd64 \
	&& apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
	build-essential locales git-core u-boot-tools wget unzip bc python \
	gcc g++ binutils patch bzip2 flex make gettext \
	pkg-config zlib1g-dev libc6-dev subversion libncurses5-dev gawk \
	sharutils curl libxml-parser-perl ocaml-nox ocaml-nox ocaml ocaml-findlib \
	libpcre3-dev python-yaml pv tar sudo libssl-dev \
	device-tree-compiler cpio libelf-dev software-properties-common \
	automake perl bison gperf libxml2-utils zip unixodbc dos2unix java-common vim autofs \
	g++-multilib lib32z1 bash net-tools repo ccache iputils-ping locales filepp openjdk-8-jdk rsync


RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
        echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
        dpkg-reconfigure --frontend=noninteractive locales && \
        update-locale LANG=en_US.UTF-8

# Set a docker user
RUN ln -sf /bin/bash /bin/sh

## You should change this uid for your user in system (see output from the command: echo $UID)
RUN useradd  -m -u $USER_ID -U docker -G sudo
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENV LC_ALL C
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
## Customise /etc/java-8-openjdk/security/java.security
COPY etc/java-8-openjdk/security/java.security /etc/java-8-openjdk/security/java.security

## set env for docker user ##
WORKDIR /home/docker/android
USER docker
ENV USER docker
