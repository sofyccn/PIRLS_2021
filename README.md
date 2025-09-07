# PIRLS 2021: Student Well-Being, Bullying, Belonging & Reading Achievement


**Author:** Sofia Cobo (University of South Florida)
**Lab:** MiNT Lab (USF)


This repository contains analysis for our study using PIRLS 2021 to examine how student well-being, school belonging, and bullying relate to reading achievement in U.S. students. We identify classroom/student profiles via **Latent Profile Analysis (LPA)** and estimate outcome differences (ANOVA + Tukey HSD), following international assessment best practices (plausible values, weights).


> Three profiles found in prior work: (a) High home-language support with Spanish-speaking lead teacher; (b) High support with non-Spanish-speaking lead; (c) Low support. (Replace with finalized profiles from this repo.)


## Methods Overview
- **Data:** PIRLS 2021 Student Context and Achievement files (U.S. sample).
- **Modeling:** LPA using `mclust` (Gaussian mixtures) with model selection by BIC; sensitivity checks for 1–5 classes.
- **Outcomes:** Reading plausible values modeled across profiles with weight-replicate procedures.
- **Software:** R (see session info below).


## Repository Layout
See `R/` scripts 00–07 for a linear pipeline: setup → load → clean → explore → LPA → profile characterization → outcomes → viz.


## Reproducibility
1. Install R  and RStudio.
2. Clone this repo.
3. In R: `install.packages("renv"); renv::init(); renv::restore()`
4. Place PIRLS raw files into `data/raw/`.
5. Run scripts in order: `source("R/00_setup_packages.R")` ... `source("R/07_visualizations.R")`.


**Privacy & Licensing**
- Raw PIRLS data are licensed/restricted. **Do not** commit them.
- We include tiny synthetic/demo snippets only for illustration.


## Results (to fill as you produce them)
- **Profiles:** k = 3 (BIC= …), size: P1 xx%, P2 xx%, P3 xx%
- **Key findings:** (short bullets)
- **Figures:** (link to `docs/figures`)


## How to Cite
See `CITATION.cff`.


## Contact
For questions, open an Issue or contact Sofia Cobo.