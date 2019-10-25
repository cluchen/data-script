#Go through the project prompt and rubric 

#Quick review from last week
#How to read-in the data:
getwd()
setwd('/Users/Cynthia/Documents/psc103a/ICPSR_35584/DS0007')
mydata <- load("35584-0007-Data.rda")
head(mydata)
mydata <- da35584.0007
head(mydata)

#Subset the data to make it more manageable
myvars <- c("D11", "V6", "GENDER", "MARRIED", "D6A", "SOMECOLL", "D3")
newdata <- mydata[myvars]
head(newdata)

#We only want two levels, but the levels are -8, -7, 1, 2, and 3
table(newdata$V6)

#Convert the continuous variable to numeric:
newdata$D11 = as.numeric(newdata$D11)
is.numeric(newdata$D11)
?t.test
t.test(newdata$D11~newdata$V6, var.equal = T, na.action="na.exclude")

?hist 
hist(newdata$D11, main = "Distribution of Household Income (D11)", xlab = "Household Income")












table(mydata$V6)
#Visualize the labels of the levels:
str(mydata$V6)
#Subset the categorical variable:
subdata <- mydata[mydata$V6 %in% c("(1) Yes", "(2) No"), ]
table(subdata$V6)

#Convert the ordinal/continuous variable to numeric, if necessary:
str(subdata$D11)
table(subdata$D11)
subdata$D11 = as.numeric(subdata$D11)
is.numeric(subdata$D11)

?hist 
hist(mydata$D11, main = "Histogram", xlab = "Household Income")

?t.test
t.test(mydata$D11~mydata$V6, var.equal = T, na.action="na.exclude")

?hist 
hist(mydata$D11, main = "Histogram", xlab = "Household Income")

#How to use the codebook to pick your variables
#V3HRS0: How many hours did you spend in the past month working for {name of 1st organization}
#RACE_ETH: -8 is missing, -7 is missing, 1 is Spanish/Hispanic/Latino, 2 is non-Hispanic black, and 3 is non-Hispanic/non-black
#I want to recode the -8's and -7's as missing and combine 1's and 2's to a single level 

#Assumptions of an independent samples t-test:
#1: The two groups should be two unrelated (independent) groups
		#(i.e. members of one groups cannot be members of another, an individual cannot be classified as more than one category, in the context of my data you can't be both non-Hispanic/non-black and Spanish/Hispanic/Latino/non-Hispanic black)
		#One of your variables will be categorical (only two levels besides the missing data) and one will be continuous (five or more levels besides the missing data)
		#Arguments can be made that likert variables are ordinal, but for the purposes of this paper we will say they are continuous
#2: The dependent variable (residuals) must be approximately normally distributed
#3: We assume homogeneity of variance of the two unrelated groups
		#This means that the variance of each of the groups should be approximately equal in the population 

#APA format:
#Go to the website on the prompt...
#In-text citations
#On average, the sample contained people who drove under the speed limit (M = 63.00, SD = 5.43). The average speed for females was (M = 60.35, SD = 4.44) while the average speed for males was (M = 70.98, SD = 3.87).

#There was a significant effect of gender on speed, t(38) = 5.98, p = .02. 
#OR
#There was a significant effect of age on voting preference, t(38) = 5.98, p < .05.

#Don't forget that the M, SD, t, and p are italicized!! 
#There is no zero before the p value (not p = 0.02)

#How to cite sources using google scholar

#My variables:
#Continuous variable: V3HRS0
#Categorical variable: RACE_ETH
#Demographic variables:
#GENDER
#HHINCOME
#D10
#D90
#Please don't use ONLY my four demographic variables--choose your own! There are plenty more to choose from.

#Subset the data to make it more manageable
myvars <- c("V3HRS0", "V6", "GENDER", "MARRIED", "D6A", "SOMECOLL", "D3")
newdata <- mydata[myvars]
head(newdata)

#We only want two levels, but the levels are -8, -7, 1, 2, and 3
table(newdata$RACE_ETH)
levels(newdata$RACE_ETH)

#Subset the categorical variable:
subdata <- newdata[newdata$RACE_ETH %in% c("(1) Spanish, Hispanic, or Latino (D8=1)", "(2) Non-Hispanic black", "(3) Non-Hispanic, non-black"), ]
table(subdata$RACE_ETH)

#Now let's reduce the number of levels to 2
subdata2 <- subdata[subdata$RACE_ETH %in% c("(1) Spanish, Hispanic, or Latino (D8=1)", "(3) Non-Hispanic, non-black"), ]

#Let's see if that worked
table(subdata2$RACE_ETH)

#We need to make sure that r is storing our continuous variable as a numeric variable
class(subdata2$V3HRS0)

#Convert the continuous variable to numeric:
subdata2$V3HRS0 = as.numeric(subdata2$V3HRS0)
is.numeric(subdata2$V3HRS0)
?t.test
t.test(subdata2$V3HRS0~subdata2$RACE_ETH, var.equal = T, na.action="na.exclude")







