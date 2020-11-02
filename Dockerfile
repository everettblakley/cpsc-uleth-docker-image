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
  clang-format \
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

# Install restbed
RUN git clone --recursive "https://github.com/corvusoft/restbed.git" /usr/local/src/restbed
RUN mkdir /usr/local/src/restbed/build
WORKDIR /usr/local/src/restbed/build
RUN cmake -DBUILD_SSL=NO ..
RUN make install
RUN make test

# Copy restbed files to better location
RUN cp -r /usr/local/src/restbed/distribution/include/* /usr/local/include
RUN cp -a /usr/local/src/restbed/distribution/library/* /usr/local/lib

# Link the libraries
RUN ldconfig

# Install nlohmann/json
RUN git clone "https://github.com/nlohmann/json" /usr/local/src/nlohmann
RUN cp -r /usr/local/src/nlohmann/single_include/* /usr/local/include/

# Clean up source code to keep image smaller
WORKDIR /
RUN rm -rf /usr/local/src/*

# Install wget
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends \ 
  wget \
  apt-get autoclean && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install ZSH with "avit" theme
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
  -t avit -p git
