# syntax=docker/dockerfile:1.1-experimental

FROM r-base:4.3.1

RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_version("renv", version="1.0.3")'

WORKDIR /project

COPY renv.lock renv.lock

RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY restore.R restore.R
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN R --vanilla -s -e 'renv::restore()'

COPY R/ R/

# CMD  ["R", "-e", "print('It worked')"]