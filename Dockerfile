FROM debian:stable
WORKDIR /opt
ENV DEBIAN_FRONTEND=noninteractive

#RUN echo 'Acquire::http::Proxy "http://192.168.0.100:3142/";' >> /etc/apt/apt.conf.d/000apt-cacher-ng-proxy
RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list \
    && apt-get update && apt-get install --yes --no-install-recommends  \
    apt-transport-https\
    autoconf \
    build-essential \
    ca-certificates \
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
#ENV CC="gcc-10"
RUN mkdir build \
    && cd build \
    && cmake ../ \
    && make install


# Create package
RUN cd build \
    && make install \
