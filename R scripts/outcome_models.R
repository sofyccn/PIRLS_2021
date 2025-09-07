library(dplyr); library(car); library(emmeans)
dat <- readRDS("data/processed/analysis_ready.rds")
mod <- readRDS("outputs/models/lpa_best.rds")
assign <- mod$assign


A <- bind_cols(dat, assign["class"]) %>% mutate(class = factor(class))
# Example using PV1 only for demo; extend to PVs with Rubin's rules or survey weights.
fit <- lm(read_pv1 ~ class, data = A)
Anova(fit, type = 3)
emmeans(fit, pairwise ~ class)