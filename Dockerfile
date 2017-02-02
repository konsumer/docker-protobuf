FROM phusion/baseimage:0.9.19

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN echo 'deb http://download.opensuse.org/repositories/home:/estan:/protoc-gen-doc/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/protoc-gen-doc.list && \
  add-apt-repository ppa:ubuntu-lxc/lxd-stable && \
  apt-get update && \
  apt-get -y --allow-unauthenticated install golang git protobuf-compiler protoc-gen-doc && \
  git clone https://github.com/googleapis/googleapis.git $GOPATH/src/github.com/googleapis/googleapis && \
  ln -s $GOPATH/src/github.com/googleapis/googleapis /protobuf && \
  go get -u \
    github.com/gengo/grpc-gateway/protoc-gen-grpc-gateway \
    github.com/gengo/grpc-gateway/protoc-gen-swagger \
    github.com/golang/protobuf/protoc-gen-go \
    sourcegraph.com/sourcegraph/prototools/cmd/protoc-gen-json \
    sourcegraph.com/sourcegraph/prototools/cmd/protoc-gen-dump && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TODO: more cleanup
# - see znly/protoc for stripping /protobuf
# - clean out unneeded /go/src
# - clean out all C build utils

ENTRYPOINT ["/usr/bin/protoc", "-I/protobuf"]