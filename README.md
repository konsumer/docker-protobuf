# protobuf 3 docker

[on docker hub](https://registry.hub.docker.com/u/konsumer/protobuf/)

Docker image with protoc 3 with [doc-generation](https://github.com/estan/protoc-gen-doc) and [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway)

## Usage

    # Just print protobuf help message
    docker run -it --rm \
      konsumer/protobuf protoc --help

    # Generate markdown documentation
    docker run -it --rm  -v $PWD:/src:rw \
      konsumer/protobuf protoc --doc_out=markdown,api.md:. *.proto

    # Generate & run grpc gateway:
    docker run -it --rm  -v $PWD:/src:rw \
      konsumer/protobuf gateway api.proto . api/

    # Use current folder for input and output
    docker run -it --rm -v $PWD:/src:rw \
      konsumer/protobuf protoc --cpp_out=. *.proto

    # If you ran into problems with user uid and gid (consider scripting it)
    docker run -it --rm -v $PWD:/user-src:rw -u $(id -u):$(id -g) -w /user-src \
      konsumer/protobuf protoc --cpp_out=. *.proto

