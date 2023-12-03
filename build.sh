#!/bin/bash

export DOCKER_BUILDKIT=1

echo; echo "building image..."; echo
docker buildx build --platform=linux/amd64 --progress=plain -t teste_renv . || exit 1