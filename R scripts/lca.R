# 04_lca_poLCA.R — Latent Class Analysis for categorical items


# === Select manifest categorical indicators (change names if your processed file renamed them) ===
items <- c(
"ASBG06","ASBG07A","ASBG07B",
"ASBG10A","ASBG10B","ASBG10C","ASBG10D","ASBG10E","ASBG10F",
"ASBG11A","ASBG11B","ASBG11C","ASBG11D","ASBG11E","ASBG11F","ASBG11G","ASBG11H","ASBG11I","ASBG11J"
)


# Keep only complete cases across the manifest items (Mplus handled missing; here we do a simple approach)
X <- d |> select(all_of(items), TOTWGT, IDSCHOOL) |> na.omit()


# poLCA formula: all items predicted by a single latent class variable
f <- as.formula(paste("cbind(", paste(items, collapse = ","), ") ~ 1"))


# Helper to fit a model with K classes (one random start per class * 20 recommended)
fit_k <- function(K) {
poLCA(
f, data = X, nclass = K,
weights = X$TOTWGT, # sampling weights
maxiter = 5000, nrep = 20, # multiple random starts to avoid local maxima
verbose = TRUE
)
}


# Fit K = 1:5
set.seed(20251001)
fits <- lapply(1:5, \(K) tryCatch(fit_k(K), error = \(e) { message("K=",K,": ", e$message); NULL }))


# Summarize fit indices
summ <- lapply(seq_along(fits), function(i){
fm <- fits[[i]]; if (is.null(fm)) return(NULL)
tibble(
K = i,
logLik = fm$llik,
df = fm$resid.df,
AIC = fm$aic,
BIC = fm$bic,
Gsq = fm$Gsq
)
}) |> bind_rows() |> arrange(K)
print(summ)
readr::write_csv(summ, "outputs/models/lca_fit_indices.csv")


# Save best model by BIC
best_row <- summ |> filter(BIC == min(BIC))
bestK <- best_row$K[1]
best <- fits[[bestK]]


# Class sizes & item-response probabilities
class_sizes <- tibble(K = bestK, class = seq_len(bestK), size = round(100 * best$P, 1))
print(class_sizes)
readr::write_csv(class_sizes, "outputs/models/lca_class_sizes.csv")


# Export conditional response probabilities per item & category
prob_list <- lapply(names(best$probs), function(var){
pv <- best$probs[[var]] # matrix: categories x classes
as_tibble(pv) |> mutate(category = row_number(), item = var) |> relocate(item, category)
})
probs <- bind_rows(prob_list) |> mutate(K = bestK)
readr::write_csv(probs, "outputs/models/lca_item_probabilities.csv")


# (Optional) Compute a simple entropy-like measure (poLCA doesn’t report Mplus Entropy)
# Using posterior class assignments
post <- as_tibble(best$posterior)
entropy <- -sum(as.matrix(post) * log(pmax(as.matrix(post), 1e-12))) / nrow(post)
cat("Entropy (not Mplus): ", entropy, "
")


saveRDS(list(fits=fits, summary=summ, best=best, bestK=bestK), "outputs/models/lca_poLCA.rds")