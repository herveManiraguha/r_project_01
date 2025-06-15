# R Project – Database Calculations & Statistical Exercises

This repository contains an R workflow that fulfils the "Project Assignment | Exercises" brief (database calculations, Poisson distribution, Chi-square test, multiple linear regression).

---

## Directory structure

```
.
├── input/          # 👉  place your source data here (e.g. Assets_Database.csv)
├── output/         # 👉  script writes every result here (kept under version control for reference)
├── data_analysis.R # main script
└── README.md       # this file
```

> **Note**  
> The repository already contains example artefacts inside `output/`.  
> They are safe to keep; re-running the script will simply overwrite or append to the same files.

---

## Prerequisites

* R (≥ 4.0)
* R packages: `readr`, `dplyr`, `openxlsx`, `visualize`

Install the packages once:

```r
install.packages(c("readr", "dplyr", "openxlsx", "visualize"))
```

or from the shell:

```bash
Rscript -e 'pkgs <- c("readr","dplyr","openxlsx","visualize");
            install.packages(setdiff(pkgs, rownames(installed.packages())), repos="https://cloud.r-project.org")'
```

---

## Usage

1. **Add input data**  
   Copy `Assets_Database.csv` (semicolon separated, comma decimal mark) into the `input/` folder.  
   If you prefer to keep it beside the script, the code has a built-in fallback and will still find it.

2. **Run the workflow**

   ```bash
   Rscript data_analysis.R
   ```

3. **Review outputs**  
   Generated files appear in the `output/` directory:

   | File                           | Contents                                             |
   |--------------------------------|------------------------------------------------------|
   | `Results.xlsx`                 | Sheet "Results" – cell C5 shows two requested sums   |
   | `poisson_pmf.png`              | Poisson PMF plot (λ = 3.6, shaded ≤ 7)               |
   | `poisson_cdf.png`              | Upper-tail plot for P(X ≥ 5)                         |
   | `survey_data.csv`              | Toy survey dataset used for Chi-square test          |
   | `console_output.txt`           | Full console log of the run                          |

---

## What the script does

| Exercise | Operation | Key output |
|----------|-----------|------------|
| 1        | Calculates total amount of Bond-AAA and Cash-Italy-AA; writes to Excel sheet at `Results!C5`. | `Results.xlsx` |
| 2        | Computes `P(X = 7)` and `P(X ≥ 5)` for a Poisson(3.6); saves two plots with the **visualize** package. | `poisson_pmf.png`, `poisson_cdf.png` |
| 3        | Builds a Gender × Smoker contingency table, performs Chi-square test, saves survey CSV. | console output + `survey_data.csv` |
| 4        | Fits multiple linear regression `mpg ~ drat + wt` on *mtcars*, prints summary. | console output |

All informational messages and test summaries are captured in `output/console_output.txt` **as well as** shown on-screen when you run the script.

---

## Re-running & cleaning

The script automatically creates `input/` and `output/` if they don't exist.  
Feel free to delete the contents of `output/` at any time; a fresh run will regenerate everything.

---

© 2025 – Your Name 