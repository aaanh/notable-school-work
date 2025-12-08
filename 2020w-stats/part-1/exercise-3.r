# Nguyen Hoang Anh
# John Abbott College, Montreal, CANADA.
# Github: https://github.com/hirumaakane-ha/r-project-2019
# License: MIT License
# Course: Statistics DDD
# Instructor: Luiz T. Kazuo
# This R program and its repository on Github is a course project.

# Prerequisites
## Details can be found in README.md

# Install & load pacman
install.packages("pacman")
require(pacman)
# Use pacman to install and require other packages
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, 
               ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, 
               stringr, tidyr)

###### Exercise 3: Probability Distribution
# This exercise deals with binomial distribution and various other distributions

# (a) Kirkland Cups problem with hypergeometric distribution
total_cups <- 33357600
good_cups <- total_cups/6 # winning cups
bad_cups <- total_cups - good_cups # non-winning cups
kirkland_cups <- 8000 # cups given to kirkland
desired_cups <- 1300 # desired cups to win

cat("dhyper (quantile only) = ", dhyper(desired_cups, good_cups, bad_cups, kirkland_cups))

cat("phyper (cumulative) = ", phyper(desired_cups, good_cups, bad_cups, kirkland_cups))

# (b) Hockey problem with Poisson distribution
e_shots_game <- 29
games <- 82
e_shots_season <- e_shots_game * games

# trying to find the probability of getting more than 2400 shots per season...
# P(X>=2400) = P(X=0) + ... + P(X=2399)
interesting_outcome <- 2400
complement <- function(){
    total_probability <- 0
        for (x in 0:(interesting_outcome)) {
            total_probability <- total_probability + dpois(x, e_shots_season)
    }
    return(total_probability)
}

# or alternatively, using the cdf function ppois(x,lambda,lower.tail):
cat('The probability is: ', ppois(2400, lambda = 29*82, lower.tail = FALSE), '\n')

p <- 1 - complement()
print(p)
plot(ppois(1:2400, lambda = 29*82, lower.tail = FALSE), type='line')

# (c) Plotting the cdf for X^2 and Normal Distribution
xlabel <- "Value of X"
ylabel <- "Density of Probability"
maintitle <- "The probability of obtaining a corresponding x value with probability y of a normal distribution and chi-squared distribution"
plot(pchisq(-1:15, df=1), type="line", col="red", xlab=xlabel, ylab=ylabel, sub=maintitle,font.sub=2)
lines(pnorm(-1:15, mean = 3, sd = 4), col="blue")

# Clear screen
cat('\014')