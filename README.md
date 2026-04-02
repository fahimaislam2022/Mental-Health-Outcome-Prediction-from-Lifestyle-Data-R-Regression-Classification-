# Mental Health Outcome Prediction from Lifestyle Data

A comprehensive R-based data science project analyzing the impact of lifestyle factors on mental health and happiness outcomes using machine learning techniques.

## 📋 Project Overview

This project analyzes a **Global Mental Health & Lifestyle Survey dataset** containing 3,000 records to understand how various lifestyle factors influence mental health conditions and happiness levels. The project implements both regression and classification models to predict mental health outcomes.

**Course:** C-G11 Midterm Project  
**Language:** R  
**Dataset Size:** 3,000 records × 12 variables

## 📊 Dataset

**Source:** [Global Mental Health & Lifestyle Survey](https://drive.google.com/file/d/1JWmhX5pVcoHYaa-2L40p6bhQLYbUx3qX)

### Features

| Category | Features |
|----------|----------|
| **Demographic** | Country, Age, Gender |
| **Lifestyle** | Exercise Level, Diet Type, Sleep Hours, Work Hours Per Week, Screen Time Hours |
| **Health & Wellness** | Stress Level, Social Interaction Score |
| **Target Variables** | Mental Health Condition, Happiness Score |

**Features (12 total):**
- **Numerical (6):** Age, Sleep Hours, Work Hours Per Week, Screen Time Hours, Social Interaction Score, Happiness Score
- **Categorical (5):** Gender, Exercise Level, Diet Type, Stress Level, Mental Health Condition

## 🔧 Installation & Requirements

### Required R Packages
```r
packages <- c("readr", "dplyr", "ggplot2", "corrplot", "fastDummies")
```

### Setup Instructions

1. Clone the repository:
```bash
git clone https://github.com/fahimaislam2022/Mental-Health-Outcome-Prediction-from-Lifestyle-Data-R-Regression-Classification-.git
cd Mental-Health-Outcome-Prediction-from-Lifestyle-Data-R-Regression-Classification-
```

2. Open R or RStudio and run:
```r
source("C-G11-mid-project.R")
```

The script automatically checks, installs (if needed), and loads all required packages.

## 📁 Project Structure

```
├── C-G11-mid-project.R                          # Main analysis script
├── C-G11_mental_health_cleaned_final.csv        # Processed dataset (output)
└── README.md                                    # This file
```

## 🔄 Project Workflow

### A. Data Understanding
- Load dataset from Google Drive
- Explore dataset shape and structure
- Display descriptive statistics
- Identify categorical and numerical features

### B. Data Exploration & Visualization
**Univariate Analysis:**
- Histogram of Sleep Hours distribution
- Boxplot of Screen Time (outlier detection)
- Frequency bar chart of Stress Levels

**Bivariate Analysis:**
- Correlation heatmap of numerical features
- Scatter plot: Screen Time vs Happiness Score
- Boxplot: Happiness by Mental Health Condition

### C. Data Preprocessing (5-Step Pipeline)

**Step 1:** Check for missing values and outliers
- Baseline assessment before modifications
- IQR-based outlier detection

**Step 2:** Handle Missing Values → **Median Imputation**
- Missing values in Sleep Hours and Happiness Score
- Median imputation preserves distribution

**Step 3:** Handle Outliers → **IQR Capping**
- Apply 1.5 × IQR rule to Screen Time and Work Hours
- Cap extreme values at upper/lower bounds

**Step 4:** Data Conversion → **One-Hot Encoding**
- Encode categorical variables using `fastDummies`
- Remove first dummy to avoid multicollinearity

**Step 5:** Data Transformation → **Log + Standardization**
- Log transformation: `log1p()` for skewed variables
- Z-score standardization for numerical features

**Output:** Cleaned dataset ready for modeling

## 📈 Key Analyses

### Correlation Analysis
- Identifies relationships between lifestyle factors and happiness
- Heatmap visualization of feature correlations

### Mental Health Patterns
- Distribution analysis by stress level
- Happiness variation across mental health conditions

### Lifestyle Factors Impact
- Screen time effects on happiness
- Sleep, exercise, and diet influence on mental health

## 💾 Output

**Generated File:**
- `C-G11_mental_health_cleaned_final.csv` - Fully preprocessed dataset with:
  - Imputed missing values
  - Capped outliers
  - One-hot encoded categorical variables
  - Log-transformed variables
  - Standardized numerical features

## 🎯 Model Implementation (Ready for Next Phase)

The cleaned data (`C-G11_mental_health_cleaned_final.csv`) serves as input for:
- **Regression Models:** Predict Happiness Score
- **Classification Models:** Predict Mental Health Condition categories

## 🔍 Key Findings

- Screen time shows negative correlation with happiness
- Sleep hours critically impact mental health outcomes
- Stress level is a strong predictor of mental health conditions
- Social interaction scores positively correlate with happiness

## 👤 Author

**Fahima Islam** (fahimaislam2022)

## 📝 Notes

- All packages are automatically installed if not present
- Random seed (123) set for reproducibility
- Missing values: 120 in Sleep Hours, 80 in Happiness Score
- Outliers: 100 extreme values created in Screen Time and Work Hours for realistic testing
- Non-predictive features (Country) removed before modeling

## 🚀 Future Work

- Implement regression models for Happiness Score prediction
- Build classification models for Mental Health Condition
- Cross-validation and hyperparameter tuning
- Feature importance analysis
- Model comparison and performance evaluation

## 📄 License

This project is part of the C-G11 course assignment.

---

**Last Updated:** 2026-04-02