FROM phusion/baseimage:0.9.19

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN cd /tmp && \
  echo 'deb http://download.opensuse.org/repositories/home:/estan:/protoc-gen-doc/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/protoc-gen-doc.list && \
  apt-get update && \
  apt-get -y --allow-unauthenticated install unzip golang git protoc-gen-doc && \
  git clone https://github.com/googleapis/googleapis.git /protobuf && \
  curl -L https://github.com/google/protobuf/releases/download/v3.1.0/protoc-3.1.0-linux-x86_64.zip -o protoc.zip && \
  unzip protoc.zip && \
  mv bin/protoc /usr/local/bin && \
  mv include/google/protobuf /protobuf/google/ && \
  go get -u \
    github.com/gengo/grpc-gateway/protoc-gen-grpc-gateway \
    github.com/gengo/grpc-gateway/protoc-gen-swagger \
    github.com/golang/protobuf/protoc-gen-go \
    sourcegraph.com/sourcegraph/prototools/cmd/protoc-gen-json \
    sourcegraph.com/sourcegraph/prototools/cmd/protoc-gen-dump && \
  apt-get remove -y --purge unzip git curl && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TODO: more cleanup
# - see znly/protoc for stripping /protobuf
# - clean out unneeded /go/src
# - clean out all C/C++ build utils

ENTRYPOINT ["/usr/local/bin/protoc", "-I/protobuf"]
CMD ["--help"]