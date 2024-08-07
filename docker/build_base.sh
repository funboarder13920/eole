#!/bin/bash
#
# Build and push base image with torch version X and CUDA version Y:
# ./build.sh X Y

set -e

# allow user to run this script from anywhere
# from https://stackoverflow.com/a/246128
# one-liner which will give you the full directory name
# of the script no matter where it is being called from
unset CDPATH
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ROOT_DIR=$DIR/..
cd $ROOT_DIR

TORCH_VERSION="$1"
CUDA_VERSION="$2"
[ -z "$CUDA_VERSION" ] && CUDA_VERSION="12.1.0"

IMAGE="ghcr.io/eole-nlp/eole-base"
TAG="torch$TORCH_VERSION-ubuntu22.04-cuda$CUDA_VERSION"

echo "Building $IMAGE:$TAG with TORCH_VERSION=$TORCH_VERSION,CUDA_VERSION=$CUDA_VERSION"

docker build -t $IMAGE:$TAG --progress=plain -f docker/Dockerfile-base --build-arg TORCH_VERSION=$TORCH_VERSION --build-arg CUDA_VERSION=$CUDA_VERSION --no-cache .
docker push $IMAGE:$TAG
