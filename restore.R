options(
    timeout = 600000,
    renv.config.auto.snapshot = TRUE
)
renv::restore(exclude = c("renv"))
renv::isolate()
