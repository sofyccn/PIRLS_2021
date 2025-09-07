library(dplyr)
core <- readRDS("data/processed/core_merged.rds")


# Example selections — replace with your exact constructs
analysis <- core %>%
transmute(
student_id,
bullying = bully_scale, # placeholder
belonging = belong_scale, # placeholder
wellbeing = wellbeing_scale, # placeholder
read_pv1 = read_pv1, read_pv2 = read_pv2, read_pv3 = read_pv3, read_pv4 = read_pv4, read_pv5 = read_pv5,
weight = tot_wt
) %>% na.omit()


saveRDS(analysis, "data/processed/analysis_ready.rds")