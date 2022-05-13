# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y  libz-dev
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y  git

## Add source code to the build stage.
ADD . /squashfs-tools
WORKDIR /squashfs-tools/squashfs-tools

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /squashfs-tools/squashfs-tools/mksquashfs /
