options(
    timeout = max(1000, getOption('timeout')), 
    renv.config.auto.snapshot = TRUE
)
renv::restore(exclude=c('renv'))
renv::isolate()