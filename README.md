# Lung-cancer-survival-analysis
An R-based survival analysis of the Veteran's Administration lung cancer trial using Kaplan-Meier curves, Cox Proportional Hazards, and parametric models to evaluate treatment outcomes.

# Survival Analysis of the Veteran's Administration Lung Cancer Trial

An end-to-end biostatistical evaluation comparing survival outcomes between standard chemotherapy and a novel experimental drug in 137 patients with advanced, inoperable lung cancer. 

---

## Executive Summary (Clinical Perspective)
This project evaluates whether combining standard chemotherapy with a test drug improves patient survival compared to standard chemotherapy alone. 

* **Primary Finding:** Overlapping 95% confidence intervals across Kaplan-Meier estimates indicate that differences in survival between the standard and test treatment groups were not statistically significant.
* **Initial vs. Late Treatment Effects:** Standard treatment showed a higher survival probability during initial days, whereas the test treatment group exhibited higher survival probability as days progressed. This suggests the test drug's effects may be low initially but increase over time.
* **Impact of Prior Chemotherapy:** When separating patients by prior chemotherapy status, survival curves continued to overlap across treatment arms, indicating no statistically significant difference.
* **Prognostic Covariates:** Semi-parametric (Cox Proportional Hazards) and parametric models demonstrated that patient Age and Months from Diagnosis had no meaningful or statistically significant impact on survival, regardless of treatment.
* **Clinical Recommendation:** Further investigation with larger sample sizes is recommended to explore treatment efficacy isolated by specific lung cancer cell types.

---

## Data & Methodology

### Dataset Overview
The dataset tracks 137 patients with advanced, inoperable lung cancer from the Veteran's Administration Lung Cancer Trial. 
* **Primary Endpoint:** Survival in days until death (status dead) or study dropout/end of study (status censored).
* **Evaluated Covariates:** Treatment type (Standard vs. Test), lung cancer cell type (Squamous, Small Cell, Adeno, Large Cell), Karnofsky performance score, months from diagnosis, age in years, and prior chemotherapy status (No vs. Yes).

### Analytical Pipeline
* **Kaplan-Meier Curves:** Non-parametric estimation of survival probabilities over time to compare treatment arms and prior chemotherapy subgroups.
* **Semi-Parametric Modeling (Cox Proportional Hazards):** Evaluated hazard ratios and covariate interactions without baseline distribution assumptions. Model selection was optimized using Akaike Information Criterion (AIC).
* **Parametric Survival Modeling:** Fitted Exponential, Weibull, and Log-Logistic distributions to compare model fits and estimate survival under distributional assumptions. The Exponential model achieved the lowest AIC and was selected as the optimal parametric fit.

---

## Longitudinal Survival Probabilities

Kaplan-Meier survival probability estimates evaluated at 6-month (183 days) and 1-year (365 days) milestones show no statistically significant differences:

| Patient Cohort | 6-Month Survival (183 Days) | 1-Year Survival (365 Days) |
| :--- | :---: | :---: |
| **All Patients (Standard Chemotherapy)** | 21.20% | 7.10% |
| **All Patients (Test Treatment)** | 23.30% | 11.00% |
| **No Prior Chemotherapy (Standard)** | 21.51% | 8.07% |
| **No Prior Chemotherapy (Test)** | 18.31% | 9.16% |
| **Prior Chemotherapy (Standard)** | 20.63% | 5.16% |
| **Prior Chemotherapy (Test)** | 36.10% | 16.00% |

---

## Restricted Mean Survival Times (RMST)

Restricted mean survival days calculated as the average survival time up to the longest observed time in each group:

* **All Patients:** Standard treatment averaged 124 days (highest observed: 999 days) compared to 142 days for the test treatment.
* **No Prior Chemotherapy:** Standard treatment averaged 131 days (highest observed: 587 days) compared to 110 days for the test treatment.
* **Prior Chemotherapy:** Standard treatment averaged 109 days (highest observed: 999 days) compared to 243 days for the test treatment.

---

## Covariate Hazard Insights (Cox Proportional Hazards)

Evaluation of marginal covariate effects on the hazard of death using the optimal semi-parametric model:

* **Patient Age:**
  * **Standard Treatment:** The hazard rate was 1.0051 (95% CI: 0.9810–1.030, p = 0.68). Each additional year of age was associated with a 0.51% increase in the hazard of death.
  * **Test Treatment:** The hazard rate was 0.9988 (95% CI: 0.9594–1.040, p = 0.953). Each additional year of age was associated with a 0.12% decrease in the hazard of death compared to standard treatment.
* **Months from Diagnosis:**
  * **Standard Treatment:** The hazard rate was 1.013 (95% CI: 0.958–1.03, p = 0.44). Each additional month from diagnosis was associated with a 1.3% increase in the hazard of death.
  * **Test Treatment:** The hazard rate was 0.9954 (95% CI: 0.958–1.034, p = 0.81). Each additional month from diagnosis was associated with a 0.46% decrease in the hazard of death compared to standard treatment.

---

## Repository Structure & Local Execution

```text
├── data/
│   └── LungCancer-2.txt             # Raw trial dataset
├── scripts/
│   └── survival_analysis.R          # R script for data cleaning, KM curves, Cox PH, and parametric models
├── outputs/
│   ├── figures/                     # Exported Kaplan-Meier survival plots
│   └── report_medical_audience.pdf  # Clinical executive report
└── README.md                        # Project documentation
