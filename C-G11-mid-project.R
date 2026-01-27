# =============================================================================
# C-G11 MIDTERM PROJECT
# Title: Impact of Lifestyle Factors on Mental Health and Happiness (2024)
# Dataset: Global Mental Health & Lifestyle Survey – 3000 records
# Source: https://drive.google.com/file/d/1JWmhX5pVcoHYaa-2L40p6bhQLYbUx3qX

# List of packages required for the project
packages <- c("readr", "dplyr", "ggplot2", "corrplot", "fastDummies")

# Loop to check, install, and load packages
for (pkg in packages) {
  # 1. Check if the package is already installed
  if (!require(pkg, character.only = TRUE)) {
    # 2. If not installed, install it
    install.packages(pkg, dependencies = TRUE)
  }
  
  # 3. Load the package (will run whether it was just installed or already existed)
  library(pkg, character.only = TRUE)
}

cat("All required packages have been checked, installed (if needed), and loaded.\n")

# Load libraries

library(readr)
library(dplyr)
library(ggplot2)
library(corrplot)
library(fastDummies)

# A. DATA UNDERSTANDING ---------------------------------------------------------
cat("=== A. DATA UNDERSTANDING ===\n")

# 1. Load dataset from Google Drive
url <- "https://drive.google.com/uc?id=1JWmhX5pVcoHYaa-2L40p6bhQLYbUx3qX&export=download"
df <- read_csv(url, show_col_types = FALSE)

# 2. Clean column names properly
colnames(df) <- c("Country", "Age", "Gender", "Exercise_Level", "Diet_Type",
                  "Sleep_Hours", "Stress_Level", "Mental_Health_Condition",
                  "Work_Hours_Per_Week", "Screen_Time_Hours",
                  "Social_Interaction_Score", "Happiness_Score")

# 3. Display first few rows
cat("\n1. First 6 rows:\n")
print(head(df))

# 4. Show shape
cat("\n2. Dataset shape:\n")
cat("Rows:", nrow(df), " | Columns:", ncol(df), "\n")  # 3000 x 12

# 5. Show structure
cat("\n3. Structure:\n")
str(df)

# 6. Descriptive statistics
cat("\n4. Descriptive Statistics:\n")
print(summary(df))

# 7. Identify categorical and numerical features (MUST BE DEFINED BEFORE USE!)
categorical_features <- c("Gender", "Exercise_Level", "Diet_Type", 
                          "Stress_Level", "Mental_Health_Condition")

numerical_features <- c("Age", "Sleep_Hours", "Work_Hours_Per_Week",
                        "Screen_Time_Hours", "Social_Interaction_Score", "Happiness_Score")

cat("\n5. Features Identified:\n")
cat("Categorical (5): ", paste(categorical_features, collapse = ", "), "\n")
cat("Numerical (6):   ", paste(numerical_features, collapse = ", "), "\n")

# B. DATA EXPLORATION & VISUALIZATION -----------------------------------------
cat("\n=== B. DATA EXPLORATION & VISUALIZATION ===\n")

# 1. Univariate Analysis
ggplot(df, aes(x = Sleep_Hours)) +
  geom_histogram(binwidth = 0.5, fill = "#1f77b4", color = "black") +
  labs(title = "Distribution of Daily Sleep Hours", x = "Sleep Hours", y = "Count") +
  theme_minimal()

ggplot(df, aes(y = Screen_Time_Hours)) +
  geom_boxplot(fill = "#ff7f0e") +
  labs(title = "Boxplot of Screen Time (Outliers Visible)", y = "Screen Time (Hours)") +
  theme_minimal()

ggplot(df, aes(x = Stress_Level)) +
  geom_bar(fill = "#2ca02c") +
  labs(title = "Frequency of Stress Levels", x = "Stress Level", y = "Count") +
  theme_minimal()

# 2. Bivariate Analysis
# Correlation heatmap
cor_matrix <- cor(df %>% select(all_of(numerical_features)), use = "complete.obs")
corrplot(cor_matrix, method = "color", type = "upper", addCoef.col = "black",
         title = "Correlation Heatmap", tl.cex = 0.8,diag = FALSE)

# Scatter plot
ggplot(df, aes(x = Screen_Time_Hours, y = Happiness_Score)) +
  geom_point(alpha = 0.6, color = "#d62728") +
  geom_smooth(method = "lm", color = "black") +
  labs(title = "Screen Time vs Happiness Score") +
  theme_minimal()

# Boxplot: Mental Health vs Happiness
ggplot(df, aes(x = Mental_Health_Condition, y = Happiness_Score)) +
  geom_boxplot(fill = "#9467bd") +
  labs(title = "Happiness Score by Mental Health Condition") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# C. DATA PREPROCESSING ---------------------------------------------------------
cat("\n=== C. DATA PREPROCESSING (5 Steps) ===\n")
set.seed(123)

# STEP 1: FIRST CHECK existing missing values & outliers

cat("\nSTEP 1: Checking existing missing values and outliers...\n")
cat("Missing values before any change:\n")
print(colSums(is.na(df)))

# Check outliers in Screen_Time_Hours
Q1 <- quantile(df$Screen_Time_Hours, 0.25)
Q3 <- quantile(df$Screen_Time_Hours, 0.75)
IQR_val <- Q3 - Q1
outliers_before <- sum(df$Screen_Time_Hours > (Q3 + 1.5*IQR_val) | df$Screen_Time_Hours < (Q1 - 1.5*IQR_val))
cat("Outliers in Screen_Time_Hours (before creation):", outliers_before, "\n")

# NOW MANUALLY CREATE missing values and outliers (as required by guidelines)
cat("\nNow manually creating missing values and outliers...\n")
df$Sleep_Hours[sample(1:3000, 120)] <- NA
df$Happiness_Score[sample(1:3000, 80)] <- NA

out_idx <- sample(1:3000, 100)
df$Screen_Time_Hours[out_idx] <- 22 + runif(100, 5, 25)   # Extreme values
df$Work_Hours_Per_Week[out_idx] <- 100 + runif(100, 10, 60)

cat("Missing values created:", sum(is.na(df$Sleep_Hours)) + sum(is.na(df$Happiness_Score)), "\n")

# STEP 2: Handle Missing Values → Median Imputation
df <- df %>%
  mutate(across(where(is.numeric), ~ifelse(is.na(.), median(., na.rm = TRUE), .)))

cat("After median imputation → Total missing values:", sum(is.na(df)), "\n")

# STEP 3: Handle Outliers → IQR Capping
cap_outliers <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  pmin(pmax(x, lower), upper)
}

df <- df %>%
  mutate(across(c("Screen_Time_Hours", "Work_Hours_Per_Week"), cap_outliers))

# STEP 4: Data Conversion → One-Hot Encoding
df_encoded <- fastDummies::dummy_cols(df,
                                      select_columns = categorical_features,
                                      remove_first_dummy = TRUE)

# STEP 5: Data Transformation → Log + Standardization
df_final <- df_encoded %>%
  mutate(
    Screen_Time_Log = log1p(Screen_Time_Hours),
    Work_Hours_Log  = log1p(Work_Hours_Per_Week)
  ) %>%
  mutate(across(where(is.numeric) & !ends_with("_Log"), ~as.vector(scale(.))))

# Remove non-predictive column
df_final <- df_final %>% select(-Country)

# Save final cleaned dataset
write_csv(df_final, "C-G11_mental_health_cleaned_final.csv")

cat("Final dataset shape:", dim(df_final), "\n")