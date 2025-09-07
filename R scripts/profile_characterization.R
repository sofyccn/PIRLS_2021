library(dplyr)
dat <- readRDS("data/processed/analysis_ready.rds")
mod <- readRDS("outputs/models/lpa_best.rds")
assign <- mod$assign


profiles <- bind_cols(dat, assign["class"]) %>%
group_by(class) %>%
summarise(
n = n(),
bullying = mean(bullying),
belonging = mean(belonging),
wellbeing = mean(wellbeing)
)
print(profiles)