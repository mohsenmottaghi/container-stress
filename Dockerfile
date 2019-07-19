FROM alpine:latest

ENV STRESS_VERSION 1.0.4

RUN apk add g++ make

RUN wget https://people.seas.harvard.edu/~apw/stress/stress-$STRESS_VERSION.tar.gz && \
    tar xzvf stress-$STRESS_VERSION.tar.gz && \
    rm -f stress-$STRESS_VERSION.tar.gz

WORKDIR /stress-$STRESS_VERSION

RUN ./configure && make && make install



