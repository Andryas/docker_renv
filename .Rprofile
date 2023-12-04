source("renv/activate.R")

if (file.exists("~/.Rprofile")) {
    source("~/.Rprofile")
}

if (dir.exists("/build_zone")) {
    options(
        renv.config.connect.timeout = 600L,
        renv.config.connect.retry = 10L,
        renv.config.cache.symlinks = FALSE,
        renv.config.ppm.enabled = TRUE,
        renv.config.activate.prompt = FALSE
    )
}

renv::settings$ignored.packages(c(
    "origination"
))
