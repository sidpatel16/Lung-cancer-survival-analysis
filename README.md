# Lung-cancer-survival-analysis
An R-based survival analysis of the Veteran's Administration lung cancer trial using Kaplan-Meier curves, Cox Proportional Hazards, and parametric models to evaluate treatment outcomes.

# Survival Analysis of the Veteran's Administration Lung Cancer Trial[cite: 1, 3]

An end-to-end biostatistical evaluation comparing survival outcomes between standard chemotherapy and a novel experimental drug in 137 patients with advanced, inoperable lung cancer[cite: 1, 3]. 

---

## Executive Summary (Clinical Perspective)[cite: 1, 3]
This project evaluates whether combining standard chemotherapy with a test drug improves patient survival compared to standard chemotherapy alone[cite: 1, 3]. 

* **Primary Finding:** Overlapping 95% confidence intervals across Kaplan-Meier estimates indicate that differences in survival between the standard and test treatment groups were not statistically significant.
* **Initial vs. Late Treatment Effects:** Standard treatment showed a higher survival probability during initial days, whereas the test treatment group exhibited higher survival probability as days progressed[cite: 1]. This suggests the test drug's effects may be low initially but increase over time[cite: 1].
* **Impact of Prior Chemotherapy:** When separating patients by prior chemotherapy status, survival curves continued to overlap across treatment arms, indicating no statistically significant difference[cite: 1].
* **Prognostic Covariates:** Semi-parametric (Cox Proportional Hazards) and parametric models demonstrated that patient Age and Months from Diagnosis had no meaningful or statistically significant impact on survival, regardless of treatment[cite: 1].
* **Clinical Recommendation:** Further investigation with larger sample sizes is recommended to explore treatment efficacy isolated by specific lung cancer cell types[cite: 1].

---

## Data & Methodology[cite: 1, 3]

### Dataset Overview[cite: 1, 3]
The dataset tracks 137 patients with advanced, inoperable lung cancer from the Veteran's Administration Lung Cancer Trial[cite: 1, 3]. 
* **Primary Endpoint:** Survival in days until death (status dead) or study dropout/end of study (status censored)[cite: 1, 4].
* **Evaluated Covariates:** Treatment type (Standard vs. Test), lung cancer cell type (Squamous, Small Cell, Adeno, Large Cell), Karnofsky performance score, months from diagnosis, age in years, and prior chemotherapy status (No vs. Yes)[cite: 1, 4].

### Analytical Pipeline[cite: 1, 2]
* **Kaplan-Meier Curves:** Non-parametric estimation of survival probabilities over time to compare treatment arms and prior chemotherapy subgroups[cite: 1].
* **Semi-Parametric Modeling (Cox Proportional Hazards):** Evaluated hazard ratios and covariate interactions without baseline distribution assumptions[cite: 1]. Model selection was optimized using Akaike Information Criterion (AIC).
* **Parametric Survival Modeling:** Fitted Exponential, Weibull, and Log-Logistic distributions to compare model fits and estimate survival under distributional assumptions[cite: 1, 2]. The Exponential model achieved the lowest AIC and was selected as the optimal parametric fit.

---

## Longitudinal Survival Probabilities[cite: 1]

Kaplan-Meier survival probability estimates evaluated at 6-month (183 days) and 1-year (365 days) milestones show no statistically significant differences[cite: 1]:

| Patient Cohort | 6-Month Survival (183 Days) | 1-Year Survival (365 Days) |
| :--- | :---: | :---: |
| **All Patients (Standard Chemotherapy)**[cite: 1] | 21.20%[cite: 1] | 7.10%[cite: 1] |
| **All Patients (Test Treatment)**[cite: 1] | 23.30%[cite: 1] | 11.00%[cite: 1] |
| **No Prior Chemotherapy (Standard)**[cite: 1] | 21.51%[cite: 1] | 8.07%[cite: 1] |
| **No Prior Chemotherapy (Test)**[cite: 1] | 18.31%[cite: 1] | 9.16%[cite: 1] |
| **Prior Chemotherapy (Standard)**[cite: 1] | 20.63%[cite: 1] | 5.16%[cite: 1] |
| **Prior Chemotherapy (Test)**[cite: 1] | 36.10%[cite: 1] | 16.00%[cite: 1] |

---

## Restricted Mean Survival Times (RMST)[cite: 1]

Restricted mean survival days calculated as the average survival time up to the longest observed time in each group[cite: 1]:

* **All Patients:** Standard treatment averaged 124 days (highest observed: 999 days) compared to 142 days for the test treatment[cite: 1].
* **No Prior Chemotherapy:** Standard treatment averaged 131 days (highest observed: 587 days) compared to 110 days for the test treatment[cite: 1].
* **Prior Chemotherapy:** Standard treatment averaged 109 days (highest observed: 999 days) compared to 243 days for the test treatment[cite: 1].

---

## Covariate Hazard Insights (Cox Proportional Hazards)[cite: 1]

Evaluation of marginal covariate effects on the hazard of death using the optimal semi-parametric model[cite: 1, 2]:

* **Patient Age:**
  * **Standard Treatment:** The hazard rate was 1.0051 ($95\% \text{ CI}: 0.9810–1.030, p = 0.68$)[cite: 1]. Each additional year of age was associated with a 0.51% increase in the hazard of death[cite: 1].
  * **Test Treatment:** The hazard rate was 0.9988 ($95\% \text{ CI}: 0.9594–1.040, p = 0.953$)[cite: 1]. Each additional year of age was associated with a 0.12% decrease in the hazard of death compared to standard treatment[cite: 1].
* **Months from Diagnosis:**
  * **Standard Treatment:** The hazard rate was 1.013 ($95\% \text{ CI}: 0.958–1.03, p = 0.44$)[cite: 1]. Each additional month from diagnosis was associated with a 1.3% increase in the hazard of death[cite: 1].
  * **Test Treatment:** The hazard rate was 0.9954 ($95\% \text{ CI}: 0.958–1.034, p = 0.81$)[cite: 1]. Each additional month from diagnosis was associated with a 0.46% decrease in the hazard of death compared to standard treatment[cite: 1].

---

## Repository Structure & Local Execution

```text
├── data/
│   └── LungCancer-2.txt             # Raw trial dataset[cite: 2, 4]
├── scripts/
│   └── survival_analysis.R          # R script for data cleaning, KM curves, Cox PH, and parametric models
├── outputs/
│   ├── figures/                     # Exported Kaplan-Meier survival plots[cite: 1]
│   └── report_medical_audience.pdf  # Clinical executive report[cite: 1, 3]
└── README.md                        # Project documentation
