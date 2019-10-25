
##########################################################################
###                           PSC 103A                                 ###
###                         Lab Session 6                              ###
###                                                                    ###
###       Single Sample Estimation and Hypothesis Testing              ###
###                                                                    ###
###              Instructor: Anna Wysocki                              ### 
##########################################################################



# GOALS:
# 1. Hypothesis Testing using a single sample (dichotomous)
# 2. Hypothesis testing using a single sample (continuous)
#    a. z-Test
#    b. t-test

# IMPORTANT: Install this package. We are going to need it

install.packages('visualize')

# IMPORTANT: Load in this data
load("IQ.Rdata")

options(scipen= 999) # Disables scientific notation

## Hypothesis Testing using a single sample (dichotomous)
###################################################

# Let's say I have a theory that a specific coin is unfair (the probability
#  of flipping a head or a tail is something other than .5). And let's say my
#  research goal is to determine whether this coin is unfair or not. 

# How can I turn this theory into something I can test using statistics? 


### Null Hypothesis vs. Alternative Hypothesis

#  We can break this theory up into a null hypothesis (H0) and an alternative 
#  hypothesis (H1)

# The H0 is the opposite of what I want to believe
  # H0: p(heads or tails) = .5

# The H1 is generally what we believe and would like to test
   # H1 p(heads or tails) != .5 
     # Note: in R != signifies 'does not equal' 


### Testing the hypothesis 

# If you got 53 tails would you be confident saying the coin was unfair?
# What about 65? 
# 80? 
# 95? 
# How many tails would you have to get before you are ready to say- 
# this is an unfair coin? 

# Rather than trying to make this decision ourselves, we can use hypothesis
# testing to guide our choices.

# In order to understand hypothesis testing we need to go back to 
# distributions 

# We know what the distribution of a fair coin should look like. 

# If the H0 is true the distribution will look like this
library(visualize)
visualize.binom(size = 100, prob = .5)

# There's a possiblity of getting different numbers of tails (or heads!), 
# but the farther away from the population mean (in this case 50), 
# the less likely the outcome is.

# Let's calculate the probability of getting 63 tails (or more)
pbinom(q = 63, size = 100, prob = .5, lower.tail = FALSE)

# The next step is to quantify, what exactly would cause us to reject the H0. 
# In other words, how many tails would have to come up before we can are 
# ready to say- the coin is unfair. 

# To do this we define an alpha level (in psychology, typically .05). 
# If the probability of getting our result or a more extreme result
# is less than alpha (.05), then we reject the H0. 

# If the probability of getting our result or a more extreme result
# is greater than alpha (.05) then we retain the H0 

# Let's do an example 

# Let's say we flipped a coin 100 times and it came up 59 times as tails
# And I want to test the hypothesis that I am flipping an unfair coin 

# What's my H0? 
# H0: p = .5

# What's my H1? 
# H1: p != .5

# What's my alpha? 
# alpha: .05






# These are important questions to answer before doing an hypothesis test

# Now that we've answered those questions the hypothesis test is pretty 
# easy to run. Because R has a built-in function 
# binom.test(x, n, p)
    # x = number of tails 
    # n = number of flips
    # p = the probability indicated by the H0 

binom.test(x = 62, n = 100, p = .5)

# Look at the p-value. Is it less than .05? 
# If so, reject the H0. If not, retain the H0


# Now you try one. 

# Let's say we flipped a coin 500 times and it came up 270 times as tails
# And I want to test the hypothesis that I am flipping an unfair coin 

# What's my H0? 
# H0: p = .5

# What's my H1? 
# H1: p != .5

# What's my alpha? 
# alpha: .05

# Use the binom.test() function to decide whether to reject or retain the H0

binom.test(x= 369, n= 1000, p= .5)

## 2. Hypothesis Testing using a single sample (Continuous)
###########################################################


  ## Z-TEST FOR A MEAN
  ####################################################

# We can also do hypothesis tests for continuous data. 
# There are many different statistical tests that do this and which one 
# you pick depends on your data, your assumptions and/or knowledge 
# about the population, and what kind of question you are trying 
# to answer. 

# Let's say I have a class of 100 students who all take an IQ test. 
# I hypothesize the population mean of IQ scores 
# is 100 and the population standard deviation is 15. 
# We also know that IQ scores are normally distributed in the population. 

# My theory is that my students have a different level of intelligence than 
# the hypothesized population mean
. 

# The IQ scores from each of my students are saved in the object IQ
IQ

# Let's look at the mean 
mean(IQ) 

# Is it higher than the population mean? 
# Yes, but is it *meaningfully* different? 
# In other words, how do we know this difference isn't just due to chance? 

# We can use hypothesis tests to help us decide if the two means 
# (the sample and the population mean) are significantly different. 

# The first steps when doing a hypothesis test is to define the H0 and H1

# What's my H0? 
# H0: pop_mean = 100

# What's my H1?
# H1: pop_mean != 100

# Since we know the population standard deviation and since we know the 
# sampling distribution is normally distributed, we can use the z-test. 

# The steps of the z-test 
# 1- Calculate the z-score for the sample mean 
#    a. (sample_mean - population_mean)/ standard_error
#    b. standard_error = population_sd / sqrt(N)
# 2- Is the probability of obtaining this z-score
# less than our specified alpha level in either 
# of the tails?

# Let's do the z-test for our example
# First let's compute the z-score 

s_mean <- mean(IQ)
samp_z = (s_mean - 100)/(15/sqrt(100))
samp_z

# Is the probability of obtaining this z-score
# less than our specified alpha level in either 
# of the tails?

# pnorm() is a function that will give us the
# cumulative density for a normal distribution.
# We need to input q, which in this case in the
# z-score we are evaluating.

# For a two-tailed test, we need to 
# divide our alpha by 2. 

.025 > pnorm(samp_z, lower.tail = FALSE)
# Two-tailed, alpha = .05

# Let's say that for the same sample, you hypothesize
# that the population mean is actually greater than
# the hypothesized population mean (100).

# What would be the null and alternative hypotheses?

# H0: pop_mean <= 100 (less than or equal to)
# H1: pop_mean > 100

# We can use the same z-score since we still have the same sample mean
samp_z

# Finally, let's check the probability.
# We are now using a one-tailed test, which means
# that we are only interested in values in the upper
# end of the tail, so we don't divide by 2:
.05 > pnorm(samp_z, lower.tail = FALSE)
# One-tailed, alpha = .05



# YOUR TURN! 
# Conduct a one sample z-test for sample a sample with a mean IQ score of 102.
# Use the same hypothesized population values as we did before. 
# Assume an alpha level of .05 and that you think
# the IQ of your sample is greater than the 
# population mean. Start by stating your null and 
# alternative hypotheses, then compute a z-score, and
# finally check to see if the probability of obtaining
# this score or more extreme, is less than your specified 
# alpha.

# H0: pop_mean =100
# H1: pop_mean > 100

samp_z = (3 - 2)/(.5/sqrt(70))

.05 > pnorm(samp_z, lower.tail = FALSE); 

## T-TEST FOR A MEAN
######################################################################

# What if we don't know the population standard deviation? 
# In this case, we have to use the t-test. 
# It's similar to the z-test but with a couple changes that we'll highlight. 

# To caclulate a t-score we use a similar formula to the z formula except
# we subsitute the population standard deviation for the sample standard deviation

# The steps of the t-test 
# 1- Calculate the t-score for the sample mean 
#    a. (sample_mean - population_mean)/ standard_error
#    b. standard_error = sample_sd / sqrt(N)
# 2- Is the probability of obtaining this t-score
# less than our specified alpha level in either 
# of the tails?


# Again using our IQ data, let's say that I wanted to test a 
# hypothesis that this particular sample of students had an average
# IQ score that is different from the national average, 
# which is 100.


# Is this a one-tailed test or a two-tailed test?


# What is the null hypothesis?
#     H0: pop_mean = 100

# What is the alternative hypothesis?
#     H1: pop_mean != 100

# Great news, R has a built in function for the t-test
# t.test(x, mu, alternative)
  # x = the data
  # mu = the population mean 
  # alternative = specify the type of alternative hypothesis
    # "two.sided" (the default)
    # "greater" 
    # "less" 


t.test(IQ, mu = 100, alternative = "two.sided")
       

# This is the output:

# One Sample t-test

# data:  IQ
# t = 6.911, df = 99, p-value = 0.000000000473
# NOTE our t-value is positive, suggesting that our sample mean is 
# greater than the population mean 
# alternative hypothesis: true mean is not equal to 100
# 95 percent confidence interval:
#  107.7491 113.9909
# sample estimates:
#  mean of x 
# 110.87 




# Now you try! Say, we wanted to test whether our particular 
# sample of test-takers had a LOWER average IQ score
# than the national average?

# What is the new null hypothesis?
#     H0: pop_mean >= 100

# What is the new alternative hypothesis?
#     H1: pop_mean < 100


# Now to perform the test in R:
t.test(x = , mu = , alternative = )

