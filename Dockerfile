## Adds ffmpeg and ghostscript to rocker/geospatial

FROM rocker/geospatial:3.4.1

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
    ghostscript
