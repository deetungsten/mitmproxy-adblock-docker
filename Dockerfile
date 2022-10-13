# Specify the base image -- here we're using one that bundles the OpenJDK version of Java 8 on top of a generic Debian Linux OS
FROM ubuntu:20.04

#Set the working directory to be used when the docker gets run
WORKDIR /usr



# Do a few updates of the base system and install R (via the r-base package)
RUN git clone https://github.com/AdguardTeam/urlfilter

WORKDIR /usr/urlfilter/cmd

RUN apt install golang

RUN go build -o adguard