FROM alpine:latest

ENV STRESS_VERSION 1.0.4

COPY stress-$STRESS_VERSION.tar.gz . 

RUN apk update --no-cache && \
    apk add --no-cache g++ make && \
    tar xzvf stress-$STRESS_VERSION.tar.gz && \
    rm -f stress-$STRESS_VERSION.tar.gz && \
    cd stress-$STRESS_VERSION && \
    ./configure && make && make install && \
    cd / && rm -rf /stress-$STRESS_VERSION && \
    apk del --rdepends --purge gcc make

CMD [ "stress", "--help" ]

