#!/bin/bash

export DOCKER_BUILDKIT=1

echo; echo "building image..."; echo
R -e "devtools::build(path='.');q('no')"
docker buildx build --platform=linux/amd64 --progress=plain -t teste_renv . || exit 1
rm golex_*.tar.gz