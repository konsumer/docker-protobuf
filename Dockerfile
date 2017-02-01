FROM alpine:3.4

MAINTAINER David Konsumer <konsumer@jetboystudio.com>

ENV GRPC_VERSION=1.0.1              \
    PROTOBUF_VERSION=3.1.0          \
    SWIFT_PROTOBUF_VERSION=0.9.24   \
    GOPATH=/go

COPY bin/* /usr/local/bin/
RUN /usr/local/bin/setup_image
