# Exercise 3c Sanboxing:
# Specs: ON same graph of b, plot cdf for 2 diff continuous distributions (let's use chi^2 and F)

# Reiteration of Exercise 3b:

e_shots_game <- 29
games <- 82
e_shots_season <- e_shots_game * games

# trying to find the probability of getting more than 2400 shots per season...
# P(X>=2400) = P(X=0) + ... + P(X=2399)
interesting_outcome <- 2400
complement <- function(){
    total_probability <- 0
        for (x in 0:(interesting_outcome-1)) {
            total_probability <- total_probability + dpois(x, e_shots_season)
    }
    return(total_probability)
}

p <- 1 - complement()
print(p)

# At this point, we have the probability of the interesting outcome of scoring >= 2400 per season.

