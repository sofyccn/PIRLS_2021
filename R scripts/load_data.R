library(haven); library(dplyr); library(janitor)
# Place PIRLS .sav/.dat into data/raw/ (excluded by .gitignore)
# Example (adjust filenames/paths):
student <- read_sav("data/raw/pirls2021_student_US.sav") %>% clean_names()
classroom <- read_sav("data/raw/pirls2021_classroom_US.sav") %>% clean_names()
achieve <- read_sav("data/raw/pirls2021_achieve_US.sav") %>% clean_names()


# Minimal merge (you will refine keys as needed)
core <- student %>% left_join(classrm, by = "class_id") %>% left_join(achieve, by = "student_id")
saveRDS(core, "data/processed/core_merged.rds")