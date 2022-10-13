# Specify the base image -- here we're using one that bundles the OpenJDK version of Java 8 on top of a generic Debian Linux OS
FROM rust:bullseye

#Set the working directory to be used when the docker gets run
WORKDIR /usr



# Do a few updates of the base system and install R (via the r-base package)
RUN apt-get update && apt-get upgrade -y

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y build-essential libssl-dev libffi-dev

RUN pip3 install mitmproxy


RUN sed -i '1i deb http://deb.debian.org/debian buster main' /etc/apt/sources.list

RUN apt-get install -y cmake
RUN apt-get update

# RUN pip3 install adblockparser pyre2

RUN git clone https://github.com/deetungsten/mitmproxy-adblock-docker.git

RUN cd mitmproxy-adblock-docker

# RUN pip install -r requirements.txt

# RUN ./update-blocklists

# RUN ./go

# # Install the ggplot2 library and a few other dependencies we want to have available
# RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
# RUN Rscript -e "install.packages('reshape')"
# RUN Rscript -e "install.packages('gplots')"
# RUN Rscript -e "install.packages('ggplot2')"

# # Add the Picard jar file (assumes the jar file is in the same directory as the Dockerfile, but you could provide a path to another location)
# COPY picard.jar /usr/picard.jar