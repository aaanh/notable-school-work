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
# pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, 
#                ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, 
#                stringr, tidyr) 

### Exercise 1: Simulating Probabilities

# (a) Rolling a die
#(i) 12-sided die, 500 times, pie chart 

die <- (1:12)
dieRoll <- sample(die, 500, replace=TRUE)
tb <- table(dieRoll)
piepercent <- round(100*dieRoll/sum(dieRoll), 1)
pie(tb, labels=(1:12), radius=1, col=rainbow(12))

# (ii) 12-sided die, 500 times, pie chart, 1 is x3 more likely

die <- (1:12)
probability <- c(0.3, rep(0.1, 11))
dieRoll <- sample(die,500,replace=TRUE, prob=probability)
tb <- table(dieRoll)
pie(tb, labels=(1:12), radius=1, col=rainbow(12))          

# (iii) 2x(12-sided dice), 10000 times, P(sum=10)=?

die <- (1:12)
fair_prob <- rep(0.1,12)
dieRoll1 <- sample(die, 10000, replace=TRUE, prob=fair_prob)
dieRoll2 <- sample(die, 10000, replace=TRUE, prob=fair_prob)
sumn <- function(){
  counter <- 0
  for (i in 1:10000){
    if ((dieRoll1[i] + dieRoll2[i]) == 10){
      counter = counter + 1
    }
    i = i + 1
  }
  return(counter)
}
desiredoutcomes <- sumn()
estprob <- c(desiredoutcomes/10000)
theoprob <- 0.0625
perror <- (abs(estprob-theoprob))/mean(estprob,theoprob)*100
cat('Estimated probability (experimental): ', estprob, '\n')
cat('Theoretical probability: ', theoprob,'\n')
cat('Percentage error: ', perror, '\n')
cat(rep('\n',5))

###############################

# (b) Playing the lottery

# 4 numbers
play_lotto <- function(){
  n <- 0
  ticket <- sort(c(6,9,4,2)) # here
  draw <- c(0,0,0,0) # init vect that will contain the numbers drawn
  while (!all(ticket==sort(draw))){
    n <- n+1
    draw <- sample(1:49, 4, replace=FALSE)
    print(sort(draw))
  }
  return(n)
}

total_draws <- play_lotto() # assign return value to a var

# Assume that one year has 52 weeks and leap years are not accounted for.
# Playing once per week -> total_plays / weeks
weeks <- 52
price_ticket <- 3
jackpot <- 16*10^6

cat('Number of total draws: ', total_draws, '\n') # print that var
cat('Number of years before winning: ', total_draws/weeks, '\n') # print number of years before winning
cat('Net earning: ', (jackpot - total_draws*price_ticket), '\n') # print net earning

###########

# 6 numbers
play_lotto <- function(){
  n <- 0
  ticket <- sort(c(6,9,4,2,24,7)) # here
  draw <- c(0,0,0,0,0,0) # init vect that will contain the numbers drawn
  while (!all(ticket==sort(draw))){
    n <- n+1
    draw <- sample(1:49, 6, replace=FALSE)
    print(sort(draw))
  }
  return(n)
}

total_draws <- play_lotto() # assign return value to a var

# Assume that one year has 52 weeks and leap years are not accounted for.
# Playing once per week -> total_plays / weeks
weeks <- 52
price_ticket <- 3
jackpot <- 16*10^6

cat('Number of total draws: ', total_draws) # print that var
cat('Number of years before winning: ', total_draws/weeks) # print number of years before winning
cat('Net earning: ', (jackpot - total_draws*price_ticket)) # print net earning

###########################

# Clear screen
cat('\014')