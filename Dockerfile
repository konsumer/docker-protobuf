FROM phusion/baseimage:16.04

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

# install golang, protoc, protoc-gen-doc
RUN "echo 'deb http://download.opensuse.org/repositories/home:/estan:/protoc-gen-doc/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/protoc-gen-doc.list"
RUN add-apt-repository ppa:ubuntu-lxc/lxd-stable
RUN apt-get update
RUN apt-get -y install golang git protobuf-compiler protoc-gen-doc

# install google proto files and more protoc libs
RUN git clone https://github.com/googleapis/googleapis.git $GOPATH/src/github.com/googleapis/googleapis
RUN ln -s $GOPATH/src/github.com/googleapis/googleapis /protobuf
RUN go get -u \
  github.com/gengo/grpc-gateway/protoc-gen-grpc-gateway \
  github.com/gengo/grpc-gateway/protoc-gen-swagger \
  github.com/golang/protobuf/protoc-gen-go \
  sourcegraph.com/sourcegraph/prototools/cmd/protoc-gen-json \
  sourcegraph.com/sourcegraph/prototools/cmd/protoc-gen-dump

# Clean up APT when done.
# TODO: more cleanup, see znly/protoc for stripping /protobuf and clean out unneeded /go/src
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/usr/bin/protoc", "-I/protobuf"]