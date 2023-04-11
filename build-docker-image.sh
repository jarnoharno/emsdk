#!/usr/bin/env bash

# Exit on error.
set -e

# 3.1.33 is the latest version that has precompiled linux/arm64 binaries.
# Also, 3.1.35 doesn't work with tsembind.
version=3.1.33
alias=latest
image_name=jarnoharno/emsdk

# Build to cache only.
docker buildx build --build-arg=EMSCRIPTEN_VERSION=${version} \
    --tag ${image_name}:${version} --tag ${image_name}:${alias} \
    --platform linux/arm64/v8,linux/amd64 \
    -f docker/Dockerfile \
    .

# Test.
docker run --rm -w /emsdk/docker --net=host ${image_name}:${version} bash test_dockerimage.sh

# Push to Docker Hub.
docker buildx build --build-arg=EMSCRIPTEN_VERSION=${version} \
    --tag ${image_name}:${version} --tag ${image_name}:${alias} \
    --platform linux/arm64/v8,linux/amd64 \
    -f docker/Dockerfile \
    --push \
    .
