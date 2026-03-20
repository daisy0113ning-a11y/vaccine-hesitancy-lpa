# Analysis Code for: Profiles of Hesitancy toward the Herpes Zoster Vaccine among Older Adults in China: A Latent Profile Analysis

This repository contains the R scripts to reproduce the Latent Profile Analysis (LPA) and related figures from the manuscript titled "[在此处再次填入你的论文标题]".

## Data Availability Statement

**Please note:** The dataset (`anonymous_raw_data.xlsx`) required to run these scripts is not publicly available in this repository due to institutional policies regarding participant data.

However, the fully anonymized dataset can be made available from the corresponding author upon reasonable request. Interested researchers are encouraged to contact Lili You at youlily@pumc.edu.cn to request access to the data.

## Repository Contents

-   `scripts/01_lpa_analysis.R`: The R script that performs the LPA to identify the latent profiles from the raw data.
-   `scripts/02_figure1_density_plot.R`: The R script that generates the kernel density plot (Figure 1) from the profiled data.
-   `README.md`: This explanatory file.

## Software Requirements

-   R (version 4.0 or newer recommended)
-   R Packages:
    -   `tidyverse`
    -   `tidyLPA`
    -   `readxl`
    -   `writexl`
    -   `viridis`

You can install all required packages by running the following command in R:
`install.packages(c("tidyverse", "tidyLPA", "readxl", "writexl", "viridis"))`

## Instructions for Reproduction

1.  **Request Data**: Obtain the `anonymous_raw_data.xlsx` file from the corresponding author via the contact information provided in the Data Availability Statement above.

2.  **Run LPA**: Place the received data file in the same directory as the scripts. Then, open and run the `01_lpa_analysis.R` script. This will perform the LPA and generate a new file named `hesitancy_data_profiled.xlsx`.

3.  **Generate Figure**: Open and run the `02_figure1_density_plot.R` script. This will use the file generated in the previous step to create the final plot, `Figure1_Publication_Version.png`.
