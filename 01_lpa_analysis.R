# ===================================================================
# SCRIPT 01: LATENT PROFILE ANALYSIS (LPA)
# -------------------------------------------------------------------
# Description: This script performs the core Latent Profile Analysis
#              to identify distinct profiles of vaccine hesitancy
#              based on the 5C scale scores.
# Input:       "anonymous_raw_data.xlsx" (The raw, anonymized data)
# Output:      "hesitancy_data_profiled.xlsx" (Data with profile assignments)
# ===================================================================


# --- Step 0: Setup Environment ---
# Install packages if you haven't already
# install.packages(c("tidyverse", "tidyLPA", "readxl", "writexl"))

library(tidyverse)
library(tidyLPA)
library(readxl)

# --- Step 1: Load and Prepare Data ---
# IMPORTANT: This script assumes your raw data file is named "anonymous_raw_data.xlsx"
# and is located in the same directory as this script.
# Please rename your data file accordingly.

raw_data_path <- "anonymous_raw_data.xlsx"
dat_raw <- read_excel(raw_data_path)

# Select the indicator variables for LPA.
# Ensure these column names EXACTLY match your Excel file.
lpa_indicators <- dat_raw %>%
  select(Calculation, Collective, Complacency, Confidence, Constraints)

# --- Step 2: Estimate a Range of LPA Models ---
# We estimate models with 1 to 6 profiles to determine the best fit.
# This step may take a few minutes to run.
cat("Estimating LPA models for 1 to 6 profiles... Please wait.\n")

lpa_models <- lpa_indicators %>%
  estimate_profiles(n_profiles = 1:6) # tidyLPA tests multiple model types by default

# --- Step 3: Compare Model Fit and Select the Best Model ---
# We use a combination of fit indices to select the optimal number of profiles.
fit_statistics <- get_fit(lpa_models)

cat("\n--- Model Fit Statistics ---\n")
print(fit_statistics)
cat("---------------------------\n")

# How to interpret the fit statistics:
# 1. Lower AIC, BIC, and SABIC values are better. Look for the "elbow point" where these values stop decreasing sharply.
# 2. Significant p-values for LMR and BLRT (< 0.05) suggest the k-profile model is better than the k-1 profile model.
# 3. Higher Entropy (closer to 1.0) indicates better classification quality.
# Based on these criteria, the 5-profile solution was chosen as the most optimal and interpretable model.

# --- Step 4: Extract Results and Assign Profiles ---
# We extract the results from the chosen 5-profile model.
# You can change the model number if a different one was selected.
final_model <- get_profiles(lpa_models, n_profiles = 5, model = 1) # Assuming Model 1 was best for 5 profiles

# Add the profile assignments back to the original dataset.
# The new column will be named "Class".
dat_profiled <- bind_cols(dat_raw, final_model$data)

# --- Step 5: Save the Profiled Data ---
# This new file will be the input for the visualization script.
# We rename the "Class" column to "profile" for consistency.
dat_profiled <- dat_profiled %>%
  rename(profile = Class)

output_path <- "hesitancy_data_profiled.xlsx"
writexl::write_xlsx(dat_profiled, output_path)

cat(paste("\nLPA analysis complete. Profiled data saved to:", output_path, "\n"))
