FROM alpine:latest
MAINTAINER Daniel Middleton <d@monokal.io>

ENV APK_DEPS wget tar git alpine-sdk linux-headers
ENV BOOST_URL https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz
ENV BOOST_ROOT /tmp/boost
ENV DHT_REPO_URL https://github.com/bittorrent/bootstrap-dht.git

# Package dependencies installed to compile/execute the "bootstrap-dht" binary.
RUN apk add --no-cache $APK_DEPS

# Download and extract boost libraries.
RUN mkdir $BOOST_ROOT && \
    wget $BOOST_URL -O /tmp/boost.tar.gz && \
    tar -zxvf /tmp/boost.tar.gz -C $BOOST_ROOT --strip-components 1

# bootstrap.sh uses some relative paths to dependencies so we must be in the
# same directory to execute.
WORKDIR $BOOST_ROOT
RUN ./bootstrap.sh && \
    ./bootstrap.sh --prefix=/usr && \
    ./b2 install --with-system

# Download, compile and install the "bootstrap-dht" binary.
RUN git clone $DHT_REPO_URL /tmp/bootstrap-dht
WORKDIR /tmp/bootstrap-dht
RUN ${BOOST_ROOT}/b2 -sBOOST_ROOT=${BOOST_ROOT} toolset=gcc cxxflags="-std=c++11" && \
    cp /tmp/bootstrap-dht/dht-bootstrap /usr/local/bin/

# Cleanup.
RUN rm -rf /tmp/*

EXPOSE 6881
ENTRYPOINT ["/usr/local/bin/dht-bootstrap"]
