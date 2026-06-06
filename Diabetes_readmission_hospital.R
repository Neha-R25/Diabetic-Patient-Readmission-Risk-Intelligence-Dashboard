library(readr)
library(dplyr)
# Import the file 

diabetes <- read_csv(file.choose())

# Check Out the file 
dim(diabetes)
str(diabetes)
names(diabetes)

# Create the binary outcome 
diabetes <- diabetes %>%
  mutate(
    readmit_30 = ifelse(readmitted == "<30", 1, 0)
  )
table(diabetes$readmit_30)
prop.table(table(diabetes$readmit_30)) * 100

# See the structure of the variable
str(diabetes[, c("age",
                 "number_inpatient",
                 "number_diagnoses",
                 "time_in_hospital",
                 "readmit_30")])
# Convert age into factor
diabetes$age <- as.factor(diabetes$age)
str(diabetes$age)
model1 <- glm(
  readmit_30 ~ age +
    number_inpatient +
    number_diagnoses +
    time_in_hospital,
  data = diabetes,
  family = binomial
)

summary(model1)
exp(coef(model1))

exp(cbind(
  OR = coef(model1),
  confint(model1)
))

# Chcek the levels of age 
levels(diabetes$age)

diabetes$age <- relevel(
  diabetes$age,
  ref = "[50-60)"
)

model2 <- glm(
  readmit_30 ~ age +
    number_inpatient +
    number_diagnoses +
    time_in_hospital,
  data = diabetes,
  family = binomial
)

exp(cbind(
  OR = coef(model2),
  confint(model2)
))

write.csv(
  diabetes,
  "diabetes_readmission.csv",
  row.names = FALSE
)

library(readr)
diabetes <- read_csv(file.choose())

diabetes$readmit_30 <- ifelse(diabetes$readmitted == "<30", 1, 0)

write.csv(
  diabetes,
  "diabetes_readmission.csv",
  row.names = FALSE
)

getwd()









