library(dplyr); library(ggplot2)
dat <- readRDS("data/processed/analysis_ready.rds")
summary(select(dat, bullying, belonging, wellbeing))