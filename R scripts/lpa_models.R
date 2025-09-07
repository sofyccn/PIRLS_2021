library(mclust); library(dplyr)
X <- readRDS("data/processed/analysis_ready.rds") %>% select(bullying, belonging, wellbeing)


# Fit 2–5 classes, pick by BIC
fits <- lapply(2:5, function(k) Mclust(data = scale(X), G = k))
bics <- sapply(fits, function(f) f$bic)
K <- which.max(bics) + 1 # because starts at 2
best <- fits[[K - 1]]


# Posterior probabilities and class assignment
assign <- as_tibble(best$z) %>% mutate(class = apply(., 1, which.max))
saveRDS(list(best = best, assign = assign, K = K, BICs = bics), "outputs/models/lpa_best.rds")