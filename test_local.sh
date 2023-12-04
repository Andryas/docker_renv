RENV_PATHS_CACHE_HOST=/Users/wavrzenczak/Library/Caches/org.R-project.R/R/renv
RENV_PATHS_CACHE_CONTAINER=/root/.cache

docker run -it --rm \
    -e "RENV_PATHS_CACHE=${RENV_PATHS_CACHE_CONTAINER}" \
    -v "${RENV_PATHS_CACHE_HOST}:${RENV_PATHS_CACHE_CONTAINER}" \
    teste_renv \
    bash