FROM debian:jessie-slim

RUN export http_proxy=${HTTP_PROXY} && export https_proxy=${HTTP_PROXY} && \
    export DEBIAN_FRONTEND=noninteractive && \
    echo 'deb http://www.linotp.org/apt/debian jessie linotp' > /etc/apt/sources.list.d/linotp.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 913DFF12F86258E5 && \
    apt-get update && apt-get -y install linotp=2.9.3.4-1 python-psycopg2 && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/linotp/linotp.log

ENTRYPOINT [ "paster", "serve", "/etc/linotp2/linotp.ini" ]