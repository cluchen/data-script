# Project 1

# ------- PART 1 -------

# 1.43: Refer to the CDI data set in Appendix C.2. The number of active physicians in a CDI (Y) (V8) is expected to be related to total population (V5), number of hospital beds (V9), and total personal income (V16). Assume that first-order regression model (1.1) is appropriate for each of the three predictor variables.

# a. Regress the number of active physicians (V8) in turn on each of the three predictor variables. State the estimated regression functions.

fit = lm(V8~V5, data = CDI)
coef(summary(fit))[ ,1]
print("The estimated regression function for the relationship between Y (# of active physicians) and X1 (total population) is Y = -110.634 + .002X.")

fit = lm(V8~V9, data = CDI)
coef(summary(fit))[ ,1]
print("The estimated regression function for the relationship between Y (# of active physicians) and X2 (# of hospital beds) is Y = -95.932 + 0.743X.")

fit = lm(V8~V16, data = CDI)
coef(summary(fit))[ ,1]
print("The estimated regression function for the relationship between Y (# of active physicians) and X3 (total personal income) is Y = -48.394 + 0.131X.")

# b. Plot the three estimated regression functions and data on separate graphs. Does a linear regression relation appear to provide a good fit for each of the three predictor variables? 

plot(CDI$V5, CDI$V8, xlab = 'Total population', ylab = 'Number of active physicans', main = 'Number of active physicans vs. Total population')
abline(fit, col = 'red')

plot(CDI$V9, CDI$V8, xlab = 'Number of hospital beds', ylab = 'Number of active physicans', main = 'Number of active physicans vs. Number of hospital beds')
abline(fit, col = 'red')

plot(CDI$V16, CDI$V8, xlab = 'Total personal income', ylab = 'Number of active physicans', main = 'Number of active physicans vs. Total personal income')
abline(fit, col = 'red')

print("A linear regression relation appear to provide a good fit for each of the three predictor variables.")

# c. Calculate MSE for each of the three predictor variables. Which predictor variable leads to the smallest variability around the fitted regression line? 

fit = lm(V8~V5, data = CDI)
mse = summary(fit)$sigma^2
print(mse)

fit = lm(V8~V9, data = CDI)
mse = summary(fit)$sigma^2
print(mse)

fit = lm(V8~V16, data = CDI)
mse = summary(fit)$sigma^2
print(mse)

print("Number of hospital beds leads to the smallest variability around the fitted regression line.")

# ----------

# 1.44: Refer to the CDI data set in Appendix C.2.

# a. For each geographic region, regress per capita income (V15) in a CDI (Y) against the percentage of individuals in a county having at least a bachelor's degree (V12) (X). Assume that first-order regression model (1.1) is appropriate for each region. State the estimated regression functions.

fit = lm(V15~V12, data = subset(CDI, V17 == 1)) # ahhhH idk if this is right???? but ok google
coef(summary(fit))[ ,1]
print("The estimated regression function for the relationship between Y (per capita income) and X (percentage bachelor's degrees) is Y = 9223.8156 + 522.1588X")

fit = lm(V15~V12, data = subset(CDI, V17 == 2)) # ????
coef(summary(fit))[ ,1]
print("The estimated regression function for the relationship between Y (per capita income) and X (percentage bachelor's degrees) is Y = 13581.4052 + 238.6694X")

fit = lm(V15~V12, data = subset(CDI, V17 == 3)) # ????
coef(summary(fit))[ ,1]
print("The estimated regression function for the relationship between Y (per capita income) and X (percentage bachelor's degrees) is Y = 10529.7851 + 330.6117X")

fit = lm(V15~V12, data = subset(CDI, V17 == 4)) # ????
coef(summary(fit))[ ,1]
print("The estimated regression function for the relationship between Y (per capita income) and X (percentage bachelor's degrees) is Y = 8615.0527 + 440.3157X")

# b. Are the estimated regression functions similar for the four regions? Discuss. 

print("The estimated regression functions are around the same; B0 is between 8600 ~ 13500 and B1 is between 240 ~ 520.")

# c. Calculate MSE for each region. Is the variability around the fitted regression line approximately the same for the four regions? Discuss. 

fit = lm(V15~V12, data = subset(CDI, V17 == 1))
mse = summary(fit)$sigma^2
print(mse)

fit = lm(V15~V12, data = subset(CDI, V17 == 2))
mse = summary(fit)$sigma^2
print(mse)

fit = lm(V15~V12, data = subset(CDI, V17 == 3))
mse = summary(fit)$sigma^2
print(mse)

fit = lm(V15~V12, data = subset(CDI, V17 == 4))
mse = summary(fit)$sigma^2
print(mse)

print("Region 2 (NC) is notably smaller (MSE = 4411341) than the other regions. The other three regions are approx the same, from around 7000000 ~ 8000000.")

# ------- PART 2 -------

# 2.62: Refer to the CDI data set in Appendix C.2 and Project 1.43. Using R^2 as the criterion, which predictor variable accounts for the largest reduction in the variability in the number of active physicians? 

fit = lm(V8~V5, data = CDI)
summary(fit)$r.squared

fit = lm(V8~V9, data = CDI)
summary(fit)$r.squared

fit = lm(V8~V16, data = CDI)
summary(fit)$r.squared

print("Because X2 (# of hospital bed) is the closest r^2 value to 1.00, it accounts for the largest reduction in the variability in the number of active physicians.")

# ------- PART 3 --------

# 2.63: Obtain a separate interval estimate of Beta 1 for each region. Use a 90 percent confidence coefficient in each case. Do the regression liines for the different regions appear to have similar slopes?

# Region 1   Y = 9223.8156 + 522.1588X
fit = lm(V15~V12, data = subset(CDI, V17 == 1)) # ahhhH idk if this is right???? but ok google
coef(summary(fit))[ ,1]

confint(fit,level = 0.90)
print("The 90% confidence interval for Beta 1 is 460.5177   583.80 " )

anova(fit)


# The F statistic is 197.75 and the F test shows that there is a 2.2e-16(p-value) chance that there are Beta 1 values that are greater than the F statistic calculated. If the level of significance is 0.05, we would reject the null hypothesis that Beta 1 = 0. 

# Region 2: Y = 13581.4052 + 238.6694X
fit = lm(V15~V12, data = subset(CDI, V17 == 2)) # ????
coef(summary(fit))[ ,1]

confint(fit,level = 0.90)

print("The 90% confidence interval for Beta 1 is 193.4858   283.853")

anova(fit)

# The F statistic is 76.826 and the F test shows that there is a 3.344 e-14(p-value) chance that there are Beta 1 value that are greater than the F statistic calculated. If the level of significance is 0.05, we would reject the null hypothesis and conclude that Beta 1 is not equal to 0.

#Region 3: Y = 10529.7851 + 330.6117X
fit = lm(V15~V12, data = subset(CDI, V17 == 3)) # ????
coef(summary(fit))[ ,1]
confint(fit,level = 0.90)

print("The 90% confidence interval for Beta 1 is  285.7076   375.5158")
anova(fit)

# The F statistic is 148.49 and the F test shows that there is a 2.2e-16(p-value) chance that there are Beta 1 value that are greater than the F statistic calculated. If the level of significance is 0.05, we would reject the null hypothesis and conclude that Beta 1 is not equal to 0.

# Region 4: Y = 8615.0527 + 440.3157X
fit = lm(V15~V12, data = subset(CDI, V17 == 4)) # ????
coef(summary(fit))[ ,1]
confint(fit,level = 0.90)
print("The 90% confidence interval for Beta 1 is 364.7585   515.8729")

anova(fit)

# The F statistic is 94.195 and the F test shows that there is a 6.856e-15 chance that there are Beta 1 values that are greater than the F statistic calculated. If the level of significance is 0.05, we would reject the null hypothesis, concluding that Beta 1 is not equal to 0.


#The regression lines for different regions have different slopes and intercepts

# --------- PART 4 ---------
# In conjunction with Project 1.43. 
# Obtain the residuals and prepare a residual plot against X and a normal probability plot. 

# Total Population vs # Physicians
fit = lm(V8~V5, data = CDI)      
coef(summary(fit))[ ,1]
residuals = fit$residuals     #Obtaining residuals
plot(x=CDI$V5, y = residuals, xlab = 'Total Population', ylab='Residuals') #Residual plot
abline(h=0, col ='red')
qqplot = qqnorm(residuals)    #Normal Probability Plot
qqline(residuals, col ='red')

# Number of Hospitals vs # Physicians
fit = lm(V8~V9, data = CDI)
coef(summary(fit))[ ,1]
residuals = fit$residuals
plot(x=CDI$V9, y = residuals, xlab = 'Number of Hospitals', ylab='Residuals')
abline(h=0, col ='red')
qqplot = qqnorm(residuals)
qqline(residuals, col ='red')
print("The estimated regression function for the relationship between Y (# of active physicians) and X2 (# of hospital beds) is Y = -95.932 + 0.743X.")


# Total Personal Income vs # Physicians
fit = lm(V8~V16, data = CDI)
coef(summary(fit))[ ,1]
residuals = fit$residuals
plot(x=CDI$V16, y = residuals, xlab = 'Total Personal Income', ylab='Residuals')
abline(h=0, col ='red')
qqplot = qqnorm(residuals)
qqline(residuals, col ='red')
print("The estimated regression function for the relationship between Y (# of active physicians) and X3 (total personal income) is Y = -48.394 + 0.131X.")

# Summary: All 3 fitted regression models seem to have a randomized distribution of their residual against the predictor variable. However, the qqplot shows a graph in which most of the points fall along the middle part of the line, but the values at either extremities curve off, creating a graph with a similar shape as the function x^3. Thus, the relationship between Y (num of physicians) and each predictor variable may not be linear. This likely means that the data may include more extreme values than normally expected from a normal distribution. For example, in every predictor variable, large cities like LA seem to have larger values for every predictor variable measured. 
