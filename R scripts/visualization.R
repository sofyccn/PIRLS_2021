library(ggplot2); library(dplyr)
A <- readRDS("data/processed/analysis_ready.rds")
mod <- readRDS("outputs/models/lpa_best.rds")
assign <- mod$assign


plot_dat <- bind_cols(A, assign["class"]) |> mutate(class = factor(class))


# Example violin of wellbeing by class
ggplot(plot_dat, aes(x = class, y = wellbeing)) +
geom_violin(trim = FALSE) +
geom_boxplot(width = 0.1)