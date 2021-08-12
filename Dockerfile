FROM debian:bullseye
WORKDIR /opt
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list &&\
    apt-get update && apt-get install --yes --no-install-recommends  \
    apt-transport-https\
    autoconf \
    build-essential \
    build-essential \
    libgflags-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libsodium-dev \
    cmake \
    git \
    pkg-config \
    texinfo


# Clone et
RUN update-ca-certificates \
    && git clone --recurse-submodules --depth 1 https://github.com/MisterTea/EternalTerminal.git -b master \
    && mv EternalTerminal/* .
    
    
# Build
ENV CC="gcc-10"
RUN mkdir build \
    && cd build \
    && cmake ../
    && make install


# Create package
RUN cd build \
    && make install \

