# Attach lung data
library(readr)
data <- read_table("Desktop/USF/ISM 6137 - Advance Statistical Modeling/Assignment 4/LungCancer-2.txt", 
                   col_names = FALSE, skip = 14)
View(data)
str(data)
nrow(data)

#Create a patient id column
data$patientid = c(1:137)

# Rename column names
colnames(data) = c("treatment", "cell_type", "survival_days", "status", 
                   "karnofsky_score", "monthsfromdiagnosis", "age", "priorchemo", "patientid")
View(data)

## Factorize columns
#Set treatment as standard vs. test
data$treatment = factor(data$treatment, levels = c(1, 2), labels = c("Standard", "Test"))
data$treatment = relevel(data$treatment, ref = "Standard")

#Set Cell type column
data$cell_type = factor(data$cell_type, levels = c(1:4), labels = c("Squamous", "Small Cell", "Adeno", "Large Cell"))
data$cell_type = relevel(data$cell_type, ref = "Squamous")

#Set prior chmemo as No, Yes
data$priorchemo = factor(data$priorchemo, levels = c(0,10), labels = c("No", "Yes"))
data$priorchemo = relevel(data$priorchemo, ref = "No")

#Kaplan-Meier Analysis
library(survival)
summary(data$survival_days)

#Kaplan-Meier for all patients
kmall = survfit(Surv(data$survival_days,data$status) ~ data$treatment)
summary(kmall)
plot(kmall, xlab = "Days", ylab = "Survival Probability", main = "Chart 1: Survival in Standard vs. Test Treatment",
     col = c("blue", "red"), mark.time = TRUE, conf.int = TRUE)
legend("topright", legend = levels(data$treatment), col = c("blue", "red"), lty = 1)

table(data$treatment, data$priorchemo) #have enough rows to separate KM curves with treatment and prior chemo
table(data$treatment, data$priorchemo, data$cell_type) #not enough rows to separate prior chemo and cell types
table(data$treatment, data$cell_type) #some groups of a cell type and treatment have low row. Will not create seperate KM 

#Kaplan-Meir curves for no prior chemo vs. prior chemo. Prior chemo may affect future survival. 
#Subset patients with no prior chemo
nopriorchemo <- subset(data, priorchemo == "No")
kmnoprior = survfit(Surv(nopriorchemo$survival_days,nopriorchemo$status) ~ nopriorchemo$treatment)
summary(kmnoprior)
plot(kmnoprior, main = "Chart 3: Patients with no prior chemotherapy", xlab = "Days", ylab = "Survival Probability", 
     col = c("blue", "red"), mark.time = TRUE, conf.int = TRUE)
legend("topright", legend = levels(data$treatment), col = c("blue", "red"), lty = 1)

#Subset patients with prior chemo
yespriorchemo <- subset(data, priorchemo == "Yes")
kmyesprior = survfit(Surv(yespriorchemo$survival_days,yespriorchemo$status) ~ yespriorchemo$treatment)
summary(kmyesprior)
plot(kmyesprior, main = "Chart 4: Patients with prior chemotherapy", xlab = "Days", ylab = "Survival Probability", 
     col = c("blue", "red"), mark.time = TRUE, conf.int = TRUE)
legend("topright", legend = levels(data$treatment), col = c("blue", "red"), lty = 1)

#Kaplan-Meier combined with treatment type and prior chemo status
data$treatmentchemostatus <- interaction(data$treatment, data$priorchemo)  #Create new column with treatment and prior chemo
str(data$treatmentchemostatus)
levels(data$treatmentchemostatus)
kmtreatmentandchemo = survfit(Surv(data$survival_days,data$status) ~  data$treatmentchemostatus)
summary(kmtreatmentandchemo)
plot(kmtreatmentandchemo, xlab = "Days", ylab = "Survival Probability", 
     main = "Chart 2: Survival in treatment groups and prior chemotherapy groups", 
     col = 1:length(levels(data$treatmentchemostatus)), mark.time = TRUE)
legend("topright", legend = levels(data$treatmentchemostatus), 
       col = 1:length(levels(data$treatmentchemostatus)), lty = 1)

#at time points
# Survival probabilities at specific times for all patients
summary(kmall, times = c(183, 365))

# Survival probabilities for patients with no prior chemotherapy
summary(kmnoprior, times = c(183, 365))

# Survival probabilities for patients with prior chemotherapy
summary(kmyesprior, times = c(183, 365))

#Mean times
print(kmall, print.rmean=TRUE)
print(kmnoprior, print.rmean = TRUE)
print(kmyesprior, print.rmean = TRUE)

#Semi parametric models
cox1 = coxph(Surv(data$survival_days, data$status) ~ data$treatment, method = "breslow")
summary(cox1)

cox2 = coxph(Surv(data$survival_days, data$status) ~
               data$treatment * data$cell_type + data$treatment * data$priorchemo, 
               method = "breslow")
summary(cox2)

cox3 = coxph(Surv(data$survival_days, data$status) ~
               data$cell_type +
               data$monthsfromdiagnosis * data$treatment +  
               data$age * data$treatment + 
               data$priorchemo, method ="breslow")
summary(cox3)

library(stargazer)
stargazer(cox1, cox2, cox3, type="text", single.row = TRUE)
AIC(cox1, cox2, cox3) #going with cox3 model to answer questions
#log likelihood higher the better

#Parametric models
#Exponential parametric model
expmod = survreg(Surv(data$survival_days, data$status) ~
               data$cell_type +
               data$monthsfromdiagnosis * data$treatment +  
               data$age * data$treatment + 
               data$priorchemo, dist ="exponential")
summary(expmod)
exp(-coef(expmod))

#Weibull parametric model
weibull = survreg(Surv(data$survival_days, data$status) ~
                   data$cell_type +
                   data$monthsfromdiagnosis * data$treatment +  
                   data$age * data$treatment + 
                   data$priorchemo, dist ="weibull")
summary(weibull)
exp(-coef(weibull))

#LogLogistic paramteric model
loglogistic = survreg(Surv(data$survival_days, data$status) ~
                    data$cell_type +
                    data$monthsfromdiagnosis * data$treatment +  
                    data$age * data$treatment + 
                    data$priorchemo, dist ="loglogistic")
summary(loglogistic)
exp(-coef(loglogistic))

stargazer(expmod, weibull, loglogistic, type="text", single.row = TRUE)
AIC(expmod, weibull, loglogistic) #AIC lowest for expmod, picking exponential model


