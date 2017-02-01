# protobuf docker

[on docker hub](https://registry.hub.docker.com/u/konsumer/protobuf/)

## What's included:
- protobuf 3.1.0
- gRPC 1.0.1
- Google Well Known Types are automatically included (via `google/`)
- Go related tools compiled with 1.7, gRPC support is built-in:
  - github.com/golang/protobuf/protoc-gen-go
  - github.com/gogo/protobuf/protoc-gen-gofast
  - github.com/gogo/protobuf/protoc-gen-gogo
  - github.com/gogo/protobuf/protoc-gen-gogofast
  - github.com/gogo/protobuf/protoc-gen-gogofaster
  - github.com/gogo/protobuf/protoc-gen-gogoslick
  - github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
  - github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
  - sourcegraph.com/sourcegraph/prototools
  - gRPC gateway generator

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
$ docker run --rm konsumer/protobuf protoc --help
Usage: /usr/bin/protoc [OPTION] PROTO_FILES
```

Don't forget you need to bind mount your files:
```
$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) konsumer/protobuf protoc --python_out=. -I. myfile.proto
```

### documentation

Generate documentation like this:

```
$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) konsumer/protobuf protoc --doc_out=. file.proto
```

### API gateway

You can run a JSON/HTTP gateway like this:

```
$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) konsumer/protobuf gateway echo.proto echo.pb.gw
```

## Google Well Known Types
They are embedded in the image and are included by `protoc` automatically.
They accessible via `google/protobuf/`:
```protobuf
syntax = "proto3";

import "google/protobuf/timestamp.proto";
import "google/protobuf/duration.proto";
```

## Gogo
`gogo.proto` is embedded in the image and can be included with:
```protobuf
syntax = "proto3";

import "github.com/gogo/protobuf/gogoproto/gogo.proto";
```