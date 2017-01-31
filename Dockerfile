FROM golang:alpine

MAINTAINER David Konsumer <konsumer@jetboystudio.com>

ADD . /src
WORKDIR /src
VOLUME /src

ENV PROTOBUF_TAG v3.2.0
ENV GOPATH=/go
ENV PATH=/src/bin:${GOPATH}/bin:${PATH}
RUN ./build.sh
