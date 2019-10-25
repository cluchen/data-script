
##########################################################################
###                           PSC 103A                                 ###
###                         Lab Session 8                              ###
###                                                                    ###
###               Independent and Dependent T-Tests                    ###
###                                                                    ###
###                    Instructor: Anna Wysocki                        ### 
##########################################################################



# GOALS:
# 1. Independent T-Test
# 3. Checking Assumptions
# 2. Dependent T-Test

# IMPORTANT: Install these packages. We are going to need it

install.packages('car')
install.packages('psych')

# IMPORTANT: Load in this data
# Remember to set your working directory to the same **FOLDER** 
# that you downloaded your data to. 

load("IG_data.rda")
load("DG_data.rda")

options(scipen= 999) # Disables scientific notation

## The independent samples t-test 
###################################################

# Last week we talked about the one sample t-test 
# We use the one-sample t-test when 
#  1) the population standard deviation is unknown
#  2) the sampling distribution is normally distributed
#  3) we have one group that we're trying to compare to the population 
#      (this one only applies to the one-sample t-test)

# But this test is rarely used. It's more common to have two groups of observations. 
# We measure both groups on something, and we want to compare the groups. 

# In this situation, we want to answer- Do the two groups have the same population mean? 

# Let's use an example. 

# Let's imagine a professor wants to know if listening to music while studying affects student learning. 
# So he randomly assigns the students in his class to two groups. Group 1: listens to music while studying for exam 1. 
# Group 2: does not listen to music while studying for exam 1. He decides that he is going to compare students on their 
# exam 1 grade to see if listening to music while studying changes exam grades. 

# We can use the independent t-test to answer this question. 

# Let's look at the data

head(IG_data)
dim(IG_data)

# We have two variables: music and grade
  # music: yes = listened to music while studying
  #        no = did not listen to music while studying 
  # grade: student grade on exam 1 

# Before we do any tests. Let's explore our data
# First, let's calculate the mean and standard deviation for *each* group

library(psych)
describeBy(x = IG_data$grade, # What variable do you want to use to calculate the mean and sd? 
           group = IG_data$music) # What variable do you want to group by? 

# Let's move on to the test
# Step 1
  # What's our H0? 
    # pop_mean_g1 = pop_mean_g2

  # What's our H1? 
    # pop_mean_g1 != pop_mean_g2

# Step 2 
  # Check Assumptions (we'll come back to that later)

# Step 3
  # Carry out the independent t-test 

# The equation is 
   # t = (sample_mean1 - sample_mean2)/ standard_error 
   # But we won't be calculating the independent t-test by hand (at least in this lab)

# We'll be using the t.test() function (this is the same function we used for the one sample 
#                                        t test, but we'll be changing a couple things so R
#                                        knows that we have two independent groups)


t.test(formula = grade, music, # outcome variable ~ grouping variable 
       data = IG_data,  # dataframe with the variables
       var.equal = TRUE) # do the two groups have equal variance? We'll talk about this in a bit.  

## This is the output ################################################################################
  # Two Sample t-test

# data:  grade by music   ## This tells us that we broke up the variable grade by grouping 
                          ## it based on the value in music

# t = -0.50948, df = 68, p-value = 0.6121  ## This is the most important line. It tells us
                                           ## the information needed to reject or retain the H0 
                                           ## t gives us our t-score. df gives us our degree of 
                                           ## freedom. and p-value is what we compare to alpha
                                           ## our p-value is .61 and we have a two-tailed test. 
                                           ## Can we reject the H0? 

# alternative hypothesis: true difference in means is not equal to 0 

# 95 percent confidence interval: ## Important: our confidence interval is not based on the mean
#  -6.318624  3.748338            ## it is based on differences between mean (sample_mean1 - sample_mean2)

# sample estimates:
#  mean in group no mean in group yes 
# 73.69743          74.98257      ## This breaks down the mean for each group 

# End output
######################################################################################################

# How could we write up these results?

# The mean grade for students who listened to music was 74.98% (std dev = 10.28), whereas the mean in
# for students who did not listen to music was 73.70% (std dev = 10.82). A independent samples t-test showed
# that this 1.28 % difference was not significant (t(68) = -.51, p = .61, CI_95 = [-6.32, 3.75])
#  suggesting that there is not a genuine difference in learning outcomes across groups. 


### Assumptions of the independent t-test. 
#######################################################################################################
  # Assumption 1: Normality- We assume both groups are normally distributed (We can test this)
  # Assumption 2: Independence- Observations are independently sampled. Observations in one group
  #               are independent of those in the second group. (We can't test for this-- it's 
  #                                                              about study design)
  # Assumption 3: Equal variances (or homogeneity of variance) in both groups (We can test this)


# Let's start with Assumption 3

# What if we don't have equal variances across groups? 
# There's another t-test called the Welch's test that doesn't assume equal variances

# We can use the same t.test() function, but we change one value in the function... can you guess which one? 

t.test(formula = grade ~ music, # outcome variable ~ grouping variable 
       data = IG_data,  # dataframe with the variables
       var.equal = FALSE)

# Let's look at the results, and compare them to the first t-test we did. 
# Why are they the same? 

# The thing is... when the variances are equal (so when the assumption is *not* violated) the results
# of the two t-tests are the same. 
# It is only when the assumption is violated that they give different results. 

# For this reason many people say to just use the Welch's t-test. 

# Let's move on to Assumption 1: Normality 
# We've already talked about qq-plots in class, and you've calculated them by hand
# Now I'm going to show you how to use a function in R to create them. 

library(car)

qqPlot(x = IG_data$grade)

# Normally distributed? 


### The paired-samples t-test
#######################################################################################################

# So today we've looked at two t-tests
#   One assumed equal variance between groups
#   the other did not. 
#   BUT *both* assumed that the two groups were independent of each other. 


# What if that assumption is not true? 


# Let's go back to our first example. 
# Imagine this professor is not satisfied with the first study they did (dividing their class into 
#                                                                     two groups and comparing
#                                                                     students' exam scores)
# So the next quarter, they decide to try again. This time with a different design. Instead of 
# randomly assigning students to listen to music or not listen to music while studying, *all* 
# students did not listen to music while studying for exam 1. Then *all* students listened 
# to music while studying for exam 2. The professor plans to compare the scores from exam 1
# and exam 2, to try and figure out if music impacts studying. 


# Is the assumption of independence violated in this study? 
# Why? 

# Because of this, we can no longer use the independent t-test, but we *can* use the
# paired samples t-test

# Let's look at the data for this example

head(DG_data)
dim(DG_data)

# We have 3 variables
  # student: gives an id for each student
  # exam 1: exam 1 grades for all students 
  #  (exam where no one listened to music while studying)
  # exam 2: exam 2 grades for all students
  #  (exam where everyone listened to music while studying)

# Let's look at the descriptives of this data 

describe(DG_data) # We don't use the describeBy() function because we are 
                  # grouping the data before calculating the mean or sd

# Before we run the test, let's check if the assumptions of the test hold. 

qqPlot(DG_data$exam1)
qqPlot(DG_data$exam2)

# What's the H0? 
  # H0: difference_in_means = 0
# What's the H1? 
  # H1: difference_in_means != 0 

# Now let's do the test. 
# We still use the t.test() function, but the information we give it is different 

t.test(x= DG_data$exam1, y = DG_data$exam2, # We give R the two variables to compare, order doesn't matter. 
       paired = FALSE) # This is important! It let's R know that the groups are dependent 

# We're going to interpret the output the same way we interpreted the independent t-test 
# We can also write up the results in the same way. 

a = c(24, 26, 25, 26, 26, 25)
b = c(17, 19, 20, 21, 23, 21)
mean(a)
sd(a)
mean(b)
sd(b)


g1 = c(45, 38, 52, 48, 25, 39, 51, 46, 55, 46)
g2 = c(34, 22, 15, 27, 37, 41, 24, 19, 26, 36)
IG_data <- cbind(g1, g2)

describeBy(x = IG_data$g1, # What variable do you want to use to calculate the mean and sd? 
           group = IG_data$g2) # What variable do you want to group by? 

mean_o = mean(g1)
sd_o = sd(g1)
mean_y = mean(g2)
sd_y = sd(g2)
sd_o
sd_y

table(mean_o, sd_o, mean_y, sd_y)

t.test(formula = g1, g2, # outcome variable ~ grouping variable 
       data = IG_data,  # dataframe with the variables
       var.equal = FALSE) 

ga = c(26, 15, 8, 44, 26, 13, 38, 24, 17, 29)
gb = c(20, 4, 9, 36, 20, 3, 25, 10, 6, 14)
REM_data <- cbind(ga, gb)

mean_d = mean(ga)
sd_d = sd(ga)
mean_c = mean(gb)
sd_c = sd(gb)

table(mean_d, sd_d, mean_c, sd_c)

t.test(x= ga, y = gb, # We give R the two variables to compare, order doesn't matter. 
       paired = TRUE) # This is important! It let's R know that the groups are dependent 














