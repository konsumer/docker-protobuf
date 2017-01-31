#!/usr/bin/env sh

set -e

PACKAGES="git build-base autoconf automake libtool qt-dev"

apk add --update $PACKAGES

go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
go get -u github.com/golang/protobuf/protoc-gen-go

git clone https://github.com/google/protobuf -b $PROTOBUF_TAG --depth 1

cd ./protobuf

./autogen.sh && \
  ./configure --prefix=/usr && \
  make -j 3 && \
  make check && \
  make install
cd ..
rm -rf ./protobuf

git clone https://github.com/estan/protoc-gen-doc --depth 1
cd ./protoc-gen-doc
qmake && \
  make &&\
  mv protoc-gen-doc /usr/bin
cd ..
rm -rf protoc-gen-doc

apk del $PACKAGES

apk add --update libstdc++
