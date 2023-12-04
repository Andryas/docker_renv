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

RUN --mount=type=cache,target=/renv Rscript --vanilla /project/restore.R

COPY golex_*.tar.gz /app.tar.gz
RUN R --vanilla -e 'remotes::install_local("/app.tar.gz", upgrade="never", dependencies=FALSE)'
RUN rm /app.tar.gz

EXPOSE 3838
CMD  ["R", "--vanilla", "-e", "options('shiny.port'=3838,shiny.host='0.0.0.0'); golex::run_app()"]