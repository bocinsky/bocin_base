## Adds ffmpeg and ghostscript to rocker/geospatial

FROM rocker/geospatial:3.4.4

MAINTAINER Kyle Bocinsky <bocinsky@gmail.com>

RUN apt-get update

## ffmpeg
RUN apt-get install -y --no-install-recommends \
  git \
  libx264-dev \
  yasm \
  && git clone --depth 1 git://source.ffmpeg.org/ffmpeg \
  && cd ffmpeg \
  && ./configure --enable-gpl --enable-libx264 \
  && make -j4 \
  && make install \
  && cd .. \
  rm -rf ffmpeg

## ghostscript
RUN apt-get install -y --no-install-recommends \
    ghostscript \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

## docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install docker-ce

## Install R package dependencies from stable MRAN repo
RUN install2.r --error \
    ## Packages for Python-like command-line parsing
    devtools \
    optparse \
    ## Package for data aquisition
    FedData \
    ## Packages offering general utilities
    R.utils \
    Hmisc \
    zoo \
    abind \
    mgcv \
    rgbif \
    fields \
    ## Packages for tidy code
    ggthemes \
    purrrlyr \
    ## Plotting
    htmlwidgets \
    plotly \
    bibtex \
    knitcitations

## Update ggplot2 to development version (need 2.2.1.9000 for geom_sf function)
RUN r -e 'devtools::install_github("tidyverse/ggplot2")'
