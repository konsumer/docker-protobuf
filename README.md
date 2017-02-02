# protobuf docker

[on docker hub](https://registry.hub.docker.com/u/konsumer/protoc)

## What's included:
- protobuf 3.1.0
- gRPC 1.0.1
- Google Well Known Types are automatically included (via `google/`)
- [protoc-gen-doc](https://github.com/estan/protoc-gen-doc)
- Go related tools compiled with 1.7, gRPC support is built-in:
  - github.com/golang/protobuf/protoc-gen-go
  - github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
  - github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
  - protoc-gen-json & protoc-gen-dump from [sourcegraph/prototools](https://github.com/sourcegraph/prototools)

## Supported languages
- C++
- C#
- Java / JavaNano (Android)
- JavaScript
- Objective-C
- Python
- Ruby
- Go
- Swift

## Usage
```
$ docker run --rm konsumer/protoc --help
Usage: /usr/bin/protoc [OPTION] PROTO_FILES
```

Don't forget you need to bind mount your files:
```
$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) konsumer/protoc --python_out=. -I. myfile.proto
```

## Google Well Known Types
They are embedded in the image and are included by `protoc` automatically.
They accessible via `google/protobuf/`:
```protobuf
syntax = "proto3";

import "google/protobuf/timestamp.proto";
import "google/protobuf/duration.proto";
```

