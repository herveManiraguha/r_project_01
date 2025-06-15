########################################################################
##  Project Assignment – FULL R WORKFLOW
##  Packages you may need once: install.packages(c("readr","dplyr",
##                                                "openxlsx","visualize"))
########################################################################
library(readr)     # data import
library(dplyr)     # data wrangling
library(openxlsx)  # Excel writing
library(visualize) # quick probability visuals

## Directory setup ----------------------------------------------------------
input_dir  <- "input"   # place input datasets here
output_dir <- "output"  # all outputs will be written here

dir.create(input_dir,  showWarnings = FALSE)
dir.create(output_dir, showWarnings = FALSE)

# start logging console output
sink(file.path(output_dir, "console_output.txt"), split = TRUE)

# ─────────────────────────  Exercise 1  ───────────────────────────────
asset_db_path <- file.path(input_dir, "Assets_Database.csv")
if (!file.exists(asset_db_path)) asset_db_path <- "Assets_Database.csv"
db <- read_delim(asset_db_path, delim = ";", locale = locale(decimal_mark = ",")) %>%
  mutate(AssetClass = Instrument)

results <- db %>% 
  summarise(`Bond AAA`  = sum(Amount[AssetClass == "Bond" &
                                     Rating     == "AAA"], na.rm = TRUE),
            `Cash IT AA`= sum(Amount[AssetClass == "Cash" &
                                     Country    == "Italy" &
                                     Rating     == "AA"],  na.rm = TRUE))

wb <- createWorkbook()
addWorksheet(wb, "Results")
writeData(wb, "Results", results, startCol = 3, startRow = 5)
saveWorkbook(wb, file.path(output_dir, "Results.xlsx"), overwrite = TRUE)

cat("\n–– Exercise 1 done • Results.xlsx written\n")

# ─────────────────────────  Exercise 2  ───────────────────────────────
λ <- 3.6                               # arrivals per 10-minute interval
prob_7     <- dpois(7, λ)
prob_ge_5  <- ppois(4, λ, lower.tail = FALSE)

cat(sprintf(
  "\nPoisson (λ = %.1f)\n  P(X = 7)   = %.4f\n  P(X ≥ 5) = %.4f\n",
  λ, prob_7, prob_ge_5))

## Probability distribution using visualize package (highlight ≤ 7)
png(file.path(output_dir, "poisson_pmf.png"), width = 800, height = 600, res = 150)
visualize.pois(stat = 7, lambda = λ, section = "lower")
dev.off()

## upper-tail shading for P(X ≥ 5)
png(file.path(output_dir, "poisson_cdf.png"),  width = 800, height = 600, res = 150)
visualize.pois(stat = 5, lambda = λ, section = "upper")
title(main = sprintf("P(X ≥ 5) = %.4f", prob_ge_5))
dev.off()

cat("–– Exercise 2 done • poisson_pmf.png & poisson_cdf.png written\n")

# ─────────────────────────  Exercise 3  ───────────────────────────────
cat("\n--- Exercise 3: Chi-square Test --------------------------------\n")
Gender <- c("Male","Female","Male","Female","Male",
            "Female","Male","Female","Male","Female")
Smoker <- c("Yes","No","No","Yes","Yes",
            "No","No","Yes","Yes","No")
survey_data <- data.frame(Gender, Smoker)
write_csv(survey_data, file.path(output_dir, "survey_data.csv"))

tbl   <- table(survey_data)
chisq <- chisq.test(tbl)

cat("\nChi-square test (Gender × Smoker):\n")
print(tbl)
print(chisq)

cat("–– Exercise 3 done • Chi-square test completed\n")

# ─────────────────────────  Exercise 4  ───────────────────────────────
cat("\n--- Exercise 4: Multiple Linear Regression ----------------------\n")
data(mtcars)              # built-in
model <- lm(mpg ~ drat + wt, data = mtcars)

cat("\nMultiple linear regression:  mpg ~ drat + wt\n")
print(summary(model))

cat("\nAll tasks completed – files ready in the output directory.\n")

# stop logging
sink()
