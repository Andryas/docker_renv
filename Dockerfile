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