pkgs <- c(
"tidyverse", "haven", "mclust", "psych", "car", "emmeans",
"srvyr", "janitor", "ggplot2", "kableExtra", "patchwork"
)
install_if_missing <- function(p) if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
invisible(lapply(pkgs, install_if_missing))