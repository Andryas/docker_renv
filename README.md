# Docker & renv

For those looking for speeding up the package installions in the Dockerfile
and at the same use renv to control the dependencies, ill share with you an approached that i found being useful.

> This approach cache all the packages in the `renv.lock` using buildx.

# Resources

First, it is good to check the documentation in the renv package
when used with docker, [check it out](https://rstudio.github.io/renv/articles/docker.html)

Second, some resources

- [howisonlab/test_repo_buildx_renv](https://github.com/howisonlab/test_repo_buildx_renv/blob/master/renv_install_packages.R)
- [how-to-avoid-reinstalling-packages-when-building-docker-image-for-python-project](https://stackoverflow.com/questions/25305788/how-to-avoid-reinstalling-packages-when-building-docker-image-for-python-project)

---

# How to use it

- Setup your renv ~ "R> renv::init()"
- Create your renv.lock ~ "R> renv::snapshot()"
- Build your image ~ "$ build.sh"


# How it works

## Dockerfile

```
# syntax=docker/dockerfile:1.1-experimental

FROM r-base:4.3.1

RUN R -e 'install.packages("remotes")'

ENV RENV_VERSION 1.0.3
RUN R -e 'remotes::install_github("rstudio/renv", version="${RENV_VERSION}")'

WORKDIR /project
RUN R -e "renv::init()"

COPY renv.lock renv.lock

RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

ENV RENV_PATHS_CACHE=/renv_cache
RUN --mount=type=cache,target=/renv_cache R -e "renv::restore(exclude=c('renv'))"
```

## build.sh

```
#!/bin/bash

export DOCKER_BUILDKIT=1

echo; echo "building image..."; echo
docker buildx build --platform=linux/amd64 -t teste_renv . || exit 1
```