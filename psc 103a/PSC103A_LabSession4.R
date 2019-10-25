##########################################################################
###                           PSC 103A                                 ###
###                         Lab Session 4                              ###
###                                                                    ###
###          Probability and Population Distributions                  ###
###                                                                    ###
###              Instructor: Anna Wysocki                              ### 
##########################################################################


# GOALS:
# 1. Simulate from a binomial probability distribution 
#   
# 2. Simulate from a normal distribution 


# QUESTIONS BEFORE WE BEGIN?


# We've talked about different distributions (mainly normal distributions)
# In the last class assignment, you were asked to flip a coin 
# and count the number of times tails came up
# This binomial random variable (Number of tails) has a probability distribution
#   called a binomial distribution

# So the first thing we're going to do is re-do (part) of the class assignment but in R. 

# we can do this using the rbinom() function

# First argument number of flips
# Second argument (size) number of coins you are flipping each time
# Third argument (prob) probability of tails 
# 2 possible outcomes Heads, Tails (Tails = 1)

rbinom(1, size = 1, prob = .5)

# It's a random process so re-running code may give a different result (try it!)
# We can also do a sequence of flips by changing the first argument
# rather than running the same line of code over and over

x <- rbinom(100, size = 1, prob = .5)

# You can calculate the number of heads by summing the result
sum(x)


# Now that we know this function, let's try to re-do the class assignment in R

# Experiment 1
 # Question 1. Thinking about this theoretically, if you flip the coin one time, 
 # what do you think is the probability that the outcome will be TAILS

 # Question 2. Flip the coin one time and record the result (HEADS or TAILS)

rbinom(1, size = 1, prob = .5)

 # Question 3. Repeat step 2 100 times

rbinom(100, sie = 1, prob = .5)

# Experiment 2
 # What can we change to make our coin unfair? 

rbinom(100, size = 1, prob = .75)



# Let's talk a little more about the functions associated 
# with the binomial distribution
# R provides 4 functions for each distribution 
# Each have a different prefix (d, p, r, q)
# Every distribution in r has these four functions with the same prefixed
# The only thing that changes is the name of the distribution 
# rbinom() vs rnorm() generate random data from the respective distributions


# What it does                   #   prefix      #   binomial distribution
#############################################################################
# Probability density of         #   d           #   dbinom()
# Cumulative probability of      #   p           #   pbinom()
# Generate random number from    #   r           #   rbinom()
# Quantile of                    #   q           #   qbinom()
##############################################################################

# You have to specify the size and prob arguments for each of these functions
# But the first argument differs

## rbinom( n, size, prob )
# r form is a random number generator. It generates n random outcomes 

rbinom(n = 10, size = 1, prob = .5)

## dbinom( x, size, prob )
 # d form simulates the density at a specific point 
 # Another way to say this- it tells you the probability of getting that outcome


 # What's the probability of getting five tails after flipping
 # a fair coin (.50 chance of tail) 10 times?

dbinom(x = 10, size = 15, prob = .5)

 # What's the probability of getting 4 tails after flipping
 # an unfair coin (.20 chance of tail) 20 times?

dbinom(x = 4 , size = 20 , prob = .20 )

## pbinom( q, size, prob )
 # p form calculates the cumulative probability
 # You specify the value (q) and it gives you the 
 # probability of getting an outcome smaller than or equal to q

 # What's the probability of getting four or fewer tails when flipping a fair coin 20 times? 
pbinom(q = 4, size = 20, prob = .5)

 # What's the probability of getting 15 or fewer tails when flipping a fair coin 20 times? 

pbinom(q = 15 , size = 20 , prob = .5)

## qbinom( p, size, prob )
 # q form calculates the quantiles of the distribution 
 # You specify a probability value p and you get the corresponding value
 # It's basically the opposite of the p form

 # What's the 75th percentile when I flip a fair coin 20 times? 

qbinom( p = .75, size = 20, prob = .5)


## Normal Distribution
###########################################################

# When simulating from a normal distribution we use similar functions 
# as when simulating from the binomial distribution

# What it does                   #   prefix    #  normal distribution     #   binomial distribution
###################################################################################################
# Probability density of         #   d         #     dnorm()              #   dbinom()
# Cumulative probability of      #   p         #     pnorm()              #   pbinom()
# Generate random number from    #   r         #     rnorm()              #   rbinom()
# Quantile of                    #   q         #     qnorm()              #   qbinom()
###################################################################################################

# A key difference is instead of specifying values for the arguments size and prob
# We have to specify the mean and standard deviation of the distribution

# rnorm() is a function that will generate a random sample
#      from any normal distribution
# We need to input n, which is the size of our sample,
#      the mean of the distibution, and the sd of our
#      distribution
ex_data <- rnorm(n = 100, mean = 3, sd = 2)

# Let's check the mean and sd

mean(ex_data)
sd(ex_data)

# Let's use the hist() function to plot these observations
hist(rnorm(1000, 3, 2), freq = FALSE) 

# If you don't specify the mean and standard deviation the default is
  # mean = 0, sd = 1
hist(rnorm(1000), freq = F) 
 
# What if I want to change the interval widths? 
dat <- rnorm(1000)
hist(dat, freq = F, breaks = 5)
# Breaks is treated as a suggestion 

# Now 10 intervals
hist(dat, freq = F, breaks = 10)

# 25 intervals

hist(dat, freq = F, breaks = 25)

# 50 intervals
hist(dat, freq = F, breaks = 50)


# Let's go beyond the rnorm function 

## pnorm() computes the probability that a normally distributed random number
#  will be equal to or less than that number

# What's the probability that a randomly generated number is equal or less than 3 
# for a distribution with a mean of 0 and sd of 1?
pnorm(3, mean = 0, sd = 1)

# What's the probability that a randomly generated number is equal or less than 3 
# for a distribution with a mean of 4 and sd of .5?

pnorm(3, mean = 4, sd = .5)


# What if I want to know the probability that a number is *greater* than 3 for this distribution? 
 # There are two ways. 

# 1: I could subtract the above result from 1

1- pnorm(3, mean = 4, sd = .5)

# 2: Or I could add the lower.tail = FALSE argument to the function

pnorm(3, mean = 4, sd = .5, lower.tail = FALSE)

# You get the same answer ... right? 


## qnorm()
# Again, qnorm is the inverse of pnorm
# You give it a percentile and it returns the associated value

# If you have a distribution with a mean of 5 and a standard deviation of 3, 
#  What's the 50% percentile? 
qnorm(.5, mean = 5, sd = 3)

# If you have a distribution with a mean of 30 and a standard deviation of 3, 
#  What's the 70% percentile?

qnorm( , mean = , sd = )


# I've told you that pnorm() and qnorm() do the opposite things
# Let's check this. 

pnorm(31.5732, mean = 30, sd = 3)

# Does it match? 






