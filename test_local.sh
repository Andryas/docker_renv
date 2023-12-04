# RENV_PATHS_CACHE_HOST=/Users/wavrzenczak/Library/Caches/org.R-project.R/R/renv
# RENV_PATHS_CACHE_CONTAINER=/root/.cache

docker run -t --rm \
    -p 3838:3838 \
    teste_renv 

# -e "RENV_PATHS_CACHE=${RENV_PATHS_CACHE_CONTAINER}" \
# -v "${RENV_PATHS_CACHE_HOST}:${RENV_PATHS_CACHE_CONTAINER}" \