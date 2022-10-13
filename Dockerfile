# Specify the base image -- here we're using one that bundles the OpenJDK version of Java 8 on top of a generic Debian Linux OS
FROM ubuntu:20.04

#Set the working directory to be used when the docker gets run
WORKDIR /usr

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git


# Do a few updates of the base system and install R (via the r-base package)
RUN git clone https://github.com/AdguardTeam/urlfilter

WORKDIR /usr/urlfilter/cmd

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="America/New_York" apt-get install -y tzdata

RUN apt-get install -y golang-1.16

RUN apt-get install -y golang

RUN update-alternatives --install /usr/bin/go go /usr/lib/go-1.16/bin/go 10

RUN go build -o adguard
RUN openssl genrsa -out demo.key 2048
RUN openssl req -new -x509 -key demo.key -out demo.crt -subj "/C=US/ST=NY/L=NY/O=homeadguard/OU=whome Department/CN="

RUN apt-get install -y curl

RUN curl http://filters.adtidy.org/extension/android-content-blocker/filters/2.txt > adguard_base.txt
RUN curl http://filters.adtidy.org/extension/android-content-blocker/filters/3.txt > adguard_tracking_protection.txt
RUN curl http://filters.adtidy.org/extension/android-content-blocker/filters/4.txt > adguard_social.txt
# CMD mkdir /tmp/docker/
# CMD cp demo.crt /tmp/docker/

# ./adguard -l 0.0.0.0 -p 8118\
#           -c demo.crt\
#           -k demo.key\
#           -f adguard_base.txt\
#           -f adguard_tracking_protection.txt\
#           -f adguard_social.txt