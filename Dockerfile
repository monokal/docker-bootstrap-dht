FROM alpine:latest AS builder

ENV APK_DEPS alpine-sdk build-base git linux-headers tar wget
ENV BOOST_URL https://sourceforge.net/projects/boost/files/boost/1.82.0/boost_1_82_0.tar.gz
ENV BOOST_ROOT /tmp/boost
ENV DHT_REPO_URL https://github.com/bittorrent/bootstrap-dht.git

# Package dependencies installed to compile/execute the "bootstrap-dht" binary.
RUN apk add --no-cache $APK_DEPS &&\
    mkdir $BOOST_ROOT && \
    wget $BOOST_URL -O /tmp/boost.tar.gz && \
    tar -zxvf /tmp/boost.tar.gz -C $BOOST_ROOT --strip-components 1 && \
    cd $BOOST_ROOT && \
    ./bootstrap.sh && \
    ./bootstrap.sh --prefix=/usr && \
    ./b2 install --with-system && \
    git clone $DHT_REPO_URL /tmp/bootstrap-dht &&\
    sed -i 's_uuid/_uuid/detail/_g' /tmp/bootstrap-dht/src/main.cpp &&\
    cd /tmp/bootstrap-dht/ &&\
    ${BOOST_ROOT}/b2 -sBOOST_ROOT=${BOOST_ROOT} toolset=gcc cxxflags="-std=c++11"


FROM alpine:latest
RUN apk add --no-cache boost-dev
COPY --from=builder /tmp/bootstrap-dht/dht-bootstrap /usr/local/bin/

EXPOSE 6881
ENTRYPOINT ["/usr/local/bin/dht-bootstrap"]
