# Specify the base image -- here we're using one that bundles the OpenJDK version of Java 8 on top of a generic Debian Linux OS
FROM arm32v7/python:latest

#Set the working directory to be used when the docker gets run
WORKDIR /usr

# Do a few updates of the base system and install R (via the r-base package)
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y rustc

RUN pip3 install setuptools_rust docker-compose

RUN pip3 install mitmproxy

RUN git clone https://github.com/deetungsten/mitmproxy-adblock-docker.git

# # Install the ggplot2 library and a few other dependencies we want to have available
# RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
# RUN Rscript -e "install.packages('reshape')"
# RUN Rscript -e "install.packages('gplots')"
# RUN Rscript -e "install.packages('ggplot2')"

# # Add the Picard jar file (assumes the jar file is in the same directory as the Dockerfile, but you could provide a path to another location)
# COPY picard.jar /usr/picard.jar