# Base ubuntu image 
FROM ubuntu:focal

LABEL maintainer="Everett Blakley" \
  description="Basic C++ for comp sci at ULeth" \
  version="0.1.0"

# Setting up tzdata to not prompt for input
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
  apt-get install -y tzdata

# Get all the required packages for the image
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \ 
  git \
  curl \
  gcc-9 \
  g++ \
  build-essential \
  cmake \
  unzip \
  python3 \
  python3-pip \
  lcov \
  valgrind \
  flex \
  bison \
  ca-certificates \
  cppcheck \
  tar && \  
  apt-get autoclean && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Doxygen
RUN git clone "https://github.com/doxygen/doxygen.git" /usr/local/src/doxygen
RUN mkdir /usr/local/src/doxygen/build
WORKDIR /usr/local/src/doxygen/build
RUN cmake -G "Unix Makefiles" ..
RUN make
RUN make install

# Install gtest and gmock
RUN git clone https://github.com/google/googletest /usr/local/src/googletest
RUN mkdir /usr/local/src/googletest/build
WORKDIR /usr/local/src/googletest/build
RUN cmake .. -DCMAKE_CXX_STANDARD=17
RUN make
RUN make install

# Install cpplint
RUN pip3 install cpplint

# Install nlohmann/json
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \
  nlohmann-json3-dev

RUN git clone --recursive "https://github.com/corvusoft/restbed.git" /usr/local/src/restbed
RUN mkdir /usr/local/src/restbed/build
WORKDIR /usr/local/src/restbed/build
RUN cmake -DBUILD_SSL=NO ..
RUN make DESTDIR=/usr/local install
RUN make tests
